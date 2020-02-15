


%%

[filename, pathname] = uigetfile( ...
    {'*.tif*;*.png;*.jpg;*.svs;*.scn', 'All Image Files (*.tif*, *.png, *.jpg, *.svs, *.scn)';
    '*.tif*','TIFF images (*.tif, *.tiff)'; ...
    '*.png','PNG images (*.png)'; ...
    '*.jpg','JPG images (*.jpg)'; ...
    '*.svs','SVS images (*.svs)'; ...
    '*.scn','SCN images (*.scn)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Pick Image');

I1info=imfinfo([pathname filename]);
for i=1:numel(I1info),pageinfo1{i}=['Page ' num2str(i) ': ' num2str(I1info(i).Height) ' x ' num2str(I1info(i).Width)];end
fprintf('done.\n');
fname=[pathname filename];
if numel(I1info)>1
    %[s,v]=listdlg('Name','Choose Level','PromptString','Select a page for Roi Discovery:','SelectionMode','single','ListSize',[170 120],'ListString',pageinfo1); drawnow;
   % if ~v, guidata(hObject, handles); return; end
    s=3;
    fprintf('Reading page %g of image 1... ',s);
    io=imread(fname,s);
    fprintf('done.\n');
else
    fprintf('Image doesnt have any pages!\n');
end
status=mkdir(filename(1:end-4));
newfileName=sprintf('%s',filename(1:end-4));

%roi yi otomatik secilebilir yap. for dongusu icinde image  bastan sona
%taransın
figure,imshow(io)
h=imrect;
roi = wait(h);

%[xmin ymin width height]. 

%[s2,v2]=listdlg('Name','Choose Level','PromptString','Select a page for ROI extraction:','SelectionMode','single','ListSize',[170 120],'ListString',pageinfo1); drawnow;
s2=3;
%if ~v, guidata(hObject, handles); return; end
%I1info(s2).Height=2048;
%I1info(s2).Width=1536;
%i=0;

%while i<I1info(s).Height
%    j=0;
%    while j<I1info(s).Width
hratio=(I1info(s2).Height)/I1info(s).Height;
wratio=(I1info(s2).Width)/I1info(s).Width;

roi(2:2:4)=roi(2:2:4)*hratio;
roi(1:2:3)=roi(1:2:3)*wratio;

%%
Rows=[roi(2) roi(2)+roi(4)];
Cols=[roi(1) roi(1)+roi(3)];
io_roi=imread(fname,'Index',s2,'PixelRegion',{Rows,Cols});

imwrite(io_roi,sprintf('%s_%d_%f_%f.tif',fname(1:end-4),s2,roi(2),roi(1)));
    j=j+1536;

%    end
    i=i+2048;

% buraya kadar devam edecek for dongusu.
%end
%fabric = imread();
fabric=io_roi;
imshow(fabric)
title('Lbokuma')
load regioncoordinates;

nColors = 6;
sample_regions = false([size(fabric,1) size(fabric,2) nColors]);

for count = 1:nColors
  sample_regions(:,:,count) = roipoly(fabric,region_coordinates(:,1,count), ...
                                      region_coordinates(:,2,count));
end

lab_fabric = rgb2lab(fabric);
a = lab_fabric(:,:,2);
b = lab_fabric(:,:,3);
color_markers = zeros([nColors, 2]);

for count = 1:nColors
  color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
 % color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end
fprintf('[%0.3f,%0.3f] \n',color_markers(2,1),color_markers(2,2));
color_labels = 0:nColors-1;
a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);
for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^20 + ...
                      (b - color_markers(count,2)).^2 ).^0.5;
end

[~,label] = min(distance,[],3);
label = color_labels(label);
clear distance;
rgb_label = repmat(label,[1 1 3]);
segmented_images = zeros([size(fabric), nColors],'uint8');

for count = 1:nColors
  color = fabric;
  color(rgb_label ~= color_labels(count)) = 0;
  segmented_images(:,:,:,count) = color;
  imwrite(imresize(color,[2048,1536]),sprintf('%d_%d_%f_%f.tif',count,s2,roi(2),roi(1)));
  A = rand(10000);
end 
montage({segmented_images(:,:,:,1),segmented_images(:,:,:,2),segmented_images(:,:,:,3),segmented_images(:,:,:,4),segmented_images(:,:,:,5),segmented_images(:,:,:,6)});
title("Discrete colors")
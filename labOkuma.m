fabric = imread('01.tif');
imshow(fabric)
title('Lbokuma')
load regioncoordinates;

nColors = 4;
sample_regions = false([size(fabric,1) size(fabric,2) nColors]);
for count = 1:nColors
  sample_regions(:,:,count) = roipoly(fabric,region_coordinates(:,1,count), ...
                                      region_coordinates(:,2,count));
end

lab_fabric = rgb2lab(fabric);
a = lab_fabric(:,:,1);
b = im2single(a);
color_markers = zeros(size(fabric));

for count = 1:nColors
  color_markers(count,1) = mean2((sample_regions(:,:,count)));
  imshow((sample_regions(:,:,count)));
end
imshow(color_markers,[]);

fprintf('[%0.3f,%0.3f] \n',color_markers(2,1),color_markers(2,2));
color_labels = 0:nColors-1;
a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);
for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
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
  %imwrite(imresize(color,[2048,1536]),sprintf('%d_%d_%f_%f.tif',count,s2,roi(2),roi(1)));
   
end
montage({segmented_images(:,:,:,1),segmented_images(:,:,:,2),segmented_images(:,:,:,3),segmented_images(:,:,:,4)});
title("Discrete colors")



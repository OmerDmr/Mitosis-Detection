
image_folder = '/home/omer/proje/01';
filenames = dir(fullfile(image_folder, '*.jpg'));
 total_images = numel(filenames);
 total_images
 outFolder='/home/omer/proje/01-out';
     if ~exist(outFolder, 'dir')
       mkdir(outFolder);
     end 
 
 for i = 1:total_images
  full_name= fullfile(image_folder, filenames(i).name);
  our_images = imread(full_name);
  gray=rgb2gray(our_images);

 h=fspecial('average', [3 3]);
gray= imfilter(gray, h);
 B=strel('disk',5);
 D=imclose(gray,B);
 D=imopen(D,B);
 
 hUnsharpFiltresi=fspecial('unsharp');
 
 filtrImage = imfilter(D,hUnsharpFiltresi);
for j=1:size(filtrImage,1)
    for k=1:size(filtrImage,2)
       if filtrImage(j,k)>40
           filtrImage(j,k)=0;
       else
           filtrImage(j,k)=255;
       end
    end

end
  for j=1:5
     filterImage =imclose(filtrImage,B);
      filtrImage=imopen(filtrImage,B);
  end
  
  filtrImage=imbinarize(filtrImage);
  
  baseFileName=sprintf('%s',filenames(i).name);
  fullFileName=fullfile(outFolder,baseFileName);
  
  imwrite(imresize(filtrImage,[2000 2000]),fullFileName);
  
 end
 RGB = imread('A04_01.bmp');
 gray=rgb2gray(RGB);

 h=fspecial('average', [3 3]);
gray= imfilter(gray, h);
 B=strel('disk',4);
 D=imclose(gray,B);
 D=imopen(D,B);
 
 hUnsharpFiltresi=fspecial('unsharp');
 
 unshFiltr = imfilter(D,hUnsharpFiltresi);
 
figure;
subplot(1,3,1);
imshow(RGB);
title('Resmin Orjinal Hali');




 for i=1:5
      D=imclose(D,B);
      D=imopen(D,B);
  end


subplot(1,3,2);
imshow(D);
title('Morfolojik Islemler');

my_image = im2double(unshFiltr);
my_image = my_image(:,:,1);
image_thresholded=my_image;
% perform thresholding by logical indexingimage_thresholded
image_thresholded(my_image>1.0) = 0;
image_thresholded(my_image<0.13) = 255;
BW1 = edge(image_thresholded,'sobel');

subplot(1,3,3);
imshow(image_thresholded,[]);
title('After Filtering');


unshFiltr(image_thresholded==1)=0;
unshFiltr(image_thresholded==1)=256;

BW1 = edge(image_thresholded,'sobel');

imwrite(imresize(image_thresholded,[2000 2000]),'morf.png');



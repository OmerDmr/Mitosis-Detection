RGB = imread('kans.tif');
I = rgb2gray(RGB);
montage({RGB,I});
%addAttribute(ldc,'kanser','Color',attributeType.String,'Purple');
%D=imdilate(RGB,B);
figure
imshow(C);
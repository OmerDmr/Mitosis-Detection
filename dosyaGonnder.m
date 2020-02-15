 RGB = imread('A01_00.bmp');
 gray=rgb2gray(RGB);

 h=fspecial('average', [3 3]);
gray= imfilter(gray, h);
 B=strel('disk',4);
 D=imclose(gray,B);
 D=imopen(D,B);
 
 hUnsharpFiltresi=fspecial('unsharp');
 
 unshFiltr = imfilter(D,hUnsharpFiltresi);
 
figure;
subplot(1,2,1);
imshow(RGB);
title('Resmin Orjinal Hali');




 for i=1:5
      D=imclose(D,B);
      D=imopen(D,B);
  end


subplot(1,2,2);
imshow(D);
title('Morfolojik Islemler');



imwrite(imresize(D,[2000 2000]),'morf.png');


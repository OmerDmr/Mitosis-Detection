

  our_images = imread('A04_01.bmp');
  gray=our_images;

 h=fspecial('average', [3 3]);
gray= imfilter(gray, h);
 B=strel('disk',5);
 D=imclose(gray,B);
 D=imopen(D,B);
 
 hUnsharpFiltresi=fspecial('unsharp');
 filtrImage = imfilter(D,hUnsharpFiltresi);
   for j=1:5
     filterImage =imclose(filtrImage,B);
      filtrImage=imopen(filtrImage,B);
   end
  
    filtrImage=rgb2gray(filtrImage);
  filtrImage=imbinarize(filtrImage);
 
BW1 = edge(filtrImage,'sobel');

 
  
  imshow(filtrImage);
  
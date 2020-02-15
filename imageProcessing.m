function image=imageProcessing(full_name)

our_images = imread(full_name);
  gray=rgb2gray(our_images);

 h=fspecial('average', [7 7]);
gray= imfilter(gray, h);
 B=strel('disk',5);
 D=imclose(gray,B);
 D=imopen(D,B);
 
 hUnsharpFiltresi=fspecial('unsharp');
 
 filtrImage = imfilter(D,hUnsharpFiltresi);
for j=1:size(filtrImage,1)
    for k=1:size(filtrImage,2)
       if filtrImage(j,k)>50
           filtrImage(j,k)=0;
       else
           filtrImage(j,k)=255;
       end
    end

end

  for j=1:5
     filtrImage =imclose(filtrImage,B);
      filtrImage=imopen(filtrImage,B);
  end
 % BW=edge(filtrImage,'Canny');
 % image= regionprops(BW,'centroid');
 image=filtrImage;
  
end
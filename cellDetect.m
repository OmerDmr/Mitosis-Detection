I = imread('orn.tif');

I_cropped = I(1:450, 10:500);
imshow(I_cropped)


I_eq = adapthisteq(I_cropped);
imshow(I_eq)

bw = im2bw(I_eq, bluethresh(I_eq));
imshow(bw)

bw2 = imfill(bw,'holes');
bw3 = imopen(bw2, ones(5,5));
bw4 = bwareaopen(bw3, 40);
bw4_perim = bwperim(bw4);
overlay1 = imoverlay(I_eq, bw4_perim, [.3 1 .3]);
imshow(overlay1)

mask_em = imextendedmax(I_eq, 30);
imshow(mask_em)

mask_em = imclose(mask_em, ones(5,5));
mask_em = imfill(mask_em, 'holes');
mask_em = bwareaopen(mask_em, 40);
imshow(overlay2)


I_eq_c = imcomplement(I_eq);
I_mod = imimposemin(I_eq_c, ~bw4 | mask_em);
L = watershed(I_mod);
imshow(label2rgb(L))

montage({I,I_cropped,I_eq,bw,overlay1,mask_em,overlay2,label2rgb(L,'spring','c','shuffle')});
 

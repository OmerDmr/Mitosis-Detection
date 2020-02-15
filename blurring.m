 Blurring Filtresi
ResimOrjinal = imread('2_5_2270.326357_505.765116.tif') ;
hBlurringFiltresi = fspecial('disk',10);
blurred = imfilter(ResimOrjinal,hBlurringFiltresi);
figure;
subplot(1,2,1);
imshow(ResimOrjinal);
title('Resmin Orjinal Hali');
subplot(1,2,2);
imshow(blurred);
title('Blurring Filtresi');
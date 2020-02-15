% Medyan Filtresi
RGB= gpuArray(imread('kans.tif'));
K=imnoise(RGB,'salt & pepper',0.02);  % tuz ve biber gürültüsü ekle
medyanFiltresi=medfilt2(K);
figure;
subplot(1,2,1);
imshow(RGB);
title('Resmin Tuz ve Biber Gürültülü Hali');
subplot(1,2,2);
imshow(medyanFiltresi);
title('Medyan Filtresi');
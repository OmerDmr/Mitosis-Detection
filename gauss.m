% Gaussian Filtresi
ResimOrjinal=imread('kans.tif'); %Resim Yüklendi.
ResimOrjinal=im2double(ResimOrjinal); %Double tipine çevrildi.
hGaussionFiltresi=fspecial('gaussian',3,2); %maske 3x3lük
gaussianFiltresi=imfilter(ResimOrjinal,hGaussionFiltresi,'replicate');
figure;
subplot(1,2,1);
imshow(ResimOrjinal);
title('Resmin Orjinal Hali');
subplot(1,2,2);
imshow(gaussianFiltresi,[]);
title('Gaussion Filtresi');
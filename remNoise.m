RGB = imread('02.tif');
RGB = im2double(RGB);

figure
subplot(1,3,1);
imshow(RGB)
title('Pristine Image');

noisyRGB = imnoise(RGB,'gaussian',0,0.01);

subplot(1,3,2);
imshow(noisyRGB)
title('Noisy Image')

net = denoisingNetwork('dncnn');

LAB = rgb2lab(RGB);

LAB(:,:,1) = denoiseImage(LAB(:,:,1),net);

denoisedRGB = lab2rgb(LAB);

subplot(1,3,3);
imshow(denoisedRGB)
title('Denoised Image');
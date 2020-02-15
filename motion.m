% Motion Filtesi
ResimOrjinal = imread('2_5_2270.326357_505.765116.tif') ;
hResimOrjinal = fspecial('motion', 50, 45) ;
motionBlurFiltresi = imfilter(ResimOrjinal, hResimOrjinal) ;
figure;
subplot(1,2,1);
imshow(ResimOrjinal);
title('Resmin Orjinal Hali');
subplot(1,2,2);
imshow(motionBlurFiltresi);
title('Motion Filtesi');
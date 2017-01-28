figure; im = imread('lena_gray.bmp');
[min(im(:)), max(im(:))] % range
subplot(1,2,1); imshow(im); title('original');
subplot(1,2,2); imhist(im);

stretch1 = mkContrastEnhancement(im(:));
figure; im1 = stretch1(im);
[min(im1(:)), max(im1(:))] % range
subplot(1,2,1); imshow(im1); title('linear stretch');
subplot(1,2,2); imhist(im1);

stretch2 = mkContrastEnhancement(im(:),0.01);
figure; im2 = stretch2(im);
[min(im2(:)), max(im2(:))] % range
subplot(1,2,1); imshow(im2); title('linear stretch (1% discarded)');
subplot(1,2,2); imhist(im2);

stretch3 = mkContrastEnhancement(im(:),0.05);
figure; im3 = stretch3(im);
[min(im3(:)), max(im3(:))] % range
subplot(1,2,1); imshow(im3); title('linear stretch (5% discarded)');
subplot(1,2,2); imhist(im3);

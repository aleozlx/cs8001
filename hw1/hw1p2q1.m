W = 3;
im = imread('cat.bmp');
figure;
subplot(1,2,1); imshow(im);
subplot(1,2,2); imhist(im);
kernel = ones(W, W)/ (W*W);
m = cast(conv2(im, kernel, 'same'),'uint8');
figure;
subplot(1,2,1); imshow(m);
subplot(1,2,2); imhist(m);

im_ = cast(im, 'double'); m_ = cast(m, 'double');
corr = conv2(im_ .* im_, kernel, 'same');
v = corr - m_ .* m_;
figure; imshow(cast(v, 'uint8'));
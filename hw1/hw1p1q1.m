im = imread('lena_gray.bmp');
% [rows,cols,channels]=size(im);
%figure; imshow(im);

use_mask = true;

if use_mask
    figure; imshow(im(1:256, 1:256));
    imhist(im(1:256, 1:256), 256);
    figure;
    shape_mask = [256 256];
    H = myimhist(im, 256, [ones(shape_mask), zeros(shape_mask); zeros(shape_mask), zeros(shape_mask)]);
else
    figure;
    imhist(im, 256);
    figure;
    H = myimhist(im, 256);
end

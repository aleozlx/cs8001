function [ im_out ] = gradmag( im )
I = rgb2gray(im);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(I, hy, 'replicate');
Ix = imfilter(I, hx, 'replicate');
im_out = sqrt(Ix.^2 + Iy.^2);
end


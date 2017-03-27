function [ im_out ] = kmeans_seg( im )
%KMEANS_SEG K-means segmentation
%   im: input image
%   returns binary segmentation

[W, H, D] = size(im);

% Contrast enhancement
lab = rgb2lab(im);
ll = lab(:,:,1)/100;
lab(:,:,1) = adapthisteq(ll,'NumTiles', [8 8],'ClipLimit',0.005)*100;
enhanced = lab2rgb(lab)*255;

% K-means on smoothed image
tmp = imgaussfilt(enhanced, 2);
tmp = double(tmp(:,:,1))/255;
idx = kmeans(tmp(:), 2);
im_out = reshape(idx==2, W, H);
end


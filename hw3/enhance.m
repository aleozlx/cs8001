function [ im_out ] = enhance( im_in )
%ENHANCE Enhance contrast
    lab = rgb2lab(im_in(:,:,1:3));
    ll = lab(:,:,1)/100;
    lab(:,:,1) = adapthisteq(ll,'NumTiles', [8 8],'ClipLimit',0.005)*100;
    im_out = lab2rgb(lab);
end


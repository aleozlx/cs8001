function [ im_out ] = smooth( im_in, n_channels, dtype )
if n_channels==1
    im_out = smooth_one(im_in);
else
    im_out = im_in; %zeros(size(im_in));
    for i = 1:n_channels
        im_out(:,:,i) = smooth_one(im_in(:,:,i));
    end
end
im_out = cast(im_out, dtype);
end

function [ im_out ] = smooth_one( im_in )
kernel = [1 2 1; 2 4 2; 1 2 1]/16;
im = cast(im_in, 'double');
im_out = conv2(im, kernel, 'same');
end

function [ q ] = myguidedfilter( p, I, r, e )
% Guided filter
%   p input image
%   I guide image
%   r radius
%   e regularization
fMean = mk_mean(r);

I_ = cast(I, 'double')/255.0;
p_ = cast(p, 'double')/255.0;
mI = fMean(I_);
mP = fMean(p_);
corrI = fMean(I_.*I_);
corrIp = fMean(I_.*p_);
varI = corrI - mI.*mI;
covIp = corrIp - mI.*mP;
a = covIp./(varI + e);
b = mP - a.*mI;
mA = fMean(a);
mB = fMean(b);
q = mA.*I_+mB;
q = cast(q*255.0, 'uint8');
end

function [fMean] = mk_mean(r)
kernel = ones(r,r)/(r*r);
fMean = @(im) conv2(im, kernel, 'same');
end

q=myguidedfilter(im, im, 3, 0.16);
figure;
imshow(q);
function [H] = myimhist(im, nbins, varargin)
data = im(:);
H = zeros(nbins, 1, 'int32');
domain = [cast(0, 'int32'), cast(255, 'int32')];
range = [cast(1, 'int32'), cast(nbins, 'int32')];

if length(varargin)>0
    mask = varargin{1}(:);
else
    mask = ones(size(data));
end
mask = cast(mask, 'int32');

for i = 1:length(data)
    if mask(i)==0
        continue
    end
    addr = prehash(cast(data(i), 'int32'), domain, range);
    H(addr) = H(addr) + 1;
end
stem(H);
end



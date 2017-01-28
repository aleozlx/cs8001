function [stretch] = mkContrastEnhancement(data, varargin)
if length(varargin)>0
    discard_area = varargin{1}*length(data);
    [ct, bins] = imhist(data);
    H = [bins ct]'; t = 0; lo = min(data); hi = max(data);
    for i = 1:length(H)
        t = t + H(2, i);
        if t>= discard_area
            lo = H(1, i);
            break;
        end
    end
    t = 0;
    for i = length(H):-1:1
        t = t + H(2, i);
        if t>= discard_area
            hi = H(1, i);
            break;
        end
    end
    domain = [lo, hi];
else
    domain = [min(data), max(data)];
end
stretch = @(im) cast(prehash(cast(im,'int32'), cast(domain, 'int32'), cast([0,255], 'int32')), 'uint8');
end

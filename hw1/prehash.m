function [index] = prehash(x, domain, range)
lenDomain = domain(2)-domain(1);
lenRange = range(2)-range(1);
index = (x-domain(1)) * lenRange / lenDomain + range(1);
index = max(range(1), index);
index = min(range(2), index);
end

function [ y_next ] = msMean( data, y, r )
%msMean Mean-shift mean value with Epanechnikov kernel
%   data  (npoints, D)
%   y (1, D) 
%   r radius
%   y_next (1, D) 

[npoints, D] = size(data);
dist = data - repmat(y, npoints, 1);
dist = sqrt(sum(dist.^2,2));
Nlist = dist<=r;
weights = 1-power(dist(Nlist)./r,2);
y_next = sum(repmat(weights, 1, D).*data(dist<=r,:),1)/sum(weights);
end


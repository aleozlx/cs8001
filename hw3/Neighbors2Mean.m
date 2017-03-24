function [ y_next ] = Neighbors2Mean( data, Nlist, y )
%NEIGHBORS2MEAN
%   data  (npoints, D)
%   Nlist (npoints, 1)
%   y (1, D) 
%   y_next (1, D) 

neighbors = data(Nlist,:);
[K, D] = size(neighbors);
distances = neighbors - repmat(y, K, 1);
distances = sqrt(sum(distances.^2,2));
weights = 1-power(distances,2);
y_next = sum(repmat(weights, 1, D).*neighbors,1)/sum(weights);
end


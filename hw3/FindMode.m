function [ ylist ] = FindMode( data, ind, R, max_iter )
%FINDMODE
%   data  (npoints, D)
%   ind index of starting point
%   R radius
%   max_iter maximum iterations
%   y_list (k, D) trajectories 

[npoints, D] = size(data);
ylist = zeros(max_iter, D);
ylist(1,:) = data(ind, :);

for i=2:max_iter
    center = ylist(i-1,:);
    Nlist = FindNeighbors(data, center, R);
    ylist(i,:) = Neighbors2Mean(data, Nlist, center);
end

end


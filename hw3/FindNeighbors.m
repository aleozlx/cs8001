function [ Nlist ] = FindNeighbors( data, y, R )
%FINDNEIGHBORS 
%   data (npoints, D)
%   y (1, D) 
%   R radius
%   Nlist (npoints, 1) binary, whether a point is within distance from y

[npoints, D] = size(data);
d = data - repmat(y, npoints, 1);
d = sqrt(sum(d.^2,2));
Nlist = d<=R;
end


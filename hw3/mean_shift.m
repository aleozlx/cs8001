function [ ylist ] = mean_shift( data, seeds, r, max_iter )
%mean_shift
%   data  (npoints, D)
%   seeds starting points
%   r radius
%   max_iter maximum iterations
%   ylist (max_iter, k, D) trajectories, where k is number of unique feature vectors

[npoints, D] = size(data);
[nstarts, ~] = size(seeds);

data_d = cast(data, 'double');

ylist = zeros(max_iter, nstarts, D);
ylist(1,:,:) = cast(seeds, 'double');

for i=2:max_iter
    center = reshape(ylist(i-1,:,:), nstarts, D);
    % size(center)
    for j=1:nstarts
        ylist(i,j,:) = msMean(data_d, center(j,:), r);
    end
end

end


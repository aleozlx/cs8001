function [ trajectories ] = msTrajectories( ms, n_trajectories )
%MSTRAJECTORIES Show a sample of trajectories from mean-shift result
%   Detailed explanation goes here
[max_iter, n_features, D] = size(ms);
ri = randi([1,n_features],1,n_trajectories);
trajectories = ms(:,ri,:);

plot_data = trajectories(:,:,1:2);
[n_steps, n_points, ~] = size(plot_data);

cmap = horzcat(linspace(1,0,n_steps)' , zeros(n_steps,2));
size(cmap)

for i=1:n_points
    hold on;
    scatter(plot_data(:,i,1), plot_data(:,i,2), 6, cmap);
end
end


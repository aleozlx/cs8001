function [ nclusters ] = ms_nclusters( ms )
ms_end = ms(end, :, :);
ms_end = reshape(ms_end, [],3);
ms_end = cast(ms_end, 'uint8');
clusters = unique(ms_end, 'rows')
[nclusters, ~] = size(clusters);
end


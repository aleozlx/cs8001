function [ regions ] = regions( watershed, sz_range )
labels = bwlabel(watershed);
connected_components = bwconncomp(watershed);

tmp = regionprops(connected_components,'Area');
SZs = [tmp.Area];
sz_filter = SZs>=sz_range(1)&SZs<=sz_range(2);
SZs = SZs(sz_filter);
figure;
SZhist = histogram(SZs,100);

regions = struct( ...
    'count_raw', connected_components.NumObjects, ...
    'count', sum(SZhist.BinCounts), ...
    'sizes', SZs,  ...
    'size_histogram', SZhist,  ...
    'labels', labels/connected_components.NumObjects  ...
);

end

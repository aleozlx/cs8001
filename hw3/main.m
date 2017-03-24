im = imread('cropped.tif');
im = im(:,:,1:3);

%enhanced = cast(enhance(im)*255, 'uint8');
%data = reshape(enhanced, [], 3);

data = reshape(im, [], 3);

[N, D] = size(data);
seeds = mkseeds(im, 8);

// % test msMean
// test_neighbors = rand(16, 3);
// msMean(test_neighbors, [0.5,0.5,0.5], 0.6)
// mean(test_neighbors, 1)
// %

ms = mean_shift(data, seeds, 16, 35);
im_out = msSegmentation(ms, seeds, im, 8);
figure;imshow(im);
figure;imshow(im_out);


ms = mean_shift(data, seeds, 16, 35);
im_out = msSegmentation(ms, seeds, im, 8);
data2 = reshape(im_out, [], 3);
seeds2 = mkseeds(im_out, 8);
ms2 = mean_shift(data2, seeds2, 8, 35);
im_out2 = msSegmentation(ms2, seeds2, im_out, 8);
figure;imshow(im_out2);
ms_nclusters(ms2)


figure;imshow(im_out);
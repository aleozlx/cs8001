% ===============
% read images
% ===============
im2 = imread('malaria_cropped.tif');
im2_double = double(im2)/255;

% ===============
% processing im2
% ===============

% (1) original image
imshow(im2);

% (2)(3) k-means clustering
im2_bw1 = kmeans_seg(im2);
if sum(sum(im2_bw1))>90000
    im2_bw1=~im2_bw1;
end
figure;imshow(im2_bw1);
im2_bw1 = imclose(im2_bw1, strel('disk', 7));
figure;imshow(im2_bw1);

% (5a) foreground/background marker
im2_marker1 = bwdist(~im2_bw1);
%figure;imshow(im2_marker1,[],'InitialMagnification','fit');
im2_marker1 = imregionalmax(im2_marker1);
%figure;imshow(im2_marker1);
figure;imshow_double(imoverlay(im2_double,im2_marker1,[1,1,1]));

im2_bgmarker1 = watershed(bwdist(im2_bw1)) == 0;
%figure;imshow(im2_bgmarker1);
figure;imshow_double(imoverlay(im2_double,im2_bgmarker1,[1,1,1]));

% (6a) marker-controlled watershed
im2_watershed1 = watershed(imimposemin(gradmag(im2_double), im2_marker1 | im2_bgmarker1));
figure;imshow_watershed(im2, im2_watershed1);

% (7a)(8a) final segmentation & area histogram
im2_regions1 = regions(im2_watershed1, [120, 3200]);
figure;imshow_double(im2_regions1.labels);

% (4) blob filter
im2_blob = imfilter(im2_double,double(fspecial('log', 55)),'conv');
figure;imshow_double(im2_blob);

% (5b) foreground/background marker
im2_blob = imclose(im2_blob, strel('disk', 7));
im2_blob = imopen(im2_blob, strel('disk', 6));
figure;imshow_double(im2_blob);
im2_bw2 = im2_blob(:,:,2)>0.1;
figure;imshow_double(im2_bw2);

im2_marker2 = bwdist(~im2_bw2);
im2_marker2 = imregionalmax(im2_marker2);
figure;imshow_double(imoverlay(im2_double,im2_marker2,[1,1,1]));

im2_bgmarker2 = watershed(bwdist(im2_bw2)) == 0;
figure;imshow_double(imoverlay(im2_double,im2_bgmarker2,[1,1,1]));

% (6b) marker-controlled watershed
im2_watershed2 = watershed(imimposemin(gradmag(im2_double), im2_marker2 | im2_bgmarker2));
figure;imshow_watershed(im2, im2_watershed2);

% (7b)(8b) final segmentation & area histogram
im2_regions2 = regions(im2_watershed2, [120, 3200]);
figure;imshow_double(im2_regions2.labels);


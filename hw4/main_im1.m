% ===============
% read images
% ===============
im1 = imread('prostatecancer_grade4_cropped.tif');
im1 = im1(:,:,1:3);
im1_double = double(im1)/255;
im2 = imread('malaria_cropped.tif');
im2_double = double(im2)/255;

% ===============
% processing im1
% ===============

% (1) original image
imshow(im1);

% (2)(3) k-means clustering
im1_bw1 = kmeans_seg(im1);
if sum(sum(im1_bw1))>15000
    im1_bw1=~im1_bw1;
end
figure;imshow(im1_bw1);

% (5a) foreground/background marker
im1_marker1 = bwdist(~im1_bw1);
%figure;imshow(im1_marker1,[],'InitialMagnification','fit');
im1_marker1 = imregionalmax(im1_marker1);
%figure;imshow(im1_marker1);
figure;imshow_double(imoverlay(im1_double,im1_marker1,[1,1,1]));

im1_bgmarker1 = watershed(bwdist(im1_bw1)) == 0;
%figure;imshow(im1_bgmarker1);
figure;imshow_double(imoverlay(im1_double,im1_bgmarker1,[1,1,1]));

% (6a) marker-controlled watershed
im1_watershed1 = watershed(imimposemin(gradmag(im1_double), im1_marker1 | im1_bgmarker1));
figure;imshow_watershed(im1, im1_watershed1);

% (7a)(8a) final segmentation & area histogram
im1_regions1 = regions(im1_watershed1, [30, 800]);
figure;imshow_double(im1_regions1.labels);

% (4) blob filter
im1_blob = imfilter(im1_double,double(fspecial('log', 17)),'conv');
figure;imshow_double(im1_blob);

% (5b) foreground/background marker
im1_blob = imreconstruct(imerode(im1_blob, strel('diamond', 1)), im1_blob);
im1_bw2 = imbinarize(bsxfun(@min,im1_blob(:,:,1),im1_blob(:,:,2)));
im1_bw2 = imopen(imclose(im1_bw2, strel('disk', 1)), strel('disk', 1));
%figure;imshow(im1_marker2);
im1_marker2 = bwdist(~im1_bw2);
im1_marker2 = imregionalmax(im1_marker2);
figure;imshow_double(imoverlay(im1_double,im1_marker2,[1,1,1]));

im1_bgmarker2 = watershed(bwdist(im1_bw2)) == 0;
figure;imshow_double(imoverlay(im1_double,im1_bgmarker2,[1,1,1]));

% (6b) marker-controlled watershed
im1_watershed2 = watershed(imimposemin(gradmag(im1_double), im1_marker2 | im1_bgmarker2));
figure;imshow_watershed(im1, im1_watershed2);

% (7b)(8b) final segmentation & area histogram
im1_regions2 = regions(im1_watershed2, [30, 800]);
figure;imshow_double(im1_regions2.labels);

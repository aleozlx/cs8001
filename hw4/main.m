% read images
im1 = imread('prostatecancer_grade4_cropped.tif');
im1 = im1(:,:,1:3);
im1_double = double(im1)/255;
im2 = imread('malaria_cropped.tif');
im2_double = double(im2)/255;

% processing im1
im1_bw = kmeans_seg(im1);
if sum(sum(im1_bw))>15000
    im1_bw=~im1_bw;
end
figure;imshow(im1_bw);
im1_marker1 = bwdist(~im1_bw);
%figure;imshow(im1_marker1,[],'InitialMagnification','fit');
im1_marker1 = imregionalmax(im1_marker1);
figure;imshow(im1_marker1);

im1_bgmarker1 = watershed(bwdist(im1_bw)) == 0;
figure;imshow(im1_bgmarker1);

tmp = watershed(imimposemin(gradmag(im1_double), im1_marker1 | im1_bgmarker1));
imshow_watershed(im1, tmp);

im1_blob = imfilter(im1_double,double(fspecial('log', 17)),'conv');
figure;imshow_double(im1_blob);
% im1_blob = imreconstruct(imerode(im1_blob, strel('diamond', 2)), im1_blob);
% 
% im1_marker2 = imbinarize(bsxfun(@min,im1_blob(:,:,1),im1_blob(:,:,2)));
% im1_marker2 = imopen(imclose(im1_marker2, strel('disk', 2)), strel('disk', 2));
% figure;imshow(im1_marker2);
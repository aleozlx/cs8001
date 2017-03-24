%G = [1 2 1; 2 4 2; 1 2 1];

% =============================
% Read images
% =============================
im1 = imread('lungCT.jpg');
im2 = imread('malaria.tif');
im3 = imread('prostatecancer_grade4.tif');
im4 = imread('prostatecancer_grade4_cropped.tif');

% =============================
% Gaussian smoothing and kmeans clustering by intensity for im1
% =============================

figure;imshow(im1);
figure;tmp = smooth(im1, 1, 'uint8');imshow(tmp);
% sum(sum(abs(tmp - im1)))
idx = kmeans(tmp(:), 2);
figure;imshow(reshape(idx==1,512,512));

% =============================
% Gaussian smoothing and kmeans clustering by channel 1 for im2
% =============================

figure;imshow(im2);
figure;tmp = smooth(im2, 3, 'uint16');imshow(tmp);
a=tmp(:,:,1);
a=a(:);
idx = kmeans(a, 2);
figure;imshow(reshape(idx==2,1040,1388));

% =============================
% kmeans clustering using 2 channels for im2
% =============================

a=tmp(:,:,2:3);
b=reshape(a,1040*1388,2);
b=cast(b,'double')/65535;
idx = kmeans(b, 2);
figure;imshow(reshape(idx==2,1040,1388));

% =============================
% Gaussian smoothing and kmeans clustering using channel 1 for im3
% =============================

figure;imshow(im3(:,:,1:3));
figure;tmp = smooth(im3, 3, 'uint8');imshow(tmp(:,:,1:3));
a=cast(tmp(:,:,1), 'double')/255;
a=a(:);
idx = kmeans(a, 2);
a=reshape(idx==2,813,768);
a(tmp(:,:,4)<204)=false;
figure;imshow(a);

%a=cast(tmp(:,:,1), 'double')/255;
%b=cast(tmp(:,:,2), 'double')/255;
%c=cast(tmp(:,:,3), 'double')/255;

% =============================
% kmeans clustering using channel 1 from lab enhanced image for im3
% =============================

lab = rgb2lab(tmp(:,:,1:3));
ll = lab(:,:,1)/100;
lab(:,:,1) = adapthisteq(ll,'NumTiles', [8 8],'ClipLimit',0.005)*100;
enhanced = lab2rgb(lab);
%figure;imshow(cast(enhanced*255,'uint8'));
idx = kmeans(reshape(enhanced, 813*768, 3), 2);
t=reshape(idx==2,813,768);
t(tmp(:,:,4)<204)=false;
figure;imshow(t);

% =============================
% Gaussian smoothing and kmeans clustering using channel 1 for im4
% =============================

figure;imshow(im4(:,:,1:3));
lab = rgb2lab(im4(:,:,1:3));
ll = lab(:,:,1)/100;
lab(:,:,1) = adapthisteq(ll,'NumTiles', [8 8],'ClipLimit',0.005)*100;
enhanced = lab2rgb(lab)*255;
tmp = smooth(enhanced, 3, 'uint8');
figure;imshow(tmp);
a=cast(tmp(:,:,1), 'double')/255;
a=a(:);
idx = kmeans(a, 2);
a=reshape(idx==2,160,187);
figure;imshow(a);

% =============================
% Gaussian smoothing and kmeans clustering using b* channel for im4
% =============================

bb=cast(lab(:,:,3)+128,'uint8');
bb=smooth(bb,1,'uint8');
%figure;imshow(bb);
%figure;imshow(imadjust(bb,stretchlim(bb),[]));
idx = kmeans(bb(:), 2);
t=reshape(idx==1,160,187);
figure;imshow(t);


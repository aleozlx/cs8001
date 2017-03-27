function [ ] = imshow_watershed( im, watershed )
R = im(:,:,1); G = im(:,:,2); B = im(:,:,3);
R(watershed==0) = 255;
G(watershed==0) = 255;
B(watershed==0) = 255;
imshow(cast(cat(3,R,G,B),'uint8'));
end


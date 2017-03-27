function [ ] = imshow_double( im )
imshow(cast(im*255,'uint8'));
end

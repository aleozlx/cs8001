function [ seeds ] = mkseeds( im_input , quantization )
%MKSEEDS subsample feature space
rgb = im_input(:,:,1:3);
feature = reshape(rgb, [], 3)./quantization;
seeds = unique(feature, 'rows').*quantization;
end


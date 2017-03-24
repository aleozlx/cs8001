function [ im_out ] = msSegmentation( ms, seeds, im, quantization )
%MSSEGMENTATION associate cluster labels back to image pixels

ms_end = ms(end, :, :);
ms_end = reshape(ms_end, size(seeds));
ms_end = cast(ms_end, 'uint8');

im_out = zeros(size(im), 'uint8');
[N_row, N_col, N_channel] = size(im);
for i=1:N_row
    for j=1:N_col
        color = im(i,j,:);
        color = reshape(color, 1, 3)./quantization.*quantization;
        i_ms = find(ismember(seeds, color), 1);
        label = ms_end(i_ms, :);
        im_out(i,j,:) = label;
    end
end

end


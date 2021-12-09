function [vector] = getLipsApplyDCT(img, resizePercent)

% vector = uint8(255 * mat2gray(image));

vector = imresize(img, resizePercent, 'nearest');

% imshow(vector);

vector = dct2(vector);

vector = zigzag(vector);

vector = vector(1:floor(length(vector)/2));

end


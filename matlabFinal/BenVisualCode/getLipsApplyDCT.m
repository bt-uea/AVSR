function [vector] = getLipsApplyDCT(img, resizePercent, numVecs)

% vector = uint8(255 * mat2gray(image));

vector = imresize(img, resizePercent, 'nearest');

% imshow(vector);

vector = dct2(vector);

vector = zigzag(vector);

vector = vector(1:numVecs);

end


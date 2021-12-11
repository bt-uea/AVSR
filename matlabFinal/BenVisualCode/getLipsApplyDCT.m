function [vector] = getLipsApplyDCT(img, resizePercent, numVecs)

% vector = uint8(255 * mat2gray(image));

vector = imresize(img, resizePercent, 'nearest');

% imshow(vector);

% For reconstruction done on resized img
% lipSize = size(vector);

vector = dct2(vector);

vector = zigzag(vector);

vector = vector(1:numVecs);

% Uncomment to get reconstructed image back
%{
vector(numVecs:length(vector)) = 0;

remadeDCT = izigzag(vector, lipSize(1), lipSize(2));

newIm = idct2(remadeDCT);

imshow(newIm);

vector = newIm;
%}

end


function [vector] = getLipsApplyDCT(img, halfFrameWidth, halfFrameHeight)

[midPointX, midPointY] = getLipCentre(img);

croppedImg = img((midPointX - halfFrameWidth):(midPointX + halfFrameWidth), (midPointY - halfFrameHeight):(midPointY + halfFrameHeight), :);

doubleIm = imfilter(im2double(croppedImg), fspecial('average',20));

% Done after some trial and error normalising RGB then doing mixing the 
% color spaces for best representation of lips
R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

image = (R ./ S) * 2;
image = image - (G./ S) * 5;
image = image + (B./ S) * 3;

L = image > 0.8;

% This will perform an dilation followed by erosion with a structuring
% elemnt of a disk with radius 9
closedBin = imclose(L, strel('disk', 4));
% closedBin = L;

% imshow(closedBin)

% Blur and then rethreshold to remove some rough edges (from
% https://uk.mathworks.com/matlabcentral/answers/380687-how-to-smooth-rough-edges-along-a-binary-image)
windowSize = 10;
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage = conv2(single(closedBin), kernel, 'same');
binaryImage = blurryImage > 0.45; % Rethreshold

vector = uint8(255 * binaryImage);

vector = dct2(vector);

vector = zigzag(vector);

end


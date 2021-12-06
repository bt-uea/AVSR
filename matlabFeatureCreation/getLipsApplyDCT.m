function [vector] = getLipsApplyDCT(img, halfFrameWidth, halfFrameHeight)

% im = imread(file);
im = img;

doubleIm = imfilter(im2double(im), fspecial('average',20));

% Done after some trial and error normalising RGB then doing mixing the 
% color spaces for best representation of lips
R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

im = (R ./ S) * 2;
im = im - (G./ S) * 5;
im = im + (B./ S) * 3;

% Threshold img
L = im > 0.8;

% This will perform an dilation followed by erosion with a structuring
% elemnt of a disk with radius 9
closedBin = imclose(L, strel('disk', 4));
% closedBin = L;

% Blur and then rethreshold to remove some rough edges (from
% https://uk.mathworks.com/matlabcentral/answers/380687-how-to-smooth-rough-edges-along-a-binary-image)
windowSize = 10;
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage = conv2(single(closedBin), kernel, 'same');
binaryImage = blurryImage > 0.45; % Rethreshold

% hold on;
% imshow(binaryImage);

BW = binaryImage;
[B,L,N,A] = bwboundaries(BW);

[max_size, max_index] = max(cellfun('size', B, 1));

outerBoundary = B{max_index};
% plot(outerBoundary(:,2), outerBoundary(:,1), 'r', 'LineWidth', 2);


[minValOutX, minIdxOutX] = min(outerBoundary(:, 1));
[minValOutY, minIdxOutY] = min(outerBoundary(:, 2));
[maxValOutX, maxIdxOutX] = max(outerBoundary(:, 1));
[maxValOutY, maxIdxOutY] = max(outerBoundary(:, 2));

midPointX = round((maxValOutX + minValOutX) / 2);
midPointY = round((maxValOutY + minValOutY) / 2);
% plot(midPointY, midPointX, 'g', 'Marker','+');

% hold off;
vector = doubleIm((midPointX - halfFrameWidth):(midPointX + halfFrameWidth), (midPointY - halfFrameHeight):(midPointY + halfFrameHeight), :);
vector = uint8(255 * vector);

% imshow(lipFrame);

end


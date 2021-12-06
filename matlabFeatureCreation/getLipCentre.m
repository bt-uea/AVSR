function [midPointX, midPointY] = getLipCentre(image)

doubleIm = imfilter(im2double(image), fspecial('average',20));

% Done after some trial and error normalising RGB then doing mixing the 
% color spaces for best representation of lips
R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

image = (R ./ S) * 2;
image = image - (G./ S) * 5;
image = image + (B./ S) * 3;

% Threshold img
BW = image > 0.8;

[B,L,N,A] = bwboundaries(BW);

[max_size, max_index] = max(cellfun('size', B, 1));

outerBoundary = B{max_index};

[minValOutX, minIdxOutX] = min(outerBoundary(:, 1));
[minValOutY, minIdxOutY] = min(outerBoundary(:, 2));
[maxValOutX, maxIdxOutX] = max(outerBoundary(:, 1));
[maxValOutY, maxIdxOutY] = max(outerBoundary(:, 2));

midPointX = round((maxValOutX + minValOutX) / 2);
midPointY = round((maxValOutY + minValOutY) / 2);

end

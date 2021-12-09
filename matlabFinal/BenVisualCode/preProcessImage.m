function [originalCrop, binaryLipsCrop, lipsOutline] = preProcessImage(image, halfFrameWidth, halfFrameHeight)

orig = image;
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

originalCrop = orig((midPointX - halfFrameWidth):(midPointX + halfFrameWidth), (midPointY - halfFrameHeight):(midPointY + halfFrameHeight), :);
croppedImg = BW((midPointX - halfFrameWidth):(midPointX + halfFrameWidth), (midPointY - halfFrameHeight):(midPointY + halfFrameHeight), :);

% This will perform an dilation followed by erosion with a structuring
% elemnt of a disk with radius 9
closedBin = imclose(croppedImg, strel('disk', 4));

% Blur and then rethreshold to remove some rough edges (from
% https://uk.mathworks.com/matlabcentral/answers/380687-how-to-smooth-rough-edges-along-a-binary-image)
windowSize = 10;
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage = conv2(single(closedBin), kernel, 'same');
binaryImage = blurryImage > 0.45; % Rethreshold

binaryLipsCrop = binaryImage;

innerBoundary = [];

% Check if the main boundary has a child inside
if(nnz(A(:,max_index)))
    for sub = find(A(:,max_index))
        innerBoundary = B{sub};
        % plot(innerBoundary(:,2), innerBoundary(:,1), 'g', 'LineWidth', 2);
    end
end

% If there was an inner boundary
if(~isempty(innerBoundary))
    [minValInnX, minIdxInnX] = min(innerBoundary(:, 1));
    [minValInnY, minIdxInnY] = min(innerBoundary(:, 2));

    xDiff = minValInnX - minValOutX;
    yDiff = minValInnY - minValOutY;

    innerBoundary = [(innerBoundary(:, 1) - minValInnX + xDiff + 1) innerBoundary(:, 2)];
    innerBoundary = [innerBoundary(:, 1) (innerBoundary(:, 2) - minValInnY + yDiff + 1)];
end

% Update boundary to around 0
outerBoundary = [(outerBoundary(:, 1) - minValOutX + 1) outerBoundary(:, 2)];
outerBoundary = [outerBoundary(:, 1) (outerBoundary(:, 2) - minValOutY + 1)];

% Find max and create zeros with the size of lips
[maxValOutX, maxIdxOutX] = max(outerBoundary(:, 1));
[maxValOutY, maxIdxOutY] = max(outerBoundary(:, 2));

lipsOutline = zeros(maxValOutX, maxValOutY);

% Create the image of the boundaries by plotting points a binary image 1
for i = 1:length(outerBoundary)
    lipsOutline(outerBoundary(i, 1), outerBoundary(i, 2)) = 1;
end

if(~isempty(innerBoundary))
    for i = 1:length(innerBoundary)
        lipsOutline(innerBoundary(i, 1), innerBoundary(i, 2)) = 1;
    end
end

end


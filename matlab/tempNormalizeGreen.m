function [im] = tempNormalizeGreen(file)

% im = imread(file);
im = file;

% Find face in image as without jacket gives a large highlighted area as
% well (thanks bruce)
faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, im);
bbox=bbox(size(bbox,1),:);
im = imcrop(im,bbox);

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

%{
% This is used to find the average intensity of the lips then threshold for
% that intensity (todo get an avg value and hardcode)
P = roipoly(im);

ptr = find(P);

M1 = im;

R = M1(:,:,1);

cm = mean(R(ptr));

D = sqrt((M1(:,:,1) - cm(1)).^2);

L = D < std(D(:));

imshow(L);
%}

L = im > 0.8;

% This will perform an dilation followed by erosion with a structuring
% elemnt of a disk with radius 9
closedBin = imclose(L, strel('disk', 4));
% closedBin = L;

imshow(closedBin)

% Blur and then rethreshold to remove some rough edges (from
% https://uk.mathworks.com/matlabcentral/answers/380687-how-to-smooth-rough-edges-along-a-binary-image)
windowSize = 10;
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage = conv2(single(closedBin), kernel, 'same');
binaryImage = blurryImage > 0.45; % Rethreshold

% Get the boundaries of the bw image
% bound = bwboundaries(binaryImage);

% Display boundaries ontop of original image
BW = binaryImage;
[B,L,N,A] = bwboundaries(BW);

[max_size, max_index] = max(cellfun('size', B, 1));

% figure; 
% imshow(doubleIm); 
% hold on;

outerBoundary = B{max_index};
innerBoundary = [];
plot(outerBoundary(:,2), outerBoundary(:,1), 'r', 'LineWidth', 2);

if(nnz(A(:,max_index)))
    for sub = find(A(:,max_index))
        innerBoundary = B{sub};
        % plot(innerBoundary(:,2), innerBoundary(:,1), 'g', 'LineWidth', 2);
    end
end

% hold off;

[minValOutX, minIdxOutX] = min(outerBoundary(:, 1));
[minValOutY, minIdxOutY] = min(outerBoundary(:, 2));

if(~isempty(innerBoundary))
    [minValInnX, minIdxInnX] = min(innerBoundary(:, 1));
    [minValInnY, minIdxInnY] = min(innerBoundary(:, 2));

    xDiff = minValInnX - minValOutX;
    yDiff = minValInnY - minValOutY;

    innerBoundary = [(innerBoundary(:, 1) - minValInnX + xDiff + 1) innerBoundary(:, 2)];
    innerBoundary = [innerBoundary(:, 1) (innerBoundary(:, 2) - minValInnY + yDiff + 1)];
end

outerBoundary = [(outerBoundary(:, 1) - minValOutX + 1) outerBoundary(:, 2)];
outerBoundary = [outerBoundary(:, 1) (outerBoundary(:, 2) - minValOutY + 1)];

[maxValOutX, maxIdxOutX] = max(outerBoundary(:, 1));
[maxValOutY, maxIdxOutY] = max(outerBoundary(:, 2));

im = zeros(maxValOutX, maxValOutY);

for i = 1:length(outerBoundary)
    im(outerBoundary(i, 1), outerBoundary(i, 2)) = 1;
end

if(~isempty(innerBoundary))
    for i = 1:length(innerBoundary)
        im(innerBoundary(i, 1), innerBoundary(i, 2)) = 1;
    end
end

% plot(outerBoundary(:,2), outerBoundary(:,1), 'r', 'LineWidth', 2);
% plot(innerBoundary(:,2), innerBoundary(:,1), 'g', 'LineWidth', 2);
% hold off;

%}
end

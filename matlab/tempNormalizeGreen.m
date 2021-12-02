function [im] = tempNormalizeGreen(file)

im = imread(file);

% Find face in image as without jacket gives a large highlighted area as
% well (thanks bruce)
faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, im);
bbox=bbox(size(bbox,1),:);
im = imcrop(im,bbox);

doubleIm = im2double(im);

% Done after some trial and error normalising RGB then doing mixing the 
% color spaces for best representation of lips
R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

im = (R ./ S) * 2;
im = im - (G./ S) * 5;
im = im + (B./ S) * 3;


% This is used to find the average intensity of the lips then threshold for
% that intensity (todo get an avg value and hardcode)

M1 = im;

D = sqrt((M1(:,:,1) - 1.64335881458785).^2);

L = D < std(D(:));

% This will perform an dilation followed by erosion with a structuring
% elemnt of a disk with radius 9
closedBin = imclose(L, strel('disk', 15));

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
[B,L,N] = bwboundaries(BW);
       figure; 
       imshow(doubleIm); 
       hold on;
       for k = 1:length(B),
           boundary = B{k};
           if(k > N)
               plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
           else
               plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
           end
       end
%}
end

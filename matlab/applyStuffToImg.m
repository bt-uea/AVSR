% imwrite(applyStuffToImg('mp4s\albi\frames\albi_frame094.png'), 'report/benimages/boundaries.png');
function image = applyStuffToImg(imgFilePath)

img = imread(imgFilePath);

doubleIm = imfilter(im2double(img), fspecial('average',20));

R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

im = (R ./ S) * 2;
im = im - (G./ S) * 5;
im = im + (B./ S) * 3;

L = im > 0.8;

closedBin = imclose(L, strel('disk', 4));

% Blur and then rethreshold to remove some rough edges (from
% https://uk.mathworks.com/matlabcentral/answers/380687-how-to-smooth-rough-edges-along-a-binary-image)
windowSize = 10;
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage = conv2(single(closedBin), kernel, 'same');
binaryImage = blurryImage > 0.45; % Rethreshold

BW = binaryImage;
[B,L,N,A] = bwboundaries(BW);

im = zeros(size(binaryImage));

for bound = 1:length(B)
    boundary = B{bound};
    for i = 1:length(boundary)
        im(boundary(i, 1), boundary(i, 2)) = 1;
    end
end

image = im;

end


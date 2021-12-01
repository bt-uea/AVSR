function [im] = tempNormalizeGreen(file)

im = imread('mp4s\albi\frames\albi_frame001.png');
doubleIm = im2double(im);

R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

im = R ./ S;
im = im - (G./ S) * 3;
im = im + (B./ S) * 3;

% Increase range of temps for more granularity?
% im = (im .* 200) < 10;

thresh = im > 0.8;

imshow(im);

% imshow(imclose(im > 0.8, strel('disk', 5)));

end

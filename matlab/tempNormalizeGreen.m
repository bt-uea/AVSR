function [im] = tempNormalizeGreen(file)

im = imread('mp4s\albi\frames\albi_frame001.png');
doubleIm = im2double(im);

R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

temp = G ./ S;

% Increase range of temps for more granularity?
imshow((temp .* 200) < 30);

end

function [imgOut] = tempNormalizeGreen2(imgIn)

doubleIm = im2double(imgIn);

R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

im = (R ./ S);
im = im - (G./ S) * 5;
im = im + (B./ S) * 5;

% Increase range of temps for more granularity?
% im = (im .* 200) < 10;

thresh = im > 0.8;

imgOut= thresh;

% imshow(imclose(im > 0.8, strel('disk', 5)));

end

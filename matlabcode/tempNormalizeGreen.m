function [imgOut] = tempNormalizeGreen(img, mult, threshold)

% mult = 200
% thresh = 30

doubleIm = im2double(img);

R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

temp = G ./ S;

% Increase range of temps for more granularity?
imgOut = (temp .* mult) < threshold;

end

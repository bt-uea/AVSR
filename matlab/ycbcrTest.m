function [im] = ycbcrTest(file)

im = imread(file);
doubleIm = im2double(rgb2ycbcr(im));

R = doubleIm(:, :, 1);
G = doubleIm(:, :, 2);
B = doubleIm(:, :, 3);

S = R + G + B;

tempIm = B*3 - R*3 - G*2;

imshow(tempIm);

end


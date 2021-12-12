function [videoVectors] = getVideoFVectors(videoStruct)

halfFrameWidth = 100;
halfFrameHeight = 150;

% Find face in image as without jacket gives a large highlighted area as
% well (thanks bruce for code)
faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, videoStruct(1).cdata);
bbox(1) = bbox(1) + 100;
bbox(3) = bbox(3) - 200;
bbox=bbox(size(bbox,1),:);

[lipRoughX, lipRoughY] = getLipCentre(imcrop(videoStruct(1).cdata, bbox));
lipRoughX = lipRoughX + bbox(2);
lipRoughY = lipRoughY + bbox(1);

numPixels = (halfFrameWidth * 2 + 1) * (halfFrameHeight * 2 + 1) * 3;

% Num DCT vectors to keep
numDCT = 93;
numShape = 3;

videoVectors = zeros(length(videoStruct), numDCT + numShape);
% Used for pca
% originalCropVec = zeros(length(videoStruct), numPixels);

for frame = 1:length(videoStruct)
    data = videoStruct(frame).cdata;
    data = data((lipRoughX - 200):(lipRoughX + 200), (lipRoughY - 200):(lipRoughY + 200), :);
    
    [originalCrop, binaryLipsCrop, lipsOutline] = preProcessImage(data, halfFrameWidth, halfFrameHeight);

    % Used when doing pca
    % shaped = double(reshape(originalCrop, 1, numPixels));

    % originalCropVec(frame, :) = shaped;

    videoVectors(frame, 1:numDCT) = getLipsApplyDCT(binaryLipsCrop, 0.1, numDCT);
    videoVectors(frame, numDCT + 1) = size(lipsOutline, 1);
    videoVectors(frame, numDCT + 2) = size(lipsOutline, 2);
    videoVectors(frame, numDCT + 3) = sum(binaryLipsCrop, "all");
    % videoVectors = [videoVectors; tempVec];
    % disp("Loop " + frame);
end

%% Perform And Return PCA Vectors
%{
disp("Doing PCA");

im_m = mean(originalCropVec, 1);

dif = originalCropVec-im_m;

videoVectors = pca(dif, 'NumComponents', 300);
%}

%% TO Display Reconstructed PCS
%{
imgB = dif * videoVectors;

for feat = 1 : length(imgB)
    xim = im_m' + videoVectors * imgB(feat, :)';

    xim = reshape(xim', (halfFrameWidth * 2 + 1), (halfFrameHeight * 2 + 1), 3);
    imshow(xim);
end
%}
end


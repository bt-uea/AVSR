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

videoVectors = [];
originalCropVec = zeros(length(videoStruct), numPixels);

for frame = 1:length(videoStruct)
    data = videoStruct(frame).cdata;
    data = data((lipRoughX - 200):(lipRoughX + 200), (lipRoughY - 200):(lipRoughY + 200), :);
    
    [originalCrop, binaryLipsCrop, lipsOutline] = preProcessImage(data, halfFrameWidth, halfFrameHeight);

    shaped = double(reshape(originalCrop, 1, numPixels));

    originalCropVec(frame, :) = shaped;

    %tempVec = getLipsApplyDCT(binaryLipsCrop, 0.1, 93);
    %videoVectors = [videoVectors; tempVec];
    % disp("Loop " + frame);
end

disp("Doing PCA");

im_m = mean(originalCropVec, 1);

dif = originalCropVec-im_m;

videoVectors = pca(dif, 'NumComponents', 10);

end


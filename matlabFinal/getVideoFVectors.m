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

videoVectors = [];

for frame = 1:length(videoStruct)
    data = videoStruct(frame).cdata;
    data = data((lipRoughX - 200):(lipRoughX + 200), (lipRoughY - 200):(lipRoughY + 200), :);
    
    [originalCrop, binaryLipsCrop, lipsOutline] = preProcessImage(data, halfFrameWidth, halfFrameHeight);

    tempVec = getLipsApplyDCT(binaryLipsCrop, 0.1);
    videoVectors = [videoVectors; tempVec];
end

end


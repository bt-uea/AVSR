function [vector] = getVectorsImage(img)

% TODO

halfFrameWidth = 100;
halfFrameHeight = 150;
vector = getLipsApplyDCT(img, halfFrameWidth, halfFrameHeight);

end


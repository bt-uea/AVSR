function [vector] = getLipsApplyDCT(img, halfFrameWidth, halfFrameHeight)

[midPointX, midPointY] = getLipCentre(img);

vector = img((midPointX - halfFrameWidth):(midPointX + halfFrameWidth), (midPointY - halfFrameHeight):(midPointY + halfFrameHeight), :);

end


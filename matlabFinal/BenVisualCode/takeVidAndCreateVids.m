function takeVidAndCreateVids(vidPath)

halfFrameWidth = 100;
halfFrameHeight = 150;

% Read video and store each fram in s struct
v = VideoReader(vidPath);
vidHeight = v.Height;
vidWidth = v.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(v)
    s(k).cdata = readFrame(v);
    k = k+1;
end

% Find face in image as without jacket gives a large highlighted area as
% well (thanks bruce for code)
faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, s(1).cdata);
bbox(1) = bbox(1) + 100;
bbox(3) = bbox(3) - 200;
bbox=bbox(size(bbox,1),:);

[lipRoughX, lipRoughY] = getLipCentre(imcrop(s(1).cdata, bbox));
lipRoughX = lipRoughX + bbox(2);
lipRoughY = lipRoughY + bbox(1);

lipOutlines = [];
newVidCrop = struct('cdata',zeros((halfFrameWidth * 2 + 1),(halfFrameHeight * 2 + 1),3,'uint8'),'colormap', []);
newVidBWCrop = struct('cdata',zeros((halfFrameWidth * 2 + 1),(halfFrameHeight * 2 + 1),3,'uint8'),'colormap', []);

for k = 1:length(s)
    data = s(k).cdata;
    data = data((lipRoughX - 200):(lipRoughX + 200), (lipRoughY - 200):(lipRoughY + 200), :);
    [a, b, c] = preProcessImage(data, halfFrameWidth, halfFrameHeight);
    newVidCrop(k).cdata = a;
    newB = uint8(255 * b);
    newVidBWCrop(k).cdata = cat(3, newB, newB, newB);
end

v = VideoWriter("a.avi");
open(v);
writeVideo(v, newVidCrop);
close(v);

v = VideoWriter("b.avi");
open(v);
writeVideo(v, newVidBWCrop);
close(v);

end


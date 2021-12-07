function [] = temp(videoPath)

halfFrameWidth = 100;
halfFrameHeight = 150;

v = VideoReader(videoPath);
vidHeight = v.Height;
vidWidth = v.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(v)
s(k).cdata = readFrame(v);
k = k+1;
end

% Find face in image as without jacket gives a large highlighted area as
% well (thanks bruce)
faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, s(1).cdata);
bbox(1) = bbox(1) + 100;
bbox(3) = bbox(3) - 200;
bbox=bbox(size(bbox,1),:);

newVid = struct('cdata',zeros((halfFrameWidth * 2 + 1),(halfFrameHeight * 2 + 1),3,'uint8'),'colormap', []);

imshow(imcrop(s(1).cdata, bbox));

[lipRoughX, lipRoughY] = getLipCentre(imcrop(s(1).cdata, bbox));
lipRoughX = lipRoughX + bbox(2);
lipRoughY = lipRoughY + bbox(1);

for frame = 1:length(s)
    % Assume face doesnt move that much after first frame to improve
    % performance
    data = s(frame).cdata;
    grayImage = getLipsApplyDCT(data((lipRoughY - 200):(lipRoughY + 200), (lipRoughX - 200):(lipRoughX + 200), :), halfFrameWidth, halfFrameHeight);
    newVid(frame).cdata = cat(3, grayImage, grayImage, grayImage);
    imwrite(newVid(frame).cdata, strcat('frames\red\', num2str(frame,'%03d'), '_test.png'));
end

hf = figure;
set(hf,'position',[150 150 (halfFrameHeight * 2 + 1) (halfFrameWidth * 2 + 1)]);
movie(hf,newVid,1,v.FrameRate);

v = VideoWriter("test.avi");
open(v);
writeVideo(v, newVid);
close(v);

end

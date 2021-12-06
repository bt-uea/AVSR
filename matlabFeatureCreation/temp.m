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

newVid = struct('cdata',zeros((halfFrameWidth * 2 + 1),(halfFrameHeight * 2 + 1),3,'uint8'),'colormap',[]);

for frame = 1:length(s)
    newVid(frame).cdata = getLipsApplyDCT(s(frame).cdata, halfFrameWidth, halfFrameHeight);
end

hf = figure;
set(hf,'position',[150 150 (halfFrameHeight * 2 + 1) (halfFrameWidth * 2 + 1)]);
movie(hf,newVid,1,v.FrameRate);

v = VideoWriter("test.avi");
open(v);
writeVideo(v, newVid);
close(v);

end

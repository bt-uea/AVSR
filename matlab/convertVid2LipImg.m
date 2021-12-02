function [] = convertVid2LipImg(videoPath)

v = VideoReader(videoPath);
vidHeight = v.Height;
vidWidth = v.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(v)
s(k).cdata = readFrame(v);
k = k+1;
end

for frame = 1:length(s)
    imgOut = tempNormalizeGreen(s(frame).cdata);

    imwrite(imgOut, strcat('matlab\Lips\', num2str(frame,'%03d'), '_test.png'));
end

end


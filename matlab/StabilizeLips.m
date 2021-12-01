% StabilizeLips('mp4s/harry_WIN_20211127_11_22_07_Pro.mp4')
function [newVid] = StabilizeLips(videoPath)

v = VideoReader(videoPath);
vidHeight = v.Height;
vidWidth = v.Width;
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),'colormap',[]);

k = 1;
while hasFrame(v)
s(k).cdata = readFrame(v);
k = k+1;
end

P = roipoly(s(1).cdata);

ptr = find(P);

M1 = double(s(1).cdata);
R = M1(:,:,1);
G = M1(:,:,2);
B = M1(:,:,3);
cm = [mean(R(ptr)) mean(G(ptr)) mean(B(ptr))];

D = sqrt((M1(:,:,1) - cm(1)).^2 + (M1(:,:,2) - cm(2)).^2 + (M1(:,:,3) - cm(3)).^2);


L = D < std(D(:));

SE = strel('disk', 11);

closeVal = imclose(L, SE);

[labeled, num] = bwlabel(closeVal, 8);

hold on;
imshow(labeled);

maxDiam = 0;

for i = 1:num
    stats = regionprops(labeled==i, 'Centroid', 'MajorAxisLength','MinorAxisLength');
    diameter = mean([stats.MajorAxisLength stats.MinorAxisLength],2);

    if(diameter > maxDiam)
        finalStats = stats;
        maxDiam = diameter;
    end
end

% radii = maxDiam / 2;
% viscircles(finalStats.Centroid, radii);
finalStats.Centroid
height = round(maxDiam);
width = round(maxDiam * 2);
widthHalf = round(width / 2);
heightHalf = round(height / 2);
rect = rectangle('Position', [(finalStats.Centroid(1) - width / 2) (finalStats.Centroid(2) - height / 2) width height]);
rect.EdgeColor = 'red';
hold off;

newVid = struct('cdata',zeros(height,width,3,'uint8'),'colormap',[]);

for i = 1:length(s)
    M1 = double(s(i).cdata);

    D = sqrt((M1(:,:,1) - cm(1)).^2 + (M1(:,:,2) - cm(2)).^2 + (M1(:,:,3) - cm(3)).^2);

    L = D < std(D(:));
    
    closeVal = imclose(L, SE);

    [labeled, num] = bwlabel(closeVal, 8);

    maxDiam = 0;

    for j = 1:num
        stats = regionprops(labeled==j, 'Centroid', 'MajorAxisLength','MinorAxisLength');
        diameter = mean([stats.MajorAxisLength stats.MinorAxisLength],2);

        if(diameter > maxDiam)
            finalStats = stats;
            maxDiam = diameter;
        end
    end

    frame = s(i);

    midPos = round(finalStats.Centroid);

    frameWidthOne = (midPos(1) - widthHalf);
    frameWidthTwo = (midPos(1) + widthHalf);
    frameHeightOne = (midPos(2) - heightHalf);
    frameHeightTwo = (midPos(2) + heightHalf);
    
    newFrame = frame.cdata(frameHeightOne:frameHeightTwo, frameWidthOne:frameWidthTwo, :);

    newVid(i).cdata = newFrame;
end

hf = figure;
set(hf,'position',[150 150 width height]);
movie(hf,newVid,1,v.FrameRate);

v = VideoWriter("test.avi");
open(v);
writeVideo(v, newVid);
close(v);

% imshow(imclose(L, SE));

% frameOfVid = imread("frames\red\alex_WIN_20211127_11_19_45_Pro_Moment.jpg");

% frameResolution = size(frameOfVid);

% bw = frameOfVid(:, :, 1) > 200;

% imshow(frameOfVid);
% figure;
% imshow(bw);

end


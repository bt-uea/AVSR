function  tempAddRedAndGreen()
    
    v = VideoReader('mp4s\alejandro_WIN_20211127_11_20_43_Pro.mp4');
    
    % This was a tricky frame when I was trying to process it earlier as it
    % picked up a lot of red on the chin
    frame = read(v, [55,55]);
    
    imshow(GetRed(frame)+tempNormalizeGreen2(frame));
    
    
end


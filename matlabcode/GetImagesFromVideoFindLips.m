function imgs = GetImagesFromVideoFindLips(fileName)

    v = VideoReader(fileName);
    
    i=1;
    numFrames = v.NumFrames;
    imgs=zeros(numFrames,600,600,'logical');
    
    
    while hasFrame(v)
        frame = readFrame(v);
        img = processFrame(frame);

        imgs(i,:,:) = img;    
        
        if mod(i,20) == 0 
            fprintf('Processing frame %d/%d\n', i,numFrames);
        end

        i=i+1;
    end
    
    
end

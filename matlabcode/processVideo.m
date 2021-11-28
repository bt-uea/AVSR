function processVideo(fileName)


    [filepath,name,ext] = fileparts(fileName);
    
    outFolderPath = strcat(filepath, '\', name, '\');

    if ~exist(outFolderPath, 'dir')
        mkdir(outFolderPath);
    end
    
    v = VideoReader(fileName);
    
    i=1;
    
    while hasFrame(v)
        frame = readFrame(v);
        imgOut = processFrame(frame);       
        
        imwrite(imgOut, strcat(outFolderPath, num2str(i,'%03d'), '_',  name, '.png'));
        i=i+1;
    end

end


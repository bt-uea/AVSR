function processFrames(frameFileFilter)

    frameFiles = dir(frameFileFilter);

    folderPath = strcat(frameFiles(1).folder, '/', 'processed', '/');

    if ~exist(folderPath, 'dir')
        mkdir(folderPath);
    end

    for i = 1:numel(frameFiles)
        fileName = strcat(frameFiles(i).folder, '\', frameFiles(i).name);
        img = imread(fileName);
        imgOut = ProcessFrame(img);       
        
        imwrite(imgOut, strcat(folderPath, frameFiles(i).name));
    end

end


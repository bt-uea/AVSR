function processframes(frameFileFilter)

    frameFiles = dir(frameFileFilter);

    folderPath = strcat(frameFiles(1).folder, '/', 'processed', '/');

    if ~exist(folderPath, 'dir')
        mkdir(folderPath);
    end

    for i = 1:numel(frameFiles)
        fileName = strcat(frameFiles(i).folder, '\', frameFiles(i).name);
        img = imread(fileName);
        
        % Remove anything not red
        img = img - img(:,:,2) - img(:,:,3);
        
        % Crop Edges
        img = cropedges(img);
        
        imwrite(img, strcat(folderPath, frameFiles(i).name));
        
        
    end

end


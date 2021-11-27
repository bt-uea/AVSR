function processframes(frameFileFilter)

    frameFiles = dir(frameFileFilter);

    folderPath = strcat(frameFiles(1).folder, '/', 'processed', '/');

    if ~exist(folderPath, 'dir')
        mkdir(folderPath);
    end

    faceDetector = vision.CascadeObjectDetector();

    for i = 1:numel(frameFiles)
        fileName = strcat(frameFiles(i).folder, '\', frameFiles(i).name);
        img = imread(fileName);
        
        bbox = step(faceDetector, img)
        bbox=bbox(size(bbox,1),:);
        img = imcrop(img,bbox);
        img = img-img(:,:,2)-img(:,:,3);
        img=img-img(:,:,2)-img(:,:,3);
        img = img(:,:,1);
        
        imwrite(img, strcat(folderPath, frameFiles(i).name));
    end

end


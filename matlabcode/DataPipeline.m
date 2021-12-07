function DataPipeline(fileName)

    [filepath,name,ext] = fileparts(fileName);

%### Get images from video and Isolate lips
    imgs = GetImagesFromVideo(fileName);
%### Store as new video
    filepathLips = strcat(filepath, '\..\lips\' );

    if ~exist(filepathLips, 'dir')
        mkdir(filepathLips);
    end
    
    lipsVideoFileName = strcat(filepathLips, name, '.mp4');
    
    SaveImagesToVideo(imgs,30,1, lipsVideoFileName);
%### Primary Component Analysis
    lipImages = GetImagesFromVideo(lipsVideoFileName);
    featureVectors = GetPCA(lipImages);
%### Feature Extraction
%### Upscale
%### Save Features 

    filepathFeatures = strcat(filepath, '\..\features\' );

    if ~exist(filepathFeatures, 'dir')
        mkdir(filepathFeatures);
    end

    mfcFileName = strcat(filepathFeatures, name, '.mfc');
    saveMFCC(mfcFileName,featureVectors,10,6,0);
   
end

function DataPipeline(fileName)

    [filepath,name,ext] = fileparts(fileName);

%### Get images from video and Isolate lips
    imgs = GetImagesFromVideoFindLips(fileName);
    numFrames = size(imgs,1);
    filepathLips = strcat(filepath, '\..\lips\' );

    if ~exist(filepathLips, 'dir')
        mkdir(filepathLips);
    end
    
    filepathVids = strcat(filepathLips, 'vids\' );
    filepathData = strcat(filepathLips, 'data\' );
    
    lipsImageMatrix = strcat(filepathData, name, '.dat');
       
    writematrix(imgs,lipsImageMatrix);
    %imgs=readmatrix(lipsImageMatrix);
%### Store as new video
   
    lipsVideoFileName = strcat(filepathVids, name, '.mp4');
    
    %SaveImagesToVideo(imgs,0.03,1, lipsVideoFileName);

    %imgs=readmatrix(lipsImageMatrix);
    %imgs=reshape(imgs,size(imgs,1),size(imgs,2)^0.5,size(imgs,2)^0.5);
%### Primary Component Analysis
    %lipImages = GetImagesFromVideo(lipsVideoFileName);
    lipImages = imgs;
    lipImages=reshape(lipImages,numFrames,600*600);
    featureVectors = GetPCA(lipImages,10);
%### Feature Extraction
%### Upscale
%### Save Features 

    filepathFeatures = strcat(filepath, '\..\features\' );

    if ~exist(filepathFeatures, 'dir')
        mkdir(filepathFeatures);
    end
    
    logfv = log(featureVectors);

    mfcFileName = strcat(filepathFeatures, name, '.mfc');
    MFCCsave(mfcFileName,logfv,0.0333333,9,0);
   
end

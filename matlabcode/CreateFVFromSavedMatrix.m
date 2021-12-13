function CreateFVFromSavedMatrix(fileName,numComponents)

    [filepath,name,ext] = fileparts(fileName);

    imgs = readmatrix(fileName);

%### Primary Component Analysis
    %lipImages = GetImagesFromVideo(lipsVideoFileName);
    lipImages = imgs;
    %lipImages=reshape(imgs, size(imgs,1), size(imgs,2)^0.5, size(imgs,2)^0.5);
    
%### Feature Extraction
%### Upscale
%### Save Features

    filepathFeatures = strcat(filepath, '\..\..\features\' );

    if ~exist(filepathFeatures, 'dir')
        mkdir(filepathFeatures);
    end

    %featureVectors = Create_FV_PCA(lipImages,numComponents);
    %featureVectors = AddDeltas(featureVectors);
    %logfv = log(featureVectors);
    featureVectors = Create_FV_DCT(lipImages,numComponents);
    
    %vectorSamplePeriod = 0.0333333;
    vectorSamplePeriod = 0.02;
    
    fps_from = 30;
    fps_to = 1  / vectorSamplePeriod;
    featureVectors = UpsampleFV(featureVectors, fps_from, fps_to);

    %fv=featureVectors;
  
    filepathFeaturesLog = strcat(filepathFeatures, '\LOG\' );
    filepathFeaturesNoLog = strcat(filepathFeatures, '\NOLOG\' );

    if ~exist(filepathFeaturesLog, 'dir')
        mkdir(filepathFeaturesLog);
    end
    if ~exist(filepathFeaturesNoLog, 'dir')
        mkdir(filepathFeaturesNoLog);
    end
    
    mfcFileNameLog = strcat(filepathFeaturesLog, name, '.mfc');
    mfcFileNameNoLog = strcat(filepathFeaturesNoLog, name, '.mfc');
    
    %MFCCsave(mfcFileName,featureVectors,0.0333333,9,0);
    %MFCCsave(mfcFileNameLog,logfv,0.0333333,9,0);

    
    overlapPercent=0.5;
    overlapPercent=0;
    
    MFCCsave(mfcFileNameNoLog,featureVectors,vectorSamplePeriod,9,overlapPercent);

end

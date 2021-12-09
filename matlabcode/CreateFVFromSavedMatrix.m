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
    featureVectors = Create_FV_DCT(lipImages,numComponents);
    

    mfcFileName = strcat(filepathFeatures, name, '.mfc');
    saveMFCC(mfcFileName,featureVectors,0.0333333,9,0);

end

function featureVectors = CreateFeatureVectorsForFile(fileName)
    %CREATEFEATUREVECTORS Summary of this function goes here
    %   Detailed explanation goes here

    v = VideoReader(fileName);
    
    i=1;
    numFrames = v.NumFrames;
    imgs=zeros(numFrames,360000);
    
    
    while hasFrame(v)
        frame = readFrame(v);
        img = processFrame(frame);

        img_f = FlattenImage(img);
        imgs(i,:) = img_f;    
        
        if mod(i,20) == 0 
            fprintf('Processing frame %d/%d', i,numFrames);
        end

        i=i+1;
    end
    
    featureVectors = GetPCA(imgs);
    
    [filepath,name,ext] = fileparts(fileName);
    
    filepath = strcat(filepath, '\..\features\' );
    
    if ~exist(filepath, 'dir')
        mkdir(filepath);
    end
    

    mfcFileName = strcat(filepath, name, '.mfc');
    
    saveMFCC(mfcFileName,featureVectors,10,6,0);
    
end

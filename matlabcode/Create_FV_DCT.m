function fv = Create_FV_DCT(imgs, numComponents)

    numFrames = size(imgs,1);
    
    featureVectors = zeros(numFrames,numComponents,'double');
    
    for i = 1:numFrames
        img = imgs(i,:,:);
        vector = dct2(img);
        vector = zigzag(vector);
        vector = vector(1:numComponents);
        featureVectors(i,:) = vector; 
    end 

    fv = featureVectors;

end

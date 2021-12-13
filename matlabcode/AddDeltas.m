function fv = AddDeltas(featureVectors)

    [numFrames, numVectors] = size(featureVectors);
    
    prevFV = zeros(1,numVectors);
    
    newFV = zeros(numFrames,numVectors*2);

    for i = 1:numFrames
        featureVector = featureVectors(i,:);
        
       
        delta = featureVector - prevFV;
        prevFV = featureVector;
        
        newFV(i,:) = cat(2,featureVector, delta);
        
    end
    
    fv = newFV;



end

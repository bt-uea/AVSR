function fv = Create_FV_PCA(imgs, numComponents)

    featureVectors = GetPCA(imgs,numComponents);
    logfv = log(featureVectors);
    fv =logfv;

end

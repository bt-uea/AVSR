function CreateFeatureVectorsForFolder(fileFilter, numComponents)
   files = dir(fileFilter);
    
    for i = 1:numel(files)
        file = strcat(files(i).folder, '\', files(i).name);
        CreateFVFromSavedMatrix(file,numComponents);
    end
    
end

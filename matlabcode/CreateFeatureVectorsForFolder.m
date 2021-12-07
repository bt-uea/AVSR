function CreateFeatureVectorsForFolder(fileFilter)
   files = dir(fileFilter);
    
    for i = 1:numel(files)
        file = strcat(files(i).folder, '\', files(i).name);
        CreateFeatureVectorsForFile(file);
    end
    
end

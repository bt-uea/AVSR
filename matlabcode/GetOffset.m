function offset = GetOffset(imgIn)

    s=regionprops(imgIn,'Centroid');
    centroids = cat(1, s.Centroid);
    % centroid now contains x and y (in that order)
    
    x_c = centroids(:,1);
    y_c = centroids(:,2);
    
    s = size(imgIn);
    % imageSize now contains height and width (in that order)
    height = s(:,1);
    width = s(:,2);
    
    x = x_c - (width/2);
    y = y_c - (height/2);
    
    offset = [x, y];
    
    
end


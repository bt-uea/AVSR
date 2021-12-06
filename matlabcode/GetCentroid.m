function centroids = GetCentroid(imgIn)

    s=regionprops(imgIn,'Centroid');
    centroids = cat(1, s.Centroid);
    % centroid now contains x and y (in that order)
    
end


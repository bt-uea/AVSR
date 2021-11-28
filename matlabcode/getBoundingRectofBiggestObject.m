function r = getBoundingRectofBiggestObject(img)

    bbox = regionprops(ExtractNLargestBlobs(img,1),'BoundingBox');
    
    coords = bbox.BoundingBox;

    r = images.spatialref.Rectangle([coords(1) coords(1) + coords(3)], ...
                                    [coords(2) coords(2) + coords(4)]);
                              
end


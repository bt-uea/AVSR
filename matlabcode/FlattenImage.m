%% Useful for preparing for feature extraction.
% Takes row, col based image matrix and creates single 1-D array
% Can be used prior to DCT and PCA
function flattenedImage = FlattenImage(img)
    
    out = [];
    
    [rows, cols] = size(img);
    
    out = reshape(img,[1,rows*cols]);
    
    %for r = 1: rows
    %    out = [out,img(r,:)];
    %end

    flattenedImage = out;
      

end


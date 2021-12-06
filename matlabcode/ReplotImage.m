function imgOut = ReplotImage(imgIn, x_centroid, y_centroid)

    s = size(imgIn);
    % imageSize now contains height and width (in that order)
    height = s(:,1);
    width = s(:,2);
    
    newDim = max(height, width);
    newDim = int16(newDim*1.2);
    
    x_offset = (width/2) - x_centroid;
    y_offset = (height/2) - y_centroid;
    

    top_rows = int16((newDim - height - y_offset) /2);
    bottom_rows = newDim - top_rows - height;
    left_cols = int16((newDim - width - x_offset) /2);
    right_cols = newDim - left_cols - width;
    %pad top rows %pad bottom rows
    imgIn = [zeros(top_rows,size(imgIn,2)); imgIn; zeros(bottom_rows,size(imgIn,2))];
    
    %pad left cols %pad right cols
    imgIn = [zeros(size(imgIn,1),left_cols)  imgIn  zeros(size(imgIn,1),right_cols)];   
    
    imgOut = imgIn;
    
    %imgOut = image(newImg);
    %hold on;
    
    %imgOut = image(10,10,imgIn);
    
    %imgOut = newImg;
    
    
    
end


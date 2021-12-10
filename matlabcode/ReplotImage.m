function imgOut = ReplotImage(imgIn, x_centroid, y_centroid)

    s = size(imgIn);
    % imageSize now contains height and width (in that order)
    height = s(:,1);
    width = s(:,2);
    
    newDim = max(height, width);
    newDim = int16(newDim*1.2);
    newDim=600;
    
    x_offset =  x_centroid - (width/2);
    % these are the oppostite way round because of the different coordinate
    % system
    y_offset = y_centroid - (height/2);
    
    % inserted the lines below to investigate effect of stabilisation
    %x_offset =  (width/2);
    %y_offset = (height/2);
    

    top_rows = int16(((newDim - height) /2) - y_offset);
    bottom_rows = newDim - top_rows - height;
    
    left_cols = int16(((newDim - width) /2) - x_offset);
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


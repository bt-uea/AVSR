% [1 3 5; 2 4 6; 7 8 10]
function [outputImage] = MorphDilate(imageSrc, filterKernel)
    [rowsImg, colsImg] = size(imageSrc);
    
    [rowsFilter, colsFilter] = size(filterKernel);
    
    
    % Supports an odd number, square matrix
    if rowsFilter ~= colsFilter
        error('Error. \n row and column size should be the same.')
    end
    
    offset = (rowsFilter - 1)/2;
    
    outputImage = zeros(rowsImg);
           
    
    for r = 1:rowsImg
        for c = 1:colsImg
            
            r1 = max([r - offset, 1]);
            r2 = min([r + offset, rowsImg]);
            
            c1 = max([c - offset, 1]);
            c2 = min([c + offset, colsImg]);
            
            window = imageSrc(r1:r2, c1:c2);
            value = getValue(window, filterKernel);
            
            outputImage(r,c) = value;
            
            
        end
    end
    
end

function value = getValue(window, filterKernel)

    [rw, cw] = size(window);
    [rf, cf] = size(filterKernel);

    if rw ~= rf | cw ~= cf
        value = 0;
    else
         mult = double(window).*filterKernel;
         value=sum(mult,'all');
         if (value>0); value = 1;else; value = 0; end
    end
   
end
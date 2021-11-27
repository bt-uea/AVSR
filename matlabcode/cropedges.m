function img = cropedges(img)

    [rows,cols] = size(img);
    
    %%%% PROCESS ROWS
    % First Rows
    for r = 1:rows
        firstNonBlankRow = r;
        if sum(img(r,:),'all') ~= 0
            break;
        end
    end
    
    img(1:firstNonBlankRow,:) = [];
    
    [rows,cols] = size(img);
   
    % Remove white space from bottom rows, exit for when we find non white
    % space
    % Last rows
    for r = rows:-1:1
        if sum(img(r,:),'all') ~= 0
            break;
        end
        img(r,:)=[];
    end
    
    %%% PROCESS COLS
    % First cols
   [rows,cols] = size(img);
    
    for c = 1:cols
        firstNonBlankCol = c;
        if sum(img(:,c),'all') ~= 0
            break;
        end
    end
    
    img(:,1:firstNonBlankCol) = [];
    
    [rows,cols] = size(img);
   
    % Remove white space from bottom rows, exit for when we find non white
    % space
    for c = cols:-1:1
        if sum(img(:,c),'all') ~= 0
            break;
        end
        img(:,c)=[];
    end
   
       
end


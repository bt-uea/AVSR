function imgs = TrimEmptyEdgesOffImageArray(imgs)

    % Remove top empty rows
    while (~any(imgs(:,1,:),'all'))
        imgs(:,1,:) = [];
    end

    % Remove bottom empty rows
    while (~any(imgs(:,end,:),'all'))
        imgs(:,end,:) = [];
    end

    % Remove left empty cols
    while (~any(imgs(:,:,1),'all'))
        imgs(:,:,1) = [];
    end
    
    % Remove right empty cols
    while (~any(imgs(:,:,end),'all'))
        imgs(:,:,end) = [];
    end
    

end


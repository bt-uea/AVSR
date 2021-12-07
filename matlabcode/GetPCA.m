% xim = img_mu' + imgP * imgOut(1,:)'
% xim = reshape(xim', 600, 600, 1);
% figure
% imshow(xim);

function imgOut = GetPCA(fileFilter)

    files = dir(fileFilter);
    
    imgs=[];
    
    for i = 1:numel(files)
        file = strcat(files(i).folder, '\', files(i).name);
        img = imread(file);
        img_f = FlattenImage(img);
        imgs = [imgs; img_f];       
    end
    
    img_mu = mean(imgs, 1);
    
    %% call pca for eigen lips

    % imgP are the principal components
    % here, I decided to retain only 15 components

    imgP = pca(imgs-img_mu, 'NumComponents', 15);

    %% get parameters from the data - used as features for ASR

    imgOut = (imgs - img_mu) * imgP;
    
end


% xim = img_mu' + imgP * imgOut(1,:)'
% xim = reshape(xim', 600, 600, 1);
% figure
% imshow(xim);

function imgOut = GetPCA(imgs, numComponents)

    img_mu = mean(imgs, 1);
    
    %% call pca for eigen lips

    % imgP are the principal components

    %imgP = pca(imgs-img_mu, 'NumComponents', numComponents);
    [imgP,score,latent,tsquared,explained,mu] = pca(imgs-img_mu, 'NumComponents', numComponents);
    
    fprintf('explained %d/\n', explained);

    %% get parameters from the data - used as features for ASR

    imgOut = (imgs - img_mu) * imgP;
    
end


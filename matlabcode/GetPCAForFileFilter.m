% xim = img_mu' + imgP * imgOut(1,:)'
% xim = reshape(xim', 600, 600, 1);
% figure
% imshow(xim);

function imgOut = GetPCAForFileFilter(fileFilter)

    files = dir(fileFilter);
    
    imgs=[];
    
    for i = 1:numel(files)
        file = strcat(files(i).folder, '\', files(i).name);
        img = imread(file);
        img_f = FlattenImage(img);
        imgs = [imgs; img_f];       
    end
    
    imgOut = GetPCA(imgs);
 
end


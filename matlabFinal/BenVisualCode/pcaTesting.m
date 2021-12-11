function pcaTesting(struct)

originalImageSize = size(struct(1).cdata);

numPixels = numel(struct(1).cdata);

resizedImage = [];

for k = 1:length(struct)
    newArr = reshape(struct(k).cdata, numPixels, 1);
    resizedImage = [resizedImage; newArr];
end

im_m = mean(resizedImage, 1);

imgP = pca(resizedImage-im_m, 'NumComponents', 15);

imgB = (resizedImage - im_m) * imgP;

xim = im_m' + imgP * imgB;

xim = reshape(xim', originalImageSize);
figure
imshow(xim);

end


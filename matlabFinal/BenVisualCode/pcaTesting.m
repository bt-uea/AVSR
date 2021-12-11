function pcaTesting(struct)

imshow(struct(1).cdata);
percent = 1;
data = imresize(struct(1).cdata, percent, 'nearest');
originalImageSize = size(data);
numPixels = numel(data);

resizedImage = [];

for k = 1:length(struct)
    data = imresize(struct(k).cdata, percent, 'nearest');
    newArr = double(reshape(data, 1, numPixels));
    resizedImage = [resizedImage; newArr];
end

im_m = mean(resizedImage, 1);

dif = resizedImage-im_m;

imgP = pca(dif, 'NumComponents', 10);

imgB = dif * imgP;

imgPSize = size(imgP)

for i = 1:length(imgB)
    xim = im_m' + imgP * imgB(i, :)';

    xim = reshape(xim', originalImageSize(1), originalImageSize(2), originalImageSize(3));
    imshow(xim);
end

end


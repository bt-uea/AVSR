### Command line
ffmpeg -i .\albi_WIN_20211127_11_20_21_Pro.mp4 -framerate 20 albi/frames/albi_frame%03d.png


### Matlab
img = imread('.\AVSR\mp4s\albi\frames\frame001.png');
imshow(img, []);
imshow(img-img(:,:,2)-img(:,:,3));
imshow(imcomplement(img-img(:,:,2)-img(:,:,3)));
imshow(rgb2gray(imgf))


img=img(:,:,1)
faceDetector=vision.CascadeObjectDetector();
bbox            = step(faceDetector, img);
imshow(imcrop(img,bbox));
imshow(img-img(:,:,2)-img(:,:,3));
img=img-img(:,:,2)-img(:,:,3);
imshow(img(:,:,1));

im2bw(img,0.15)

### Find lips
Things might try:
https://uea-teaching.github.io/audio-visual-2021/lectures/linear-filtering.html#/image-filters-as-templates-2
https://uea-teaching.github.io/audio-visual-2021/lectures/non-linear-filtering.html#/dilation-example

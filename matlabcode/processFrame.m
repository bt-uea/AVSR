function imgOut = processFrame(imgFrame)

    faceDetector = vision.CascadeObjectDetector();

    img = imgFrame;

    bbox = step(faceDetector, img);
    % sometimes multiple bounding boxes are returned. Last one in array
    % appears to be the smallest one, bounding the face
    bbox=bbox(size(bbox,1),:);
    img = imcrop(img,bbox);
    img = img-img(:,:,2)-img(:,:,3);
    img=img-img(:,:,2)-img(:,:,3);
    img = img(:,:,1);

    imgBinary = im2bw(img,0.15);

    % Frame 13, 57, 58 pick up noise on chin
    imgDilated = DilateImage(imgBinary);
    imgEroded = ErodeImage(imgDilated);
    r = getBoundingRectofBiggestObject(imgEroded);

    imgOut = imcrop(img,r);

end


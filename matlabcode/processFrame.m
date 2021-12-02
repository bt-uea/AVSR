function imgOut = processFrame(imgFrame)

    faceDetector = vision.CascadeObjectDetector();

    img = imgFrame;

    bbox = step(faceDetector, img);
    % sometimes multiple bounding boxes are returned. Last one in array
    % appears to be the smallest one, bounding the face
    bbox=bbox(size(bbox,1),:);
    img = imcrop(img,bbox);
    %img = img-img(:,:,2)-img(:,:,3);
    %% Do we need this line?
    %img= img-img(:,:,2)-img(:,:,3);
    %img = img(:,:,1);
    %imgGreen = tempNormalizeGreen2(img, 200, 50);
    imgGreen = tempNormalizeGreen2(img);
    imgRed = GetRed(img);

    imgRed = im2bw(imgRed,0.3);
    imgRebuilt = imgRed + imgGreen;

    % Frame 13, 57, 58 pick up noise on chin
    dilateKernel3 = [0 0 0; 1 1 1; 0 0 0;];
    imgDilated = MorphDilate(imgRebuilt, dilateKernel3);
    %imgEroded = ErodeImage(imgDilated);

    r = getBoundingRectofBiggestObject(imgDilated);
    %r = getBoundingRectofBiggestObject(img);
    
    imgCropped = imcrop(imgDilated,r);
    imgEdges = edge(imgCropped,'Canny', [0.4, 0.5], 6);
       

    %imgOut = imcrop(img,r);
    %imgOut = imcrop(imgBinary, r);
    %imgOut = imcrop(img, r);
    
    %imgOut = 
    imgOut = imgEdges;
    %imgOut = ExtractNLargestBlobs(imgEdges, 2);
   
   

end


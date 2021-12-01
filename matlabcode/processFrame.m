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
    imgGreen = tempNormalizeGreen(img,200, 50);

    imgBinary = im2bw(img,0.15);

    % Frame 13, 57, 58 pick up noise on chin
    imgDilated = DilateImage(imgBinary);
    imgEroded = ErodeImage(imgDilated);

    r = getBoundingRectofBiggestObject(imgEroded);
    %r = getBoundingRectofBiggestObject(img);
    
    imgCropped = imcrop(imgGreen);
    imgEdges = edge(imgCropped,'Canny');
    

    %imgOut = imcrop(img,r);
    %imgOut = imcrop(imgBinary, r);
    %imgOut = imcrop(img, r);
    
    %imgOut = 
    imgOut = imgEdges;
    %imgOut = ExtractNLargestBlobs(imgEdges, 2);
   
   

end


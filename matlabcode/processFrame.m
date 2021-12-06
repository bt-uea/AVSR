function [imgOut, centroids] = processFrame(imgFrame)

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
    
    centroids = GetCentroid(imgCropped);
    % centroid now contains x and y (in that order)
    x_c = centroids(:,1);
    y_c = centroids(:,2);
    imgCropped = ReplotImage(imgCropped,x_c,y_c);
    %imshow(rotateAround(pf, centroids(:,2), centroids(:,1), 180));

    
    imageSize = size(imgCropped);
    % imageSize now contains height and width (in that order)
    

    thresholds = [0.4, 0.5];
    sigma = 6;
    imgEdges = edge(imgCropped, 'Canny', thresholds, sigma);
       

    %imgOut = imcrop(img,r);
    %imgOut = imcrop(imgBinary, r);
    %imgOut = imcrop(img, r);
    
    %imgOut = 
    imgOut = imgEdges;
    %imgOut = imgCropped;
    %imgOut = ExtractNLargestBlobs(imgEdges, 2);
   
   

end


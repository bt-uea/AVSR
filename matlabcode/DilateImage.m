function outImg = DilateImage(img)

    dilateKernel5 = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
    dilateKernel3 = [1 1 1; 1 1 1; 1 1 1;];
    outImg = MorphDilate(img,dilateKernel3);
    
end


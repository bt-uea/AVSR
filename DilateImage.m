function outImg = DilateImage(img)

    kernel5 = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
    outImg = MorphDilate(img,kernel5);
    
end


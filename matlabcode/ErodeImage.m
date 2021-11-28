function outImg = ErodeImage(img)

    kernel5 = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
    kernel3 = [1 1 1; 1 1 1; 1 1 1;];
    outImg = MorphErode(img,kernel3);
    
end


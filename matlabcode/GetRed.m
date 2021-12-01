function imgOut = GetRed(imgIn)

    imgIn= imgIn-imgIn(:,:,2)-imgIn(:,:,3);
    imgIn = imgIn(:,:,1);
    
    imgOut = im2bw(imgIn, 0.3);

end


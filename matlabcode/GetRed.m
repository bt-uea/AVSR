function imgOut = GetRed(imgIn)

    imgIn= imgIn-imgIn(:,:,2)-imgIn(:,:,3);
    imgOut = imgIn(:,:,1);
    
end


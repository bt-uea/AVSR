function fv = UpsampleFV(videoFs, fps_from, fps_to)
    
    % reshape(videoFs,size(videoFs,1),size(videoFs,2)*size(videoFs,3)
    % for logical arrays - B&W images, do this
    % videoFs=cast(videoFs,'double');
    % Interp Combine and return vectors
    numVideoFs = size(videoFs,1);
    newNumVideoFs = numVideoFs * fps_to / fps_from;
    
    period = (numVideoFs / newNumVideoFs);

    % currentVec = 1:sampleTime:(sampleTime * numVideoFs)); - current spacing
    interpolatedVideoFs = interp1(videoFs, 1:  period : numVideoFs);

    fv = interpolatedVideoFs;

end


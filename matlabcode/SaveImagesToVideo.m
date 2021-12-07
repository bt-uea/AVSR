function SaveImagesToVideo(imgs, frameRate,timesFrameDuplicated, videoFileName)

    % create the video writer with 1 fps
     writerObj = VideoWriter(videoFileName,'MPEG-4');
     writerObj.FrameRate = frameRate;
     map=colormap(gray(256));

     % open the video writer
     open(writerObj);
     % write the frames to the video
     for u=1:size(imgs,1)
         % convert the image to a frame
         img=imgs(u,:,:);
         img=reshape(img,[],size(img,2),1);
         frame = im2frame(uint8(256*img), map);
         for v=1:timesFrameDuplicated
             writeVideo(writerObj, frame);
         end
     end
     % close the writer object
     close(writerObj);

end


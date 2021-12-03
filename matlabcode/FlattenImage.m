function flattenedImage = FlattenImage(img)
    
    out = [];
    
    [rows, cols] = size(img);
    
      for r = 1: rows
        out = [out,img(r,:)];
      end
      
      flattenedImage = out;
      

end


![Remove blue and green](0.png)
>> % Remove blue and green
>> imshow(img-img(:,:,2)-img(:,:,3));
![Remove blue and green](1.png)

>> % Crop Image
![Crop Image](22.png)

>> % Get image complement (negative)
>> imshow(imcomplement(img-img(:,:,2)-img(:,:,3)));
![ Get image complement (negative)](32.png)

<!--
>> % Get image complement (negative)
>> imshow(imcomplement(img-img(:,:,2)-img(:,:,3)));
![ Get image complement (negative)](2.png)
>> % Convert to grayscale
>> imshow(rgb2gray(imcomplement(img-img(:,:,2)-img(:,:,3))));
![Convert to grayscale](3.png)
![Convert to grayscale](4.png)

imshow(imcomplement(cropedges(img-img(:,:,2)-img(:,:,3))));
-->

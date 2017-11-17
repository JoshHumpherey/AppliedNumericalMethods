% Final Project: Tumor Recognition Matlab Script

% Read in an image and convert it to grayscale
originalPhoto = imread('tumor1.png');
grayscalePhoto = rgb2gray(originalPhoto);
figure
imshow(grayscalePhoto)
title('Grayscale Image')

% Apply a high pass filter to the image
hpf = [-1 -1 -1;-1 10 -1;-1 -1 -1];
hpfImage = imfilter(grayscalePhoto, hpf, 'same');
figure
imshow(hpfImage)
title('HPF Image')

% Apply and display a median filtered image
medianImage = medfilt2(hpfImage, [3,3]);
figure
imshow(medianImage)
title('Median Image')

% Compute and display image opening threshold
se = strel('disk',20);
Io = imopen(medianImage,se);
figure
imshow(Io)
title('Foreground Image')

% Reconstruct the original image
Ie = imerode(medianImage, se);
Iobr = imreconstruct(Ie, medianImage);
figure
imshow(Iobr)
title('Reconstructed Image')

% Apply clarification to the reconstructed image
cl = medfilt2(Iobr, [5,5]);
figure
imshow(cl)
title('Clarified Image')

% Show current progress
imshowpair(grayscalePhoto,cl,'montage')

% Threshold the doctored image into 3 layers
mthresh = multithresh(cl,2);
thresholdImage = imquantize(cl,mthresh);
figure(2)
subplot(1,2,1)
imshow(thresholdImage,[])
title('Threshold image')

% Pick out the top layer as the tumor
tumor = thresholdImage;
for i = 1:length(thresholdImage)
    for j = 1:length(thresholdImage)
        if thresholdImage(i,j) < 3
            tumor(i,j) = 1;
        end
    end
end
% display the tumor
figure(2)
subplot(1,2,2)
imshow(tumor,[])
title('Isolated Tumor')

% Show initial and final images together
figure(3)
imshowpair(grayscalePhoto,tumor,'montage')
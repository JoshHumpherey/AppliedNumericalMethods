% Final Project: Tumor Recognition Matlab Script

% Read in an image and convert it to grayscale
originalPhoto = imread('tumor1.png');
grayscalePhoto = rgb2gray(originalPhoto);
figure
imshow(grayscalePhoto)
title('Grayscale Image')

% Apply a high pass filter to the image
hpf = [-1 -1 -1;-1 8 -1;-1 -1 -1];
hpfImage = imfilter(grayscalePhoto, hpf, 'same');
figure
imshow(hpfImage)
title('HPF Image')

% Apply and display a median filtered image
medianImage = medfilt2(hpfImage);
figure
imshow(medianImage)
title('Median Image')

% Compute and display image segmentation threshold
thresholdImage = imbinarize(medianImage);
figure
imshow(thresholdImage)
title('Threshold Image')


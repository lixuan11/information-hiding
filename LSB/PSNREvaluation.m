clear;
clc;

originalImage = imread('°¢È±¸ßÇå°æ480.bmp');
doubleOriginalImage = double(originalImage);
[oriRow, oriCol] = size(doubleOriginalImage);
PSNRMatrix = [];

for i = 1 : 8
    watermarkedImageName = ['imageWithWatermarkInDepth'  num2str(i)  '.bmp'];
    imageWithWatermark = imread(watermarkedImageName);
    doubleImageWithWatermark = double(imageWithWatermark);
    
    NP = sum(sum(doubleOriginalImage - doubleImageWithWatermark) .^ 2);
    PSNR = 10 * log10(max(max((doubleOriginalImage) .^ 2) * oriRow * oriCol / NP));
    
    PSNRMatrix = [PSNRMatrix; PSNR];
end
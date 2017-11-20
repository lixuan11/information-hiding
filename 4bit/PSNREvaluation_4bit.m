clear;
clc;
originalImage = imread('阿天立体全彩版480.bmp');
doubleOriginalImage = double(originalImage);

imageWithWatermark = imread('imageWithWatermarkAndNoise.bmp');
doubleImageWithWatermark = double(imageWithWatermark);

PSNRMatrix = [];

for level = 1 : 3
    doubleOriginalImageLevel = doubleOriginalImage(:, :, level);
    doubleImageWithWatermarkLevel = doubleImageWithWatermark(:, :, level);
    
    [oriRow, oriCol] = size(doubleOriginalImageLevel);
    
    NP = sum(sum(doubleOriginalImageLevel - doubleImageWithWatermarkLevel) .^ 2);
    PSNR = 10 * log10(max(max((doubleOriginalImageLevel) .^ 2) * oriRow * oriCol / NP));
    PSNRMatrix = [PSNRMatrix; PSNR];
end





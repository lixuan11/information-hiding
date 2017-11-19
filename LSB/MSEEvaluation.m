clear;
clc;

originalImage = imread('°¢È±¸ßÇå°æ480.bmp');
doubleOriginalImage = double(originalImage);
[oriRow, oriCol] = size(doubleOriginalImage);

meanSquareError = [];
meanSquareErrorwithNoise = [];

for i = 1 : 8
    watermarkedImageName = ['imageWithWatermarkInDepth'  num2str(i)  '.bmp'];
    imageWithNoiseName = ['imageWithNoiseInDepth'  num2str(i)  '.bmp'];
    
    imageWithWatermark = imread(watermarkedImageName);
    imageWithNoise = imread(imageWithNoiseName);
    
    doubleImageWithWatermark = double(imageWithWatermark);
    doubleImageWithNoise = double(imageWithNoise);
    
    accumulatorWatermark1 = 0;
    accumulatorWatermark2 = 0;
    
    accumulatorNoise1 = 0;
    accumulatorNoise2 = 0;
    
    for r1 = 1 : oriRow
        for c1 = 1 : oriCol
            a = [doubleOriginalImage(r1, c1) - doubleImageWithWatermark(r1, c1)] .^ 2;
            b = doubleOriginalImage(r1, c1) .^ 2;
            accumulatorWatermark1 = accumulatorWatermark1 + a;
            accumulatorWatermark2 = accumulatorWatermark2 + b;
        end
    end
    
    for r2 = 1 : oriRow
        for c2 = 1 : oriCol
            c = [doubleOriginalImage(r2, c2) - doubleImageWithNoise(r2, c2)] .^ 2;
            d = doubleOriginalImage(r2, c2) .^ 2;
            accumulatorNoise1 = accumulatorNoise1 + c;
            accumulatorNoise2 = accumulatorNoise2 + d;
        end
    end
    
    MSEWatermark = accumulatorWatermark1 / accumulatorWatermark2;
    MSENoise = accumulatorNoise1 / accumulatorNoise2;
    
    meanSquareError = [meanSquareError; MSEWatermark];
    meanSquareErrorwithNoise = [meanSquareErrorwithNoise; MSENoise];
end
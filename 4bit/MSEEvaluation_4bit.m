clear;
clc;

originalImage = imread('阿天立体全彩版480.bmp');
doubleOriginalImage = double(originalImage);

imageWithWatermark = imread('imageWithWatermark.bmp');
doubleImageWithWatermark = double(imageWithWatermark);

imageWithNoise = imread('imageWithWatermarkAndNoise.bmp');
doubleImageWithNoise = double(imageWithNoise);

accumulator1 = 0;
accumulator2 = 0;

accumulatorNoise1 = 0;
accumulatorNoise2 = 0;
    
[oriRow, oriCol] = size(doubleOriginalImage);

for i = 1 : oriRow
    for j = 1 : oriCol
        a = (doubleOriginalImage(i, j) - doubleImageWithWatermark(i, j)) .^ 2;
        b = doubleOriginalImage(i, j) .^ 2;
        accumulator1 = accumulator1 + a;
        accumulator2 = accumulator2 + b; 
    end
end

for i = 1 : oriRow
    for j = 1 : oriCol
        c = [doubleOriginalImage(i, j) - doubleImageWithNoise(i, j)] .^ 2;
        d = doubleOriginalImage(i, j) .^ 2;
        accumulatorNoise1 = accumulatorNoise1 + c;
        accumulatorNoise2 = accumulatorNoise2 + d;
    end
end

MSEWatermark = accumulator1 / accumulator2;
MSENoise = accumulatorNoise1 / accumulatorNoise2;

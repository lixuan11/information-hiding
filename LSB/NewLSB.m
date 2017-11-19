clear all;
clc;

bitDepth = input('Please input a integer between 1 and 8: ');

% [fn1, pn1] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '选择数字水印图');
% originalWatermark = imread(strcat(pn1, fn1));
originalWatermark = imread('活在梦里.bmp');
subplot(4, 2, 1), imshow(originalWatermark), title('原始水印图');

% 将水印图像二进制化
binaryWatermark = im2bw(originalWatermark, 0.4);
[xh_row, xh_col] = size(binaryWatermark);
subplot(4, 2, 2), imshow(binaryWatermark), title('二进制水印');

% [fn2, pn2] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '选择原始图像');
% originalImage = imread(strcat(pn2, fn2));
originalImage = imread('阿缺高清版480.bmp');
% 求出图像的行数和列数
[OIRow, OICol, n] = size(originalImage);
subplot(4, 2, 3), imshow(originalImage), title('原始图像');


% 将原始图像的最低有效位置为0
imageWithZeroLowest = bitset(originalImage, 1);
subplot(4, 2, 4), imshow(imageWithZeroLowest), title('将原始图像的最低有效位置为0后的图像');


% 将二进制水印嵌入到图形中
imageWithWatermark = imageWithZeroLowest;
for i = 1 : OIRow
    for j = 1 : OICol
        % 在1位平面上嵌入水印，值越大，水印越清晰,位平面的取值范围是1到8
        imageWithWatermark(i, j) = bitset(imageWithWatermark(i, j), bitDepth, binaryWatermark(i, j));
    end
end
watermarkedImageName = ['imageWithWatermarkInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(imageWithWatermark, watermarkedImageName);
subplot(4, 2, 5), imshow(watermarkedImageName), title('嵌入水印后的图片');

% imageWithWatermark(100:110, 1:2)
imageWithNoise = imnoise(imageWithWatermark, 'gaussian', 0.01);
% imageWithNoise(100:110, 1:2)
imageWithNoiseName = ['imageWithNoiseInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(imageWithNoise, imageWithNoiseName);
subplot(4, 2, 7), imshow(imageWithNoiseName), title('嵌入水印后的图片加噪声');


% 水印信息的提取
extractedWatermark = zeros(OIRow, OICol);
for i = 1 : OIRow
    for j = 1 : OICol
        extractedWatermark(i, j) = bitget(imageWithWatermark(i, j), bitDepth);
    end
end
extractedWatermarkName = ['extractedWatermarkInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(extractedWatermark, extractedWatermarkName);
subplot(4, 2, 6), imshow(extractedWatermarkName), title('提取出的二进制水印图片');


extractedWatermarkWithNoise = zeros(OIRow, OICol);
for i=1 : OIRow
     for j = 1 : OICol
         extractedWatermarkWithNoise(i, j) = bitget(imageWithNoise(i, j), bitDepth);
     end
end
extractedWatermarkWithNoiseName = ['extractedWatermarkWithNoiseInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(extractedWatermarkWithNoise, extractedWatermarkWithNoiseName);
subplot(4, 2, 8), imshow(extractedWatermarkWithNoiseName), title('加噪后提取出的二进制水印图片');
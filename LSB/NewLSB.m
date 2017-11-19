clear all;
clc;

bitDepth = input('Please input a integer between 1 and 8: ');

% [fn1, pn1] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, 'ѡ������ˮӡͼ');
% originalWatermark = imread(strcat(pn1, fn1));
originalWatermark = imread('��������.bmp');
subplot(4, 2, 1), imshow(originalWatermark), title('ԭʼˮӡͼ');

% ��ˮӡͼ������ƻ�
binaryWatermark = im2bw(originalWatermark, 0.4);
[xh_row, xh_col] = size(binaryWatermark);
subplot(4, 2, 2), imshow(binaryWatermark), title('������ˮӡ');

% [fn2, pn2] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, 'ѡ��ԭʼͼ��');
% originalImage = imread(strcat(pn2, fn2));
originalImage = imread('��ȱ�����480.bmp');
% ���ͼ�������������
[OIRow, OICol, n] = size(originalImage);
subplot(4, 2, 3), imshow(originalImage), title('ԭʼͼ��');


% ��ԭʼͼ��������Чλ��Ϊ0
imageWithZeroLowest = bitset(originalImage, 1);
subplot(4, 2, 4), imshow(imageWithZeroLowest), title('��ԭʼͼ��������Чλ��Ϊ0���ͼ��');


% ��������ˮӡǶ�뵽ͼ����
imageWithWatermark = imageWithZeroLowest;
for i = 1 : OIRow
    for j = 1 : OICol
        % ��1λƽ����Ƕ��ˮӡ��ֵԽ��ˮӡԽ����,λƽ���ȡֵ��Χ��1��8
        imageWithWatermark(i, j) = bitset(imageWithWatermark(i, j), bitDepth, binaryWatermark(i, j));
    end
end
watermarkedImageName = ['imageWithWatermarkInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(imageWithWatermark, watermarkedImageName);
subplot(4, 2, 5), imshow(watermarkedImageName), title('Ƕ��ˮӡ���ͼƬ');

% imageWithWatermark(100:110, 1:2)
imageWithNoise = imnoise(imageWithWatermark, 'gaussian', 0.01);
% imageWithNoise(100:110, 1:2)
imageWithNoiseName = ['imageWithNoiseInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(imageWithNoise, imageWithNoiseName);
subplot(4, 2, 7), imshow(imageWithNoiseName), title('Ƕ��ˮӡ���ͼƬ������');


% ˮӡ��Ϣ����ȡ
extractedWatermark = zeros(OIRow, OICol);
for i = 1 : OIRow
    for j = 1 : OICol
        extractedWatermark(i, j) = bitget(imageWithWatermark(i, j), bitDepth);
    end
end
extractedWatermarkName = ['extractedWatermarkInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(extractedWatermark, extractedWatermarkName);
subplot(4, 2, 6), imshow(extractedWatermarkName), title('��ȡ���Ķ�����ˮӡͼƬ');


extractedWatermarkWithNoise = zeros(OIRow, OICol);
for i=1 : OIRow
     for j = 1 : OICol
         extractedWatermarkWithNoise(i, j) = bitget(imageWithNoise(i, j), bitDepth);
     end
end
extractedWatermarkWithNoiseName = ['extractedWatermarkWithNoiseInDepth'  num2str(bitDepth)  '.bmp'];
imwrite(extractedWatermarkWithNoise, extractedWatermarkWithNoiseName);
subplot(4, 2, 8), imshow(extractedWatermarkWithNoiseName), title('�������ȡ���Ķ�����ˮӡͼƬ');
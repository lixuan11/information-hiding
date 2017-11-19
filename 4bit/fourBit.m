clear;
clc;

level = input('Please input a integer between 1 and 3: ');



cover = imread('��������ȫ�ʰ�480.bmp');
%��ȡ���е�һ��Ƕ������ͼ��
cover1 = cover(:, :, level);
[row_cov,col_cov]=size(cover1);
subplot(1, 5, 1), imshow(cover), title('����ͼ��');

originalWatermark = imread('�Ӳ�����.bmp');
[row_sec,col_sec] = size(originalWatermark);
subplot(1, 5, 2), imshow(originalWatermark), title('����ͼ��');

%����ͼ��level��������Ϣ�����ص�4bit��0
for i = 1 : row_sec
    for j = 1:col_sec
        cover1(i, j) = bitand(cover1(i, j), 240);
    end
end

%����ͼ���4������0��������4λ
s_secret = bitand(originalWatermark, 240);
s_secret = bitshift(s_secret, -4);


%������ͼ�����ص�����ͼ����
for i = 1 : row_sec
    for j = 1 : col_sec
        cover1(i, j) = bitor(cover1(i, j), s_secret(i, j));
    end
end

%������������ͼ���ļ�
s_cover = cover;
s_cover(:, :, level) = cover1;
imwrite(s_cover, 'imageWithWatermark.bmp');
subplot(1, 5, 3), imshow(s_cover), title('����ͼ��');

noise_cover = imnoise(s_cover, 'gaussian', 0.01);
imwrite(noise_cover, 'imageWithWatermarkAndNoise.bmp');


for i = 1 : row_sec
    for j = 1 : col_sec
        s_cover(i, j) = bitand(s_cover(i, j), 15);
        result(i, j) = s_cover(i, j);
    end
end

result = bitshift(result, 4);

imwrite(result,'extractedWatermark.bmp');
subplot(1, 5, 4), imshow(result), title('��ȡ��������ͼ��');



for i = 1 : row_sec
    for j = 1 : col_sec
        noise_cover(i, j) = bitand(noise_cover(i, j), 15);
        result2(i, j) = noise_cover(i, j);
    end
end

result2 = bitshift(result2, 4);

imwrite(result2,'extractedWatermarkwithNoise.bmp');
subplot(1, 5, 5), imshow(result2), title('������ͼ����ȡ��������ͼ��');
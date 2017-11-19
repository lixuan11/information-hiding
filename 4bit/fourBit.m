clear;
clc;

level = input('Please input a integer between 1 and 3: ');



cover = imread('阿天立体全彩版480.bmp');
%提取其中的一层嵌入秘密图像
cover1 = cover(:, :, level);
[row_cov,col_cov]=size(cover1);
subplot(1, 5, 1), imshow(cover), title('载体图像');

originalWatermark = imread('从不摸鱼.bmp');
[row_sec,col_sec] = size(originalWatermark);
subplot(1, 5, 2), imshow(originalWatermark), title('秘密图像');

%载体图像level层隐藏信息的像素低4bit清0
for i = 1 : row_sec
    for j = 1:col_sec
        cover1(i, j) = bitand(cover1(i, j), 240);
    end
end

%秘密图像低4比特清0，并右移4位
s_secret = bitand(originalWatermark, 240);
s_secret = bitshift(s_secret, -4);


%将秘密图像隐藏到载体图像中
for i = 1 : row_sec
    for j = 1 : col_sec
        cover1(i, j) = bitor(cover1(i, j), s_secret(i, j));
    end
end

%生成隐蔽载体图像文件
s_cover = cover;
s_cover(:, :, level) = cover1;
imwrite(s_cover, 'imageWithWatermark.bmp');
subplot(1, 5, 3), imshow(s_cover), title('载体图像');

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
subplot(1, 5, 4), imshow(result), title('提取出的秘密图像');



for i = 1 : row_sec
    for j = 1 : col_sec
        noise_cover(i, j) = bitand(noise_cover(i, j), 15);
        result2(i, j) = noise_cover(i, j);
    end
end

result2 = bitshift(result2, 4);

imwrite(result2,'extractedWatermarkwithNoise.bmp');
subplot(1, 5, 5), imshow(result2), title('从噪声图中提取出的秘密图像');
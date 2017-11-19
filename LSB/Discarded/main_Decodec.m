fid = 1;
block= [30 30];

%% 读取隐蔽后图像
[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '选择隐蔽载体');

y = imread(strcat(pn, fn));
sy = size(y);

%% 灰度处理
if(length(sy) >= 3)
    I = rgb2gray(y);
else
    I = y;
end
%% 调用隐藏算法
out = dh_LSB(block, I);

%% 计算误码率
len = min(length(d), length(out));
rate = sum(abs(out(1:len) - d(1:len))) / len;
y = 1 - rate;

fprintf(fid, 'LSB: len:% d\t error rate:% f\t error num:% d\n', len, rate, len * rate);
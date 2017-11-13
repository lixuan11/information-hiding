len = 100;

%% 生成要隐藏的随机数
d = randsrc(1, len, [0 1]);
block= [30 30];

%% 读取原始图像
[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '选择载体');
s= imread(strcat(pn, fn));
ss = size(s);

%% 灰度处理
if(length(ss) >= 3)
    I = rgb2gray(s);
else
    I = s;
end

%% 基本信息
si = size(I);
sN = floor(si(1) / block(1)) * floor(si(2) / block(2));
tN = length(d);

%% 如果图像尺寸不足以隐藏秘密信息，则在垂直方向上复制填充图像
if(sN < tN)
    multiple = ceil(tN / sN);
    temp = [];
    for i = 1 : multiple
        temp = [temp ; I];
    end
    
    I = temp;
end

%% 调用隐藏算法
stegoed = hide_LSB(block, d, I);
imwrite(stegoed, 'hide.bmp', 'bmp');

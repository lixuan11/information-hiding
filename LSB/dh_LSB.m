function output = dh_LSB(block, I)
% block: 隐藏的最小分块大小
% I: 携密载体

si = size(I);

%% 将原始图像切割为M*N的小块
N = floor(si(2) / block(2));
M = floor(si(1) / block(1));
output = [];

%% 计算比特1判决阈值
% 即每小块半数以上元素隐藏的是比特1时，判决该小块嵌入的是1
thr = ceil((block(1) * block(2) + 1) / 2);
idx = 0;

%% 循环嵌入隐蔽信息
for i = 0 : M-1
    
    %% 计算每个小块垂直方向上的起止位置
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    
    for j = 0 : N-1
        
        %% 计算每个小块隐藏的秘密信息序号
        idx = i * N + j + 1;
        
        %% 计算每个小块水平方向上的起止位置
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        
        %% 提取小块的最低位平面，统计1比特个数，判决输出秘密信息
        temp = sum(sum(bitget(I(rst:red, cst:ced), 1)));
        if(temp >= thr)
            output(idx) = 1;
        else
            output(idx) = 0;
        end
    end
end

end


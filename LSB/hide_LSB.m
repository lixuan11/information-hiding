function output = hide_LSB(block, data, I)
% block: 隐藏的最小分块大小
% data: 秘密信息
% I: 原始载体

si = size(I);
lend = length(data);

%% 将原始图像切割为M*N的小块
N = floor(si(2) / block(2));
M = min(floor(si(1) / block(1)), ceil(lend / N));

output = I;

%% 循环嵌入隐蔽信息
for i = 0 : M-1
    
    %% 计算每个小块垂直方向上的起止位置
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        
        %% 计算每个小块隐藏的秘密信息序号
        idx = i * N + j + 1;
        if idx > lend
            break;
        end
        
        %% 取每个小块的隐藏信息
        bit = data(idx);
        
        %% 计算每个小块水平方向上的起止位置
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        
        %% 将每个小块最低位平面替换为秘密信息
        output(rst:red, cst:ced) = bitset(output(rst:red, cst:ced), 1, bit);
    end
end

end


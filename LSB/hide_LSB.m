function output = hide_LSB(block, data, I)
% block: ���ص���С�ֿ��С
% data: ������Ϣ
% I: ԭʼ����

si = size(I);
lend = length(data);

%% ��ԭʼͼ���и�ΪM*N��С��
N = floor(si(2) / block(2));
M = min(floor(si(1) / block(1)), ceil(lend / N));

output = I;

%% ѭ��Ƕ��������Ϣ
for i = 0 : M-1
    
    %% ����ÿ��С�鴹ֱ�����ϵ���ֹλ��
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        
        %% ����ÿ��С�����ص�������Ϣ���
        idx = i * N + j + 1;
        if idx > lend
            break;
        end
        
        %% ȡÿ��С���������Ϣ
        bit = data(idx);
        
        %% ����ÿ��С��ˮƽ�����ϵ���ֹλ��
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        
        %% ��ÿ��С�����λƽ���滻Ϊ������Ϣ
        output(rst:red, cst:ced) = bitset(output(rst:red, cst:ced), 1, bit);
    end
end

end


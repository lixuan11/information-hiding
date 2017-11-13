function output = dh_LSB(block, I)
% block: ���ص���С�ֿ��С
% I: Я������

si = size(I);

%% ��ԭʼͼ���и�ΪM*N��С��
N = floor(si(2) / block(2));
M = floor(si(1) / block(1));
output = [];

%% �������1�о���ֵ
% ��ÿС���������Ԫ�����ص��Ǳ���1ʱ���о���С��Ƕ�����1
thr = ceil((block(1) * block(2) + 1) / 2);
idx = 0;

%% ѭ��Ƕ��������Ϣ
for i = 0 : M-1
    
    %% ����ÿ��С�鴹ֱ�����ϵ���ֹλ��
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    
    for j = 0 : N-1
        
        %% ����ÿ��С�����ص�������Ϣ���
        idx = i * N + j + 1;
        
        %% ����ÿ��С��ˮƽ�����ϵ���ֹλ��
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        
        %% ��ȡС������λƽ�棬ͳ��1���ظ������о����������Ϣ
        temp = sum(sum(bitget(I(rst:red, cst:ced), 1)));
        if(temp >= thr)
            output(idx) = 1;
        else
            output(idx) = 0;
        end
    end
end

end


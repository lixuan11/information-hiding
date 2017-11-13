len = 100;

%% ����Ҫ���ص������
d = randsrc(1, len, [0 1]);
block= [30 30];

%% ��ȡԭʼͼ��
[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, 'ѡ������');
s= imread(strcat(pn, fn));
ss = size(s);

%% �Ҷȴ���
if(length(ss) >= 3)
    I = rgb2gray(s);
else
    I = s;
end

%% ������Ϣ
si = size(I);
sN = floor(si(1) / block(1)) * floor(si(2) / block(2));
tN = length(d);

%% ���ͼ��ߴ粻��������������Ϣ�����ڴ�ֱ�����ϸ������ͼ��
if(sN < tN)
    multiple = ceil(tN / sN);
    temp = [];
    for i = 1 : multiple
        temp = [temp ; I];
    end
    
    I = temp;
end

%% ���������㷨
stegoed = hide_LSB(block, d, I);
imwrite(stegoed, 'hide.bmp', 'bmp');

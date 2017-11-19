fid = 1;
block= [30 30];

%% ��ȡ���κ�ͼ��
[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, 'ѡ����������');

y = imread(strcat(pn, fn));
sy = size(y);

%% �Ҷȴ���
if(length(sy) >= 3)
    I = rgb2gray(y);
else
    I = y;
end
%% ���������㷨
out = dh_LSB(block, I);

%% ����������
len = min(length(d), length(out));
rate = sum(abs(out(1:len) - d(1:len))) / len;
y = 1 - rate;

fprintf(fid, 'LSB: len:% d\t error rate:% f\t error num:% d\n', len, rate, len * rate);
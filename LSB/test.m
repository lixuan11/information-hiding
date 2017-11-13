fid = 1;
len = 10;

d = randsrc(1, len, [0 1]);
block= [3 3];

[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '选择载体');

s= imread(strcat(pn, fn));

ss = size(s);

if(length(ss) >= 3)
    I = rgb2gray(s);
else
    I = s;
end

si = size(I);
sN = floor(si(1) / block(1)) * floor(si(2) / block(2));
tN = length(d);

if(sN < tN)
    multiple = ceil(tN / sN);
    temp = [];
    for i = 1 : multiple
        temp = [temp ; I];
    end
    
    I = temp;
end

stegoed = hide_LSB(block, d, I);
imwrite(stegoed, 'hide.bmp', 'bmp');

[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '选择隐蔽载体');

y = imread(strcat(pn, fn));

sy = size(y);
if(length(sy) >= 3)
    I = rgb2gray(y);
else
    I = y;
end

out = dh_LSB(block, I);

len = min(length(d), length(out));
rate = sum(abs(out(1:len) - d(1:len))) / len;

y = 1 - rate;

fprintf(fid, 'LSB: len:% d\t error rate:% f\t error num:% d\n', len, rate, len * rate);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
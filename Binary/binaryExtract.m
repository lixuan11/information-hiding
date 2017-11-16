clc;
clear all;

[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '—°‘Ò“˛±Œ‘ÿÃÂ');
wi = imread(strcat(pn, fn));

[row, col] = size(wi);
watermarklen = 24;

l1 = floor(row / watermarklen);
l2 = floor(col / watermarklen);

pixelblack(1, watermarklen) = 0;
pixelwhite(1, watermarklen) = 0;

n = 1;
while n <= watermarklen
    for i = l1*(n-1)+1 : l1*n
        for j = l2*(n-1)+1 : l2*n
            if(wi(i, j) == 0)
                pixelblack(1, n) = pixelblack(1, n) + 1;
            else
                pixelwhite(1, n) = pixelwhite(1, n) + 1;
            end
        end
    end
    n = n + 1;
end

n = 1;
while n <= watermarklen
    if(pixelwhite(1, n) > pixelblack(1, n))
        message(n, 1) = 1;
    else
        message(n, 1) = 0;
    end
    n = n + 1;
end


out = bit2str(message);
fid = fopen('message.txt', 'wt');
fwrite(fid, out);
fcolse(fid);


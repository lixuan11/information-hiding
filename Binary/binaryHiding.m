clc;
clear all;

msgfid = fopen('hidden.txt', 'r');
[msg, count] = fread(msgfid);
fclose(msgfid);

msg = str2bin(msg);
msg = msg';
count = count * 8;

[fn, pn] = uigetfile({'* .bmp', 'bmp file(* .bmp)';}, '—°‘Ò‘ÿÃÂ');
io = imread(strcat(pn, fn));

watermarklen = count;
[row, col] = size(io);

l1 = floor(row / watermarklen);
l2 = floor(col / watermarklen);
pixelcount = l1 * l2;
percent = ceil(pixelcount / 2);

iw = io;

ioblack(1, watermarklen) = 0;
iowhite(1, watermarklen) = 0;

n = 1;
while n <= watermarklen
    for i = l1*(n-1)+1 : l1*n
        for j = l2*(n-1)+1 : l2*n
            if io(i, j) == 0
                ioblack(1, n) = ioblack(1, n) + 1;
            else
                iowhite(1, n) = iowhite(1, n) + 1;
            end
        end
    end
    n = n + 1;
end

n = 1;
while n <= watermarklen
    if msg(n, 1) == 1
        if(ioblack(1, n) >= percent)
            modcount(1, n) = ioblack(1, n) - percent + 1;
            k = 1;
            for i = l1*(n-1)+1 : l1*n
                for j = l2*(n-1)+1 : l2*n
                    if(iw(i, j) == 0 && k <= modcount(1, n))
                        iw(i, j) = 1;
                        k = k + 1;
                    end
                end
            end
        end
    else
        if(iowhite(1, n) >= percent)
            modcount(1, n) = iowhite(1, n) - percent + 1;
            k = 1;
            for i = l1*(n-1)+1 : l1*n
                for j = l2*(n-1)+1 : l2*n
                    if(iw(i, j) == 1 && k <= modcount(1, n))
                        iw(i, j) = 0;
                        k = k + 1;
                    end
                end
            end
        end
    end
    n = n + 1;
end

n = 1;
iwblack(1, watermarklen) = 0;
iwwhite(1, watermarklen) = 0;

while(n <= watermarklen)
    for i = l1*(n-1)+1 : l1*n
        for j = l2*(n-1)+1 : l2*n
            if(iw(i, j) == 0)
                iwblack(1, n) = iwblack(1, n) + 1;
            else
                iwwhite(1, n) = iwwhite(1, n) + 1;
            end
        end
    end
    n = n + 1;
end

immwrite(iw, 'marked.bmp');
figure;
imshow('marked.bmp');

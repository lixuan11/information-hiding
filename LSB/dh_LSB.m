function output = dh_LSB(block, I)

si = size(I);

N = floor(si(2) / block(2));
M = floor(si(1) / block(1));
output = [];

thr = ceil((block(1) * block(2) + 1) / 2);
idx = 0;

for i = 0 : M-1
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        idx = i * N + j + 1;
        
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        
        temp = sum(sum(bitget(I(rst:red, cst:ced), 1)));
        if(temp >= thr)
            output(idx) = 1;
        else
            output(idx) = 0;
        end
    end
end

end


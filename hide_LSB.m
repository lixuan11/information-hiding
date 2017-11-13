function output = hide_LSB(block, data, I)
si = size(I);
lend = length(data);

N = floor(si(2) / block(2));
M = min(floor(si(1) / block(1)), ceil(lend / N));

output = I;

for i = 0 : M-1
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        idx = i * N + j + 1;
        if idx > lend
            break;
        end
        bit = data(idx);
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        
        output(rst:red, cst:ced) = bitset(output(rst:red, cst:ced), 1, bit);
    end
end

end


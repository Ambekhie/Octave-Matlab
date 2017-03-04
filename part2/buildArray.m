function values = buildArray(Data, x)
    values = zeros(x, x + 1);
    values(:, 1 : 2) = Data(1 : x, 1 : 2);
    for i = 1 : (x - 1) 
        for j = 1 : (x - i) 
            values(j, i + 2) = (values(j + 1, i + 1) - values(j, i + 1))/(values(i + j, 1) - values(j, 1));
        end
    end
end
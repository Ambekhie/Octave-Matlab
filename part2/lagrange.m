function fx = lagrange(Data, n)
    fx = [];
    for i = 1 : n
        l = [];
        den = 1;
        for j = 1 : n
            if i ~= j
                den = den * (Data(i, 1) - Data(j, 1));
                size(l);
                if (size(l) == 0)
                    l = ['(x - ' (num2str(Data(j, 1))) ')'];
                else
                    l = [l ' * (x - ' (num2str(Data(j, 1))) ')'];
                end
            end
        end
        if (size(fx) == 0)
            fx = [num2str(Data(i, 2)/den) ' * ' l]; 
        else
            fx = [fx ' + ' num2str(Data(i, 2)/den) ' * ' l]; 
        end
    end
    fx = sym(fx);
end
function fx = Interpolation(x, values)
    fx = num2str(values(1,2));
    for i = 1 : (x - 1)
        multiplication = num2str(values(1, i + 2));
        for j = 1 : i
            multiplication = [multiplication ' * (x - ' (num2str(values(j, 1))) ')'];
        end
        fx = [fx ' + ' multiplication];
    end
    fx = sym(fx);
end
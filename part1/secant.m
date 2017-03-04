function [ y ] = secant( x0, x1, es, iMax, equation )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
y = [];
for i = 0:iMax
    fx1 = f(x1,equation);
    fx0 = f(x0,equation);
    if fx0 == fx1
            disp('division by zero');
            return 
    end
    xr = x1 - ((fx1 * (x0-x1))/(fx0-fx1)) ;
    ea = abs(xr-x1);
    y = [y;[xr, x1, x0, ea]] ;
    x0 = x1;
    x1 = xr;
    if ea < es
        break;
    end
end    
end


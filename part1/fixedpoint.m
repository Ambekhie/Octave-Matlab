function [ y ] = fixedpoint( xr, es, iMax, equation )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
y = [];
syms x ;
df = diff(equation, x);
if f(xr,df) > 1 
    disp('the function diverges');
    return ;
end
for i = 0:iMax
    x_old = xr ;
    xr = f(xr,equation);
    ea = abs(xr-x_old);
    y = [y;[xr, ea]] ;
    if ea < es
        break;
    end
end    
end


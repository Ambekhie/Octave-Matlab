function [ y ] = newtonraphson( xr, es, iMax, equation )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
y = [];
syms x ;
df = diff(equation,x);
for i = 0:iMax
    x_old = xr ;
    xprime = f(x_old,df) ;
    if xprime == 0
        disp('Division by zero');
        break ;
    end
    xr = x_old - f(x_old,equation)/xprime;
    ea = abs(xr-x_old);
    y = [y;[xr, ea]] ;
    if ea < es
        break;
    end
end    
end


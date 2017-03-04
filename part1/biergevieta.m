function [ y ] = biergevieta( xr, es, iMax, equation )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
y = [];
syms x;
p = inline(equation);
table = transpose(sym2poly(p(x)));
n = size(table,1);
table = [table,zeros(n,2)];
for k = 0:iMax 
	table(1,2) = table(1,1);
    table(1,3) = table(1,1);
	for j = 2:3
  		for i = 2:n
      	table(i,j) = xr * table(i-1,j) + table(i,j-1);
        end
    end
    fx = double(table(n,2));
    dfx = double(table(n-1,3));
    if dfx == 0
        disp('division by zero!');
    return;
    end
    x_old = xr ;
    xr = x_old - fx/dfx ;
    ea = double(abs(xr-x_old));
    y = [y;[xr,ea]];
    if ea < es
        break ;
    end
end
end



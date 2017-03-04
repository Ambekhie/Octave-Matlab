function [ y ] = bisection_modify(equation)
%modification
y = [];
syms x ;
df = diff(equation,x);
dfroots = solve(df,x);
for num = dfroots
	if f(num,equation) == 0
		y = [y; num];
	end	
end
end
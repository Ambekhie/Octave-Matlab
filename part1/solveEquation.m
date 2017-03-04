function [ y ] = solveEquation(MAXR ,MINR, es, iMax, equation )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
y = [];
fx = [];
ranges = [];
interval = linspace(MINR,MAXR+es,4*(MAXR+es-MINR));
for index = interval
	fx = [fx;f(index,equation)];
end
for i = 2:length(fx)
	if fx(i) * fx(i-1) <= 0
		ranges = [ranges ; [interval(i-1), interval(i)]];			
	end
end
for i = 1:size(ranges,1)
	result = bisection(ranges(i,1),ranges(i,2),es,iMax,equation);
	if size(result,1) ~= 0 	
		y = [y;result(size(result,1),3)];
	end
end


end

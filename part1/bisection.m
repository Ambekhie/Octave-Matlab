function [ y ] = bisection( upper, lower, es, iMax, equation )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
y = [] ;
fl = f(lower,equation);
fu = f(upper,equation);
ea = 0.0;
xro=0.0;
if fu * fl > 0    
    return;
elseif fu * fl < 0
    xu = upper;
    xl = lower;
    for i = 0:iMax
        xr = (xu+xl)/2;
        if i ~= 0
        ea = abs(xr - xro); 
        end
        fxr = f(xr,equation);
        test = fxr * fl;
        y = [y;[xu,xl,xr,ea]] ;
        if test < 0
            xu = xr;
            fu = fxr;
        elseif test > 0 
            xl = xr;
            fl = fxr;
        else
            break;
        end
        if ea < es && i~= 0
            break;
        end
         xro = xr;
    end
else
	if fu == 0
		xr = upper;
	else
		xr = lower;	
    end
    y = [y;[upper,lower,xr,ea]] ;
end
end

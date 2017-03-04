function [ y ] = falseposition( upper, lower, es, iMax, equation )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
y = [] ;
fl = f(lower,equation);
fu = f(upper,equation);
if fu * fl > 0    
    return;
elseif fu * fl < 0
	lcounter = 0;
	ucounter = 0;
    xu = upper;
    xl = lower; 
    xro=0.0;
    ea = 0.0 ;
    for i = 0:iMax
        if fu == fl
            return 
        end
        xr =((fu * xl) - (fl * xu))/ (fu - fl);
        if i ~= 0
        ea = abs(xr - xro); 
        end
        fxr = f(xr,equation);
        test = fxr * fl;
        y = [y;[xu, xl, xr, ea]] ;
        if test < 0
            xu = xr;
            fu = fxr;
            lcounter = lcounter + 1;
        elseif test > 0 
            xl = xr;
            fl = fxr;
            ucounter = ucounter +1;
        else
            break;
        end
        if ea < es && i~= 0
            break;
        end
         if abs(ucounter-lcounter) > 2
         	ucounter = 0;
         	lcounter = 0;
         	[xu , xl , fu , fl]  = modify_falseposition(xu,xl,fu,fl,equation);	
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

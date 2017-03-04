function [ xu , xl, fu, fl ] = modify_falseposition( xu, xl, fu, fl, equation )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    	xr =(xu+xl)/2;
        fxr = f(xr,equation);
        test = fxr * fl;
        if test < 0
            xu = xr;
            fu = fxr;
        elseif test > 0 
            xl = xr;
            fl = fxr;
        end
end

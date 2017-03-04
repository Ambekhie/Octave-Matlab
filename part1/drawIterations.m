function drawIterations (handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
syms x;
[x_i, x_j] = getInterval(); 
x_axis = [ x_i :1: x_j ];
equation = get(handles.equationField,'string');
data = get(handles.uitable,'Data');
sz = size(data,1);
if sz == 0
	return;
end
axes(handles.axes1);   
if get(handles.fixedPoint,'Value') == 1 || get(handles.biergeVieta,'Value') == 1
    if getIndex() == 0
        hold on;
        if get(handles.biergeVieta,'Value') == 1 
        	plot(data(size(data,1),1),f(data(size(data,1),1),equation),'r.','MarkerSize',20);
        else
        	plot(data(size(data,1),1),data(size(data,1),1),'r.','MarkerSize',20);
        end
        return;
    end
    if get(handles.biergeVieta,'Value') == 1 && getIndex() == 1
         cla(handles.axes1);
         hold on;
         ezplot(equation, x_axis);
    end
    hold on;
    y = get(gca,'Ylim');
    num = data(getIndex(),1);
    line([num num],y);
elseif get(handles.bisection,'Value') == 1 ||  get(handles.falsePosition,'Value') == 1
	if getIndex() == 0
    	hold on;
        plot(data(size(data,1),3),f(data(size(data,1),3),equation),'r.','MarkerSize',20);
        return;
    end
    cla(handles.axes1);
    hold on;
    ezplot(equation,x_axis);
    hold on;
    y = get(gca,'Ylim');
    num = data(getIndex(),2);
    line([num num], y, 'color', 'm');
    hold on;
    num = data(getIndex(),1);
    line([num num], y, 'color', 'm');
    hold on;
    num = data(getIndex(),3);
    line([num num], y, 'color', 'r');
elseif get(handles.newtonRaphson,'Value') == 1 || get(handles.secant,'Value') == 1
    if getIndex() == 1
        cla(handles.axes1);
        hold on;
        ezplot(equation,x_axis);
  	end  
    if getIndex() == 0
        hold on;
        plot(data(size(data,1),1),f(data(size(data,1),1),equation),'r.','MarkerSize',20);
        return;
    end
    hold on;
		% y = mx-m(x0)+(y0) 
   if get(handles.newtonRaphson,'Value') == 1
    x_0 = data(getIndex(),1);
    y_0 = f(data(getIndex(),1),equation);
    m = f(x_0,diff(equation,x));
   else
    x_0 = data(getIndex(),2);
    y_0 = f(data(getIndex(),2),equation);
    x_1 = data(getIndex(),3);
    y_1 = f(data(getIndex(),3),equation);
    m = (y_1 - y_0)/(x_1 - x_0);
   end
    expression = strcat(num2str(m), '*x-');
    expression = strcat(expression , num2str(m));
    expression = strcat(expression , '*');
    expression = strcat(expression , num2str(x_0));
    expression = strcat(expression , '+');
    expression = strcat(expression , num2str(y_0));
    ezplot(expression,x_axis);
else 
		for i = 1:sz 
    	  plot(data(i,1),f(data(i,1),equation),'r.','MarkerSize',20);
    end
end    
setIndex(mod((getIndex() + 1), sz+1));
end

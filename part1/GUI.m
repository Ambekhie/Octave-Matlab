function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 09-May-2016 20:43:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in solve.
function solve_Callback(hObject, eventdata, handles)
% hObject    handle to solve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
syms x;
iMax = str2double(get(handles.maxIteration, 'String'));
es = str2double(get(handles.errorBound, 'String'));
timer  = 0.0 ;
x_i = str2num(get(handles.interval_start,'String')) ; 
x_j = str2num(get(handles.interval_end,'String')) ;
setInterval(x_i, x_j);
x_axis = [ x_i :1: x_j ];
equation = get(handles.equationField, 'String');
if isempty(equation)
    set(handles.feedBack, 'String', 'No Equation Available');
    set(handles.uitable,'Data' , []);
    cla(handles.axes1);
    return;
else
    set(handles.feedBack, 'String', '');
end
setIndex(1);
axes(handles.axes1); 
cla(handles.axes1); 
grid on;
hold on;
y = [];
r = [];
%p = [];
if get(handles.bisection,'Value') == 1 ||  get(handles.falsePosition,'Value') == 1
    prompt = {'The Interval starts at :','The Interval ends at : '};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'-10','10'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    switch	get(get(handles.buttonGroup,'SelectedObject'),'Tag')
          case 'bisection'
            tic;
          	y = bisection(str2num(answer{2}),  str2num(answer{1}), es, iMax, equation );
          	timer = toc;
          case 'falsePosition'
           tic;
           y = falseposition( str2num(answer{2}), str2num(answer{1}), es, iMax, equation );
           timer = toc;
    end
    %p = bisection_modify(equation);
    set(handles.uitable, 'columnname', {'Upper', 'Lower', 'Estimate', 'Error'});
    sz = size(y,1);
    if sz ~= 0
      r = y(sz,3);
    end    
    eq = inline(equation);
    ezplot(eq,x_axis);
elseif get(handles.fixedPoint,'Value') == 1 || get(handles.newtonRaphson,'Value') == 1 ||  get(handles.biergeVieta,'Value') == 1
    prompt = {'The Initial Point :'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'0'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    switch	get(get(handles.buttonGroup,'SelectedObject'),'Tag')
          case 'fixedPoint'
          	  tic;	
              y = fixedpoint( str2num(answer{1}), es, iMax, equation ); 
              eq = inline(equation);
              timer = toc;
          case 'newtonRaphson'
          	  tic;	
              y = newtonraphson( str2num(answer{1}), es, iMax, equation );
              eq = diff(equation,x);
              timer = toc;
          case 'biergeVieta'
          	  tic;
              y = biergevieta( str2num(answer{1}), es, iMax, equation );
              eq = diff(equation,x);
              timer = toc;
    end
    set(handles.uitable, 'columnname', {'Estimate', 'Error'});
    sz = size(y,1);
    if sz ~= 0
       r = y(sz,2);
    end
   ezplot(eq,x_axis); 
   if get(handles.fixedPoint,'Value') == 1
       hold on;
       ezplot('x',x_axis); 
   end
elseif get(handles.secant,'Value') == 1
    prompt = {'The First Initial Point :', 'The Second Initial Point :'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'0','1'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    tic;
    y = secant( str2num(answer{1}), str2num(answer{2}), es, iMax, equation );
    timer = toc;
    set(handles.uitable, 'columnname', {'Estimate', 'First Initial Point', 'Second Initial Point', 'Error'});
    sz = size(y,1);
    if sz ~= 0
        r = y(sz,3);
   end
   eq = diff(equation,x);
   ezplot(eq,x_axis); 
else
	prompt = {'The Interval starts at :','The Interval ends at : '};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'-10','10'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    tic;
    y = solveEquation(str2num(answer{2}), str2num(answer{1}), es, iMax, equation);
    timer = toc;
    r = y;
    set(handles.uitable, 'columnname', {'Root'});
    eq = inline(equation);
    ezplot(eq,x_axis);
end
	%result = mat2str(r);
    if size(y,1) == 0   
        set(handles.feedBack, 'String', 'No Solution');
    else
        set(handles.feedBack, 'String', 'SOLVED');
    end
    set(handles.uitable, 'Data', y);
    set(handles.timerText, 'String', timer);
   % disp(mat2str(p));
   %set(handles.uitable2, 'Data', p);
 catch 
    set(handles.feedBack, 'String', 'TRY AGAIN');
    set(handles.uitable,'Data' , []);
    cla(handles.axes1);
end
    function maxIteration_Callback(hObject, eventdata, handles)
    % hObject    handle to maxIteration (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of maxIteration as text
    %        str2double(get(hObject,'String')) returns contents of maxIteration as a double


% --- Executes during object creation, after setting all properties.
function maxIteration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function errorBound_Callback(hObject, eventdata, handles)
% hObject    handle to errorBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of errorBound as text
%        str2double(get(hObject,'String')) returns contents of errorBound as a double


% --- Executes during object creation, after setting all properties.
function errorBound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to errorBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function equationField_Callback(hObject, eventdata, handles)
% hObject    handle to equationField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of equationField as text
%        str2double(get(hObject,'String')) returns contents of equationField as a double


% --- Executes during object creation, after setting all properties.
function equationField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equationField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in nextIteration.
function nextIteration_Callback(hObject, eventdata, handles)
% hObject    handle to nextIteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

drawIterations(handles);


% --- Executes on button press in loadEquation.
function loadEquation_Callback(hObject, eventdata, handles)
% hObject    handle to loadEquation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	try
    	[FileName,PathName]= uigetfile('*.txt','Select te File that contains the Equation');
    	content = fileread((strcat(PathName,FileName)));
    	set(handles.equationField, 'String', content);
        set(handles.feedBack, 'String', '');
    catch
    	set(handles.feedBack, 'String', 'No Equation Available');
    end



function timerText_Callback(hObject, eventdata, handles)
% hObject    handle to timerText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timerText as text
%        str2double(get(hObject,'String')) returns contents of timerText as a double


% --- Executes during object creation, after setting all properties.
function timerText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timerText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interval_start_Callback(hObject, eventdata, handles)
% hObject    handle to interval_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interval_start as text
%        str2double(get(hObject,'String')) returns contents of interval_start as a double


% --- Executes during object creation, after setting all properties.
function interval_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interval_end_Callback(hObject, eventdata, handles)
% hObject    handle to interval_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interval_end as text
%        str2double(get(hObject,'String')) returns contents of interval_end as a double


% --- Executes during object creation, after setting all properties.
function interval_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

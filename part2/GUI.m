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

% Last Modified by GUIDE v2.5 05-May-2016 17:50:05

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
% uiwait(handles.GUI);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function numOfQueries_Callback(hObject, eventdata, handles)
% hObject    handle to numOfPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numOfPoints as text
%        str2double(get(hObject,'String')) returns contents of numOfPoints as a double
size = floor(str2double(get(hObject, 'string')));
set(handles.queries,'Data',zeros(size,2));

% --- Executes when entered data in editable cell(s) in matrix.
function matrix_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to matrix (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = cputime;
points = get(handles.queries, 'Data');
pointSize = size(points);
data = get(handles.matrix, 'Data');
sz = size(data);
if (get(handles.newton, 'Value') == 1) 
    values = buildArray(data, sz(1,1));
    y = Interpolation(sz(1,1), values);
    y = expand(y);
    set(handles.fx, 'string', char(y));
    for i = 1 : pointSize
        x = points(i, 1);
        points(i, 2) = subs(y);
    end
end
if (get(handles.lagrange, 'Value') == 1)
    y = lagrange(data, sz(1,1));
    y = expand(y);
    set(handles.fx, 'string', char(y));
    for i = 1 : pointSize
        x = points(i, 1);
        points(i, 2) = subs(y);
    end
end
minimum = min(data);
maximum = max(data);
arr = minimum(1,1):(maximum(1,1)-minimum(1,1))/100:maximum(1,1);
axes(handles.axes)
syms x;
h = ezplot(y, arr);
title('');
ylabel('f(x)')
grid on
grid minor
set(h, 'Color', 'c');
set(h, 'LineWidth', 2.5);
set(handles.queries,'Data',points);
set(handles.execution,'string', [(num2str(t)) ' ms']);



% --- Executes during object creation, after setting all properties.
function matrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Data',zeros(2,2));
sz = size(get(hObject,'Data'));
sz(1,1) = 1;
set(hObject,'ColumnEditable',true(sz));

% --- Executes during object creation, after setting all properties.
function numOfQueries_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numOfQueries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in file.
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.xlsx','Select the Excel file');
read = xlsread([PathName FileName]);
set(handles.matrix,'Data',read);
sz = size(get(handles.matrix,'Data'));
set(handles.numOfPoints, 'string', sz(1,1));
sz(1,1) = 1;
set(handles.matrix,'ColumnEditable',true(sz));



function numOfPoints_Callback(hObject, eventdata, handles)
% hObject    handle to numOfPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numOfPoints as text
%        str2double(get(hObject,'String')) returns contents of numOfPoints as a double
size = floor(str2double(get(hObject, 'string')));
set(handles.matrix,'Data',zeros(size,2));

% --- Executes during object creation, after setting all properties.
function numOfPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numOfPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function queries_CreateFcn(hObject, eventdata, handles)
% hObject    handle to queries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Data',zeros(1,2));


% --- Executes on button press in queryFile.
function queryFile_Callback(hObject, eventdata, handles)
% hObject    handle to queryFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.xlsx','Select the Excel file');
read = xlsread([PathName FileName]);
set(handles.queries,'Data',read);
sz = size(get(handles.queries,'Data'));
set(handles.numOfQueries, 'string', sz(1,1));




function execution_Callback(hObject, eventdata, handles)
% hObject    handle to execution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of execution as text
%        str2double(get(hObject,'String')) returns contents of execution as a double


% --- Executes during object creation, after setting all properties.
function execution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to execution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes

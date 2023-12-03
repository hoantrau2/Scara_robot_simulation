function varargout = scara_robot(varargin)
% SCARA_ROBOT MATLAB code for scara_robot.fig
%      SCARA_ROBOT, by itself, creates a new SCARA_ROBOT or raises the existing
%      singleton*.
%
%      H = SCARA_ROBOT returns the handle to a new SCARA_ROBOT or the handle to
%      the existing singleton*.
%
%      SCARA_ROBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCARA_ROBOT.M with the given input arguments.
%
%      SCARA_ROBOT('Property','Value',...) creates a new SCARA_ROBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before scara_robot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to scara_robot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help scara_robot

% Last Modified by GUIDE v2.5 03-Dec-2023 16:42:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @scara_robot_OpeningFcn, ...
                   'gui_OutputFcn',  @scara_robot_OutputFcn, ...
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

% --- Executes just before scara_robot is made visible.
function scara_robot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to scara_robot (see VARARGIN)

% Choose default command line output for scara_robot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global a alpha d theta opacity T;
a1 = str2double(handles.a1_val.String);
a2 = str2double(handles.a2_val.String);
d1 = str2double(handles.d1_val.String);
d2 = str2double(handles.d2_val.String);
%Creat DH Matrix
a     = [a1    ;   a2   ;  0  ;    0   ];
alpha = [0     ;   0    ;  pi  ;   0   ];
d     = [d1    ;   d2   ;  0  ;  0   ];
theta = [0     ;    0   ;  0  ;    0   ];
opacity = str2double(handles.Opac_val.String);
Forward_button_Callback(hObject, eventdata, handles);



% --- Outputs from this function are returned to the command line.
function varargout = scara_robot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sliderTheta1_Callback(hObject, eventdata, handles)
handles.Theta1_val.String = get(handles.sliderTheta1,'Value'); 

% --- Executes during object creation, after setting all properties.
function sliderTheta1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sliderTheta2_Callback(hObject, eventdata, handles)
handles.Theta2_val.String = get(handles.sliderTheta2,'Value'); 
function sliderTheta2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider_d3_Callback(hObject, eventdata, handles)
handles.d3_val.String = get(handles.slider_d3,'Value');
function slider_d3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function sliderTheta4_Callback(hObject, eventdata, handles)
handles.Theta4_val.String = get(handles.sliderTheta4,'Value'); 
function sliderTheta4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Opac_val_Callback(hObject, eventdata, handles)
global opacity;
opacity = str2double(handles.Opac_val.String);
function Opac_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Pos_X_Callback(hObject, eventdata, handles)
function Pos_X_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pos_Y_Callback(hObject, eventdata, handles)
function Pos_Y_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pos_Z_Callback(hObject, eventdata, handles)
function Pos_Z_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Yaw_value_Callback(hObject, eventdata, handles)
function Yaw_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Show_coordination.
function Show_coordination_Callback(hObject, eventdata, handles)
global a alpha d theta opacity T
T = Transformation_matrix(a,alpha,d,theta,handles,opacity);
Draw_robot(a,alpha,d,theta,handles,opacity,T);

% --- Executes on button press in ChB_WoSp.
function ChB_WoSp_Callback(hObject, eventdata, handles)
% hObject    handle to ChB_WoSp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of ChB_WoSp

function a1_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function a2_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function d1_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function d2_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Theta1_val_Callback(hObject, eventdata, handles)
handles.sliderTheta1.Value = str2double(handles.Theta1_val.String);

function Theta1_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Theta2_val_Callback(hObject, eventdata, handles)
handles.sliderTheta2.Value = str2double(handles.Theta2_val.String);

function Theta2_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function d3_val_Callback(hObject, eventdata, handles)
handles.slider_d3.Value = str2double(handles.d3_val.String);


function d3_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Theta4_val_Callback(hObject, eventdata, handles)
handles.sliderTheta4.Value = str2double(handles.Theta4_val.String);

function Theta4_val_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Forward_button.
function Forward_button_Callback(hObject, eventdata, handles)
global a alpha d theta opacity;
[theta, d] = Forward_Kinematics(a,alpha,d,theta,handles,opacity);


function velocity_rate_box_Callback(hObject, eventdata, handles)
function velocity_rate_box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Inverse_button.
function Inverse_button_Callback(hObject, eventdata, handles)
global a alpha d theta opacity T;
yaw = str2double(handles.Yaw_value.String)*pi/180;
x = str2double(handles.Pos_X.String);
y = str2double(handles.Pos_Y.String);
z = str2double(handles.Pos_Z.String);
T = Inverse_Kinematics(a,alpha,d,theta,yaw,x,y,z,handles,opacity);

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

% Last Modified by GUIDE v2.5 29-Oct-2023 00:45:25

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

global a alpha d theta;
a1 = str2double(handles.a1_val.String);
a2 = str2double(handles.a2_val.String);
d1 = str2double(handles.d1_val.String);
d2 = str2double(handles.d2_val.String);
%Creat DH Matrix
a     = [a1    ;   a2   ;  0  ;    0   ];
alpha = [0     ;   0    ;  0  ;   0   ];
d     = [d1    ;   d2   ;  0  ;  -80   ];
theta = [0     ;    0   ;  0  ;    0   ];
% UIWAIT makes scara_robot wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% Setup the robot arm
% 
% % % % % % % % % % % 
% global scara
% a     = [0 4 2.5 0 0];
% alpha = [0 0 0 0 180];
% d     = [3.5 0 0 1 0];
% theta = [0 90 90 0 -90];
% type = ['b', 'r', 'r', 'p', 'r']; % base, xoay, xoay, truot, xoay
% base = [0; 0; 0];
% scara = arm (a, alpha, d, theta, type, base);
% scara = scara.set_joint_variable(2, deg2rad(get(handles.sliderTheta1, 'Value')));
% scara = scara.set_joint_variable(3, deg2rad(get(handles.sliderTheta2, 'Value')));
% scara = scara.set_joint_variable(4, get(handles.slider3, 'Value'));
% scara = scara.set_joint_variable(5, deg2rad(get(handles.sliderTheta4, 'Value')));
% scara = scara.update();
% % set_ee_params(scara, handles);
% scara.plot(handles.axes1);
% % % % % % % % % 
% 
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
% hObject    handle to sliderTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta;
handles.Theta1_val.String = get(handles.sliderTheta1,'Value'); 
theta(1) = wrapTo360(handles.sliderTheta1.Value)*pi/180;
%plot arm
plot_frame_arm(a,alpha,d,theta,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderTheta1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta2_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta;
handles.Theta2_val.String = get(handles.sliderTheta2,'Value'); 
theta(2) = wrapTo360(handles.sliderTheta2.Value)*pi/180;
%plot arm
plot_frame_arm(a,alpha,d,theta,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderTheta2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta;
handles.d3_val.String = get(handles.slider3,'Value'); 
d(3) = -(handles.slider3.Value);
%plot arm
plot_frame_arm(a,alpha,d,theta,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderTheta4_Callback(hObject, eventdata, handles)
% hObject    handle to sliderTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta;
handles.Theta4_val.String = get(handles.sliderTheta4,'Value'); 
theta(4) = wrapTo360(handles.sliderTheta4.Value)*pi/180;
%plot arm
plot_frame_arm(a,alpha,d,theta,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderTheta4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderTheta4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Opac_val_Callback(hObject, eventdata, handles)
% hObject    handle to Opac_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Opac_val as text
%        str2double(get(hObject,'String')) returns contents of Opac_val as a double


% --- Executes during object creation, after setting all properties.
function Opac_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Opac_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_X_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_X as text
%        str2double(get(hObject,'String')) returns contents of Pos_X as a double


% --- Executes during object creation, after setting all properties.
function Pos_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_Y_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_Y as text
%        str2double(get(hObject,'String')) returns contents of Pos_Y as a double


% --- Executes during object creation, after setting all properties.
function Pos_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pos_Z_Callback(hObject, eventdata, handles)
% hObject    handle to Pos_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pos_Z as text
%        str2double(get(hObject,'String')) returns contents of Pos_Z as a double


% --- Executes during object creation, after setting all properties.
function Pos_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pos_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Roll_value_Callback(hObject, eventdata, handles)
% hObject    handle to Roll_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Roll_value as text
%        str2double(get(hObject,'String')) returns contents of Roll_value as a double


% --- Executes during object creation, after setting all properties.
function Roll_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Roll_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pitch_value_Callback(hObject, eventdata, handles)
% hObject    handle to Pitch_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pitch_value as text
%        str2double(get(hObject,'String')) returns contents of Pitch_value as a double


% --- Executes during object creation, after setting all properties.
function Pitch_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pitch_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yaw_value_Callback(hObject, eventdata, handles)
% hObject    handle to Yaw_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yaw_value as text
%        str2double(get(hObject,'String')) returns contents of Yaw_value as a double


% --- Executes during object creation, after setting all properties.
function Yaw_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yaw_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ChB_coor0.
function ChB_coor0_Callback(hObject, eventdata, handles)
% hObject    handle to ChB_coor0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta
plot_frame_arm(a,alpha,d,theta,handles);
% Hint: get(hObject,'Value') returns toggle state of ChB_coor0


% --- Executes on button press in ChB_coor1.
function ChB_coor1_Callback(hObject, eventdata, handles)
% hObject    handle to ChB_coor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta
plot_frame_arm(a,alpha,d,theta,handles);
% Hint: get(hObject,'Value') returns toggle state of ChB_coor1


% --- Executes on button press in ChB_coor2.
function ChB_coor2_Callback(hObject, eventdata, handles)
% hObject    handle to ChB_coor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta
plot_frame_arm(a,alpha,d,theta,handles);
% Hint: get(hObject,'Value') returns toggle state of ChB_coor2


% --- Executes on button press in ChB_coor3.
function ChB_coor3_Callback(hObject, eventdata, handles)
% hObject    handle to ChB_coor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta
plot_frame_arm(a,alpha,d,theta,handles);
% Hint: get(hObject,'Value') returns toggle state of ChB_coor3


% --- Executes on button press in ChB_coor4.
function ChB_coor4_Callback(hObject, eventdata, handles)
% hObject    handle to ChB_coor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a alpha d theta
plot_frame_arm(a,alpha,d,theta,handles);
% Hint: get(hObject,'Value') returns toggle state of ChB_coor4


% --- Executes on button press in ChB_WoSp.
function ChB_WoSp_Callback(hObject, eventdata, handles)
% hObject    handle to ChB_WoSp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ChB_WoSp



function a1_val_Callback(hObject, eventdata, handles)
% hObject    handle to a1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1_val as text
%        str2double(get(hObject,'String')) returns contents of a1_val as a double


% --- Executes during object creation, after setting all properties.
function a1_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a2_val_Callback(hObject, eventdata, handles)
% hObject    handle to a2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2_val as text
%        str2double(get(hObject,'String')) returns contents of a2_val as a double


% --- Executes during object creation, after setting all properties.
function a2_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d1_val_Callback(hObject, eventdata, handles)
% hObject    handle to d1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d1_val as text
%        str2double(get(hObject,'String')) returns contents of d1_val as a double


% --- Executes during object creation, after setting all properties.
function d1_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d2_val_Callback(hObject, eventdata, handles)
% hObject    handle to d2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d2_val as text
%        str2double(get(hObject,'String')) returns contents of d2_val as a double


% --- Executes during object creation, after setting all properties.
function d2_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Theta1_val_Callback(hObject, eventdata, handles)
% hObject    handle to Theta1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta1_val as text
%        str2double(get(hObject,'String')) returns contents of Theta1_val as a double


% --- Executes during object creation, after setting all properties.
function Theta1_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta1_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Theta2_val_Callback(hObject, eventdata, handles)
% hObject    handle to Theta2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta2_val as text
%        str2double(get(hObject,'String')) returns contents of Theta2_val as a double


% --- Executes during object creation, after setting all properties.
function Theta2_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta2_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d3_val_Callback(hObject, eventdata, handles)
% hObject    handle to d3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d3_val as text
%        str2double(get(hObject,'String')) returns contents of d3_val as a double


% --- Executes during object creation, after setting all properties.
function d3_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d3_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Theta4_val_Callback(hObject, eventdata, handles)
% hObject    handle to Theta4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta4_val as text
%        str2double(get(hObject,'String')) returns contents of Theta4_val as a double


% --- Executes during object creation, after setting all properties.
function Theta4_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta4_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

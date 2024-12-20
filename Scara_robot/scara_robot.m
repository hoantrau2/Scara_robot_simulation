function varargout = scara_robot(varargin)
% SCARA_ROBOT MATLAB code for scara_robot.fig
%     Created on: DEC 1, 2023
%      Author: NGOC HOAN
% Last Modified by GUIDE v2.5 13-Dec-2023 02:55:19
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
% Choose default command line output for scara_robot
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% set(handles.Trajectory_table, 'visible', 'on');
set(handles.End_effector_table, 'visible', 'off');
set(handles.Show_Joints_table, 'visible', 'off');
global a alpha d theta opacity T myTimer;
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
varargout{1} = handles.output;

function sliderTheta1_Callback(hObject, eventdata, handles)
handles.Theta1_val.String = get(handles.sliderTheta1,'Value'); 
function sliderTheta1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function sliderTheta2_Callback(hObject, eventdata, handles)
handles.Theta2_val.String = get(handles.sliderTheta2,'Value'); 
function sliderTheta2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider_d3_Callback(hObject, eventdata, handles)
handles.d3_val.String = get(handles.slider_d3,'Value');
function slider_d3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

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

function Show_coordination_Callback(hObject, eventdata, handles)
global a alpha d theta opacity T
T = Transformation_matrix(a,alpha,d,theta,handles,opacity);
Draw_robot(a,alpha,d,theta,handles,opacity,T);

function Show_WS_Callback(hObject, eventdata, handles)
global a alpha d theta opacity T
T = Transformation_matrix(a,alpha,d,theta,handles,opacity);
Draw_robot(a,alpha,d,theta,handles,opacity,T);


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

function Forward_button_Callback(hObject, eventdata, handles)
global a alpha d theta opacity;
[theta, d] = Forward_Kinematics(a,alpha,d,theta,handles,opacity);

function velocity_rate_box_Callback(hObject, eventdata, handles)
function velocity_rate_box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Inverse_button_Callback(hObject, eventdata, handles)
global a alpha d theta opacity T;
yaw = str2double(handles.Yaw_value.String)*pi/180;

% check singularities of x
x = str2double(handles.Pos_X.String);
% if (z > d(1) + d(2))
%     msgbox('z exceed the specified value > ');
%     z = d(1) + d(2);
% elseif (z < d(1) + d(2) -150)
%     msgbox(sprintf('z exceed the specified value: z < %f', d(1) + d(2) -150 ));
%     z = d(1) + d(2) -150;
% end

% check singularities of y
y = str2double(handles.Pos_Y.String);
% if (z > d(1) + d(2))
%     msgbox(sprintf('z exceed the specified value: z > %f', d(1) + d(2) ));
%     z = d(1) + d(2);
% elseif (z < d(1) + d(2) -150)
%     msgbox(sprintf('z exceed the specified value: z < %f', d(1) + d(2) -150 ));
%     z = d(1) + d(2) -150;
% end

% check singularities of z
z = str2double(handles.Pos_Z.String);
% if (z > d(1) + d(2))
%     msgbox(sprintf('z exceed the specified value: z > %f', d(1) + d(2) ));
%     z = d(1) + d(2);
% elseif (z < d(1) + d(2) -150)
%     msgbox(sprintf('z exceed the specified value: z < %f', d(1) + d(2) -150 ));
%     z = d(1) + d(2) -150;
% end
[T,malloc] = Inverse_Kinematics(a,alpha,d,theta,yaw,x,y,z,handles,opacity);

function Trajectory_button_Callback(hObject, eventdata, handles)
set(handles.Trajectory_table, 'visible', 'on');
set(handles.End_effector_table, 'visible', 'off');
set(handles.Show_Joints_table, 'visible', 'off');
function End_effector_button_Callback(hObject, eventdata, handles)
set(handles.Trajectory_table, 'visible', 'off');
set(handles.End_effector_table, 'visible', 'on');
 set(handles.Show_Joints_table, 'visible', 'off');
function Joint_button_Callback(hObject, eventdata, handles)
set(handles.Trajectory_table, 'visible', 'off');
set(handles.End_effector_table, 'visible', 'off');
set(handles.Show_Joints_table, 'visible', 'on');

function q_max_value_Callback(hObject, eventdata, handles)
function q_max_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function v_max_value_Callback(hObject, eventdata, handles)
function v_max_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function a_max_value_Callback(hObject, eventdata, handles)
function a_max_value_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Trajectory_select_Callback(hObject, eventdata, handles)
function Trajectory_select_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Path_Planning_select_Callback(hObject, eventdata, handles)
function Path_Planning_select_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Plot_button_Callback(hObject, eventdata, handles)
global a alpha d theta opacity;
Trajectory_planning(handles,a,alpha,d,theta,opacity)

function update_button_Callback(hObject, eventdata, handles)
global a d ;
a(1) = str2double(handles.a1_val.String);
a(2) = str2double(handles.a2_val.String);
d(1) = str2double(handles.d1_val.String);
d(2) = str2double(handles.d2_val.String);

function Pos_X_Desire_Callback(hObject, eventdata, handles)
function Pos_X_Desire_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pos_Z_Desire_Callback(hObject, eventdata, handles)
function Pos_Z_Desire_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pos_Y_Desire_Callback(hObject, eventdata, handles)
function Pos_Y_Desire_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pos_Yaw_Desire_Callback(hObject, eventdata, handles)
function Pos_Yaw_Desire_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Yaw_Desire_Callback(hObject, eventdata, handles)
function Yaw_Desire_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Trapezoidal_select_Callback(hObject, eventdata, handles)
function S_curve_select_Callback(hObject, eventdata, handles)

function plot_a2(handles,T,a,alpha,d,theta)
x = round(T(1,4,1),2);
y = round(T(2,4,1),2);
L = a(2);
W = 70;
H1 = d(1) + d(2) + 60;
H2 = d(1) + d(2) - 20;
opacity = str2double(handles.Opac_val.String);

Yaw = round(atan2(-T(1,2,2),T(1,1,2)),2)-pi/2;

fill3(handles.axes1,[x-W/2*cos(Yaw),x+W/2*cos(Yaw),x-L*sin(Yaw)+W/2*cos(Yaw),x-L*sin(Yaw)-W/2*cos(Yaw)],[y-W/2*sin(Yaw), y+W/2*sin(Yaw), y+L*cos(Yaw)+W/2*sin(Yaw), y+L*cos(Yaw)-W/2*sin(Yaw)],[H2, H2, H2, H2 ],[255, 140, 200]/255,'FaceAlpha',opacity)
fill3(handles.axes1,[x-W/2*cos(Yaw),x+W/2*cos(Yaw),x-L*sin(Yaw)+W/2*cos(Yaw),x-L*sin(Yaw)-W/2*cos(Yaw)],[y-W/2*sin(Yaw), y+W/2*sin(Yaw), y+L*cos(Yaw)+W/2*sin(Yaw), y+L*cos(Yaw)-W/2*sin(Yaw)],[H1, H1, H1, H1 ],[255, 140, 200]/255,'FaceAlpha',opacity)
fill3(handles.axes1,[x+W/2*cos(Yaw), x+W/2*cos(Yaw)-L*sin(Yaw), x+W/2*cos(Yaw)-L*sin(Yaw), x+W/2*cos(Yaw)],[y+W/2*sin(Yaw), y+L*cos(Yaw)+W/2*sin(Yaw), y+L*cos(Yaw)+W/2*sin(Yaw), y+W/2*sin(Yaw)],[H2, H2, H1, H1 ],[255, 140, 200]/255,'FaceAlpha',opacity)
fill3(handles.axes1,[x-W/2*cos(Yaw), x-W/2*cos(Yaw)-L*sin(Yaw), x-W/2*cos(Yaw)-L*sin(Yaw), x-W/2*cos(Yaw)],[y-W/2*sin(Yaw), y+L*cos(Yaw)-W/2*sin(Yaw), y+L*cos(Yaw)-W/2*sin(Yaw), y-W/2*sin(Yaw)],[H2, H2, H1, H1 ],[255, 140, 200]/255,'FaceAlpha',opacity)
end
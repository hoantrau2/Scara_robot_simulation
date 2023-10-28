function plot_arm(handles,T,a,alpha,d,theta)
%%
%BASE
x = 0;
y = 0;
z = 0;
H1 = 50;
R1 = 250;
opacity = str2double(handles.Opac_val.String);
th = 0:pi/100:2*pi;
a = R1*cos(th);
b = R1*sin(th);

surf(handles.axes1, [a;a]+x, [b;b]+y, [ones(1, size(th, 2)); zeros(1, size(th, 2))]*H1, 'FaceColor',[139 137 137]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),[139 137 137]/255, 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, H1*ones(1, size(th, 2)),[139 137 137]/255, 'FaceAlpha', opacity);

%%
%D1
x = 0;
y = 0;
z = 50;
H1 = 363-20;
R1 = 80;
opacity = str2double(handles.Opac_val.String);
th = 0:pi/100:2*pi;
a = R1*cos(th);
b = R1*sin(th);

surf(handles.axes1, [a;a]+x, [b;b]+y, [z*ones(1, size(th, 2)); ones(1, size(th, 2))*H1], 'FaceColor',[0 178 238]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
 fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),[0 178 238]/255, 'FaceAlpha', opacity);
 fill3(handles.axes1, a+x, b+y, H1*ones(1, size(th, 2)),[0 178 238]/255, 'FaceAlpha', opacity);

%%
%Joint 1
r= 80;
opacity = str2double(handles.Opac_val.String);
[u,v] = meshgrid(linspace(0,2*pi,50),linspace(0,acos(20/r),50));
x = r.*cos(u).*sin(v);
y = r.*sin(u).*sin(v);
z = r.*cos(v)+363;
surf(handles.axes1,x,y,z,'EdgeColor',[205 200 177]/255,'FaceColor','none','FaceAlpha',opacity)
hold on
[u,v] = meshgrid(linspace(0,2*pi,50),linspace(acos(20/r),acos(-20/r),50));
x = r.*cos(u).*sin(v);
y = r.*sin(u).*sin(v);
z = r.*cos(v)+d(1);
surf(handles.axes1,x,y,z,'EdgeColor',[80, 140, 91]/255,'FaceColor','none','FaceAlpha',opacity)

%%
%D2
x = round(T(1,4,1),2);
y = round(T(2,4,1),2);
z = round(T(3,4,1),2);
H1 = z - 40;
H2 = z + d(2) + 30;
R1 = 50;
opacity = str2double(handles.Opac_val.String);
th = 0:pi/100:2*pi;
a = R1*cos(th);
b = R1*sin(th);

surf(handles.axes1, [a;a]+x, [b;b]+y, [H1*ones(1, size(th, 2)); ones(1, size(th, 2))*(H1+20)], 'FaceColor',[0 178 238]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
surf(handles.axes1, [a;a]+x, [b;b]+y, [(z-20)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z+20)], 'FaceColor',[80, 140, 91]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
surf(handles.axes1, [a;a]+x, [b;b]+y, [(z+20)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z+d(2)-20)], 'FaceColor',[0 178 238]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
% fill3(handles.axes1, a+x, b+y, H2*ones(1, size(th, 2)),[0 178 238]/255, 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, H1*ones(1, size(th, 2)),[0 178 238]/255, 'FaceAlpha', opacity);

%%
%Joint 2
r= 50;
opacity = str2double(handles.Opac_val.String);
[u,v] = meshgrid(linspace(0,2*pi,50),linspace(0,acos(20/r),50));
x = r.*cos(u).*sin(v) + round(T(1,4,1),2);
y = r.*sin(u).*sin(v) + round(T(2,4,1),2);
z = r.*cos(v) + d(1) + d(2);
surf(handles.axes1,x,y,z,'EdgeColor',[205 200 177]/255,'FaceColor','none','FaceAlpha',opacity)
hold on
[u,v] = meshgrid(linspace(0,2*pi,50),linspace(acos(20/r),acos(-20/r),50));
x = r.*cos(u).*sin(v) + round(T(1,4,1),2);
y = r.*sin(u).*sin(v) + round(T(2,4,1),2);
z = r.*cos(v) + d(1) + d(2);
surf(handles.axes1,x,y,z,'EdgeColor',[80, 140, 91]/255,'FaceColor','none','FaceAlpha',opacity)

%%
%D3
x = round(T(1,4,3),2);
y = round(T(2,4,3),2);
z = round(T(3,4,3),2);
H1 = z + 200;
R1 = 20;
opacity = str2double(handles.Opac_val.String);
th = 0:pi/100:2*pi;
a = R1*cos(th);
b = R1*sin(th);

surf(handles.axes1, [a;a]+x, [b;b]+y, [H1*ones(1, size(th, 2)); ones(1, size(th, 2))*z], 'FaceColor','black', 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, H1*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);

%%
%static D3
x = round(T(1,4,2),2);
y = round(T(2,4,2),2);
z = round(T(3,4,2),2);
H1 = z + 20;
H2 = z - 20;
H3 = z + 180;
R1 = 30;
opacity = str2double(handles.Opac_val.String);
th = 0:pi/100:2*pi;
a = R1*cos(th);
b = R1*sin(th);

surf(handles.axes1, [a;a]+x, [b;b]+y, [H1*ones(1, size(th, 2)); ones(1, size(th, 2))*H3], 'FaceColor',[255 165 79]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
surf(handles.axes1, [a;a]+x, [b;b]+y, [H1*ones(1, size(th, 2)); ones(1, size(th, 2))*H2], 'FaceColor',[80 140 91]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, H1*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);
 fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);

%%
%D4
x = round(T(1,4,3),2);
y = round(T(2,4,3),2);
z = round(T(3,4,3),2);
H2 = z - 30;
R1 = 20;
opacity = str2double(handles.Opac_val.String);
th = 0:pi/100:2*pi;
a = R1*cos(th);
b = R1*sin(th);

surf(handles.axes1, [a;a]+x, [b;b]+y, [H2*ones(1, size(th, 2)); ones(1, size(th, 2))*z], 'FaceColor',[238 106 167]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, H2*ones(1, size(th, 2)),[238 106 167]/255, 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),[238 106 167]/255, 'FaceAlpha', opacity);

end
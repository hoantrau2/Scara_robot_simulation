function Draw_link_3(handles,T,a,alpha,d,theta,opacity)
%%
%BASE
x = 0;
y = 0;
z = 0;
R1 = 250;
th = 0:pi/3:2*pi;
a = R1*cos(th);
b = R1*sin(th);
surf(handles.axes1, [a;a]+x, [b;b]+y, [z*ones(1, size(th, 2)); (z+50)*ones(1, size(th, 2))], 'FaceColor',[200 200 200]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),[200 200 200]/255, 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, (z+50)*ones(1, size(th, 2)),[200 200 200]/255, 'FaceAlpha', opacity);

%%
%Link0
x = 0;
y = 0;
z = 50;
R1 = 80;
th = 0:pi/25:2*pi;
a = R1*cos(th);
b = R1*sin(th);
surf(handles.axes1, [a;a]+x, [b;b]+y, [z*ones(1, size(th, 2)); ones(1, size(th, 2))*(d(1)-20)], 'FaceColor',[0 0 0]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),[0 0 0]/255, 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, (d(1)-20)*ones(1, size(th, 2)),[0 0 0]/255, 'FaceAlpha', opacity);

%%
%Joint 1
fill3(handles.axes1, a+x, b+y, (d(1)+23.5)*ones(1, size(th, 2)),[0, 0, 0]/255, 'FaceAlpha', opacity);
hold on
r= 80;
[u,v] = meshgrid(linspace(0,2*pi,25),linspace(acos(20/r),acos(-20/r),50));
x = r.*cos(u).*sin(v);
y = r.*sin(u).*sin(v);
z = r.*cos(v)+d(1);
surf(handles.axes1,x,y,z,'EdgeColor',[255, 140, 200]/255,'FaceColor','none','FaceAlpha',opacity)
%%%%%% tu day len tren thoat ra khoi ham lap, do cham chuong trinh
%%
%tru_joint_2
x = T(1,4,1);
y = T(2,4,1);
z = T(3,4,1);
R1 = 50;
th = 0:pi/25:2*pi;
a = R1*cos(th);
b = R1*sin(th);
surf(handles.axes1, [a;a]+x, [b;b]+y, [(z-40)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z-40+20)], 'FaceColor',[0 0 0]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
surf(handles.axes1, [a;a]+x, [b;b]+y, [(z-20)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z+20)], 'FaceColor',[255, 140, 200]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
surf(handles.axes1, [a;a]+x, [b;b]+y, [(z+20)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z+d(2)-20)], 'FaceColor',[0 0 0]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
surf(handles.axes1, [a;a]+x, [b;b]+y, [(z+d(2)-20)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z+d(2)+70)], 'FaceColor',[255, 140, 200]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, (z-40)*ones(1, size(th, 2)),[0 0 0]/255, 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, (z+ d(2)+71)*ones(1, size(th, 2)),[0 0 0]/255, 'FaceAlpha', opacity);

%%
%Joint 2
r= 50;
[u,v] = meshgrid(linspace(0,2*pi,25),linspace(0,acos(10/r),50));
x = r.*cos(u).*sin(v) + round(T(1,4,1),2);
y = r.*sin(u).*sin(v) + round(T(2,4,1),2);
z = r.*cos(v) + d(1) + d(2)+60;
% surf(handles.axes1,x,y,z,'EdgeColor',[0 0 0]/255,'FaceColor','none','FaceAlpha',opacity)


%%
%truc tinh tien 3
x = T(1,4,3);
y = T(2,4,3);
z = T(3,4,3);
R1 = 20;
th = 0:pi/30:2*pi;
a = R1*cos(th);
b = R1*sin(th);
surf(handles.axes1, [a;a]+x, [b;b]+y, [z*ones(1, size(th, 2)); ones(1, size(th, 2))*(z+200)], 'FaceColor','black', 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, (z+200)*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);

%%
%static D3
x = T(1,4,2);
y = T(2,4,2);
z = T(3,4,2);
R1 = 30;
th = 0:pi/30:2*pi;
a = R1*cos(th);
b = R1*sin(th);
 surf(handles.axes1, [a;a]+x, [b;b]+y, [(z + 20)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z + 100)], 'FaceColor',[255, 140, 200]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
 surf(handles.axes1, [a;a]+x, [b;b]+y, [(z - 20)*ones(1, size(th, 2)); ones(1, size(th, 2))*(z + 20)], 'FaceColor',[255, 140, 200]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
 fill3(handles.axes1, a+x, b+y, (z + 20)*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);
 fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),'black', 'FaceAlpha', opacity);

%%
%D4
x = T(1,4,3);
y = T(2,4,3);
z = T(3,4,3);
R1 = 20;
th = 0:pi/30:2*pi;
a = R1*cos(th);
b = R1*sin(th);

surf(handles.axes1, [a;a]+x, [b;b]+y, [(z - 30)*ones(1, size(th, 2)); ones(1, size(th, 2))*z], 'FaceColor',[238 106 167]/255, 'EdgeColor', 'none', 'FaceAlpha', opacity)
fill3(handles.axes1, a+x, b+y, (z - 30)*ones(1, size(th, 2)),[238 106 167]/255, 'FaceAlpha', opacity);
fill3(handles.axes1, a+x, b+y, z*ones(1, size(th, 2)),[238 106 167]/255, 'FaceAlpha', opacity);

%% 
 %End effector
plot3(handles.axes1,[(round(T(1,4,3),2) - (-15)*cos(theta(4))) round(T(1,4,3),2)],[(round(T(2,4,3),2) - (-15)*sin(theta(4))) round(T(2,4,3),2)],[d(1)+d(2)+d(3)+(-15) d(1)+d(2)+d(3)+(-15)],'Color',[255, 140, 200]/255,'linewidth',5);
plot3(handles.axes1,[(round(T(1,4,3),2) + (-15)*cos(theta(4))) round(T(1,4,3),2)],[(round(T(2,4,3),2) + (-15)*sin(theta(4))) round(T(2,4,3),2)],[d(1)+d(2)+d(3)+(-15) d(1)+d(2)+d(3)+(-15)],'Color',[255, 140, 200]/255,'linewidth',5);
plot3(handles.axes1,[(round(T(1,4,3),2) - (-15)*cos(theta(4))) (round(T(1,4,3),2) - (-15)*cos(theta(4)))],[(round(T(2,4,3),2) - (-15)*sin(theta(4))) (round(T(2,4,3),2) - (-15)*sin(theta(4)))],[d(1)+d(2)+d(3)+(-15) d(1)+d(2)+d(3)+(-50)+(-15)],'red','linewidth',5);
plot3(handles.axes1,[(round(T(1,4,3),2) + (-15)*cos(theta(4))) (round(T(1,4,3),2) + (-15)*cos(theta(4)))],[(round(T(2,4,3),2) + (-15)*sin(theta(4))) (round(T(2,4,3),2) + (-15)*sin(theta(4)))],[d(1)+d(2)+d(3)+(-15) d(1)+d(2)+d(3)+(-50)+(-15)],'red','linewidth',5);
    
end
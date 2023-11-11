function plot_coordinate(handles,x,y,z,x_dir,y_dir,z_dir,num)
% x,y,z: toa do bat dau cua he toa do
% x_dir, y_dir, z_dir: huong cua truc toa do tuong ung
% num: so thu tu cua he truc toa do
if (x == 0 && y == 0 && z == 0)
hold on
line(handles.axes1,[x x+600*x_dir],[y y],[z z],'linewidth',1.5,'color', 'red')
text(handles.axes1,x+600*x_dir,y,z,(['x',num2str(num)]))

line(handles.axes1,[x x],[y y+600*y_dir],[z z],'linewidth',1.5,'color', 'green')
text(handles.axes1,x,y+600*y_dir,z,(['y',num2str(num)]))

line(handles.axes1,[x x],[y y],[z z+1000*z_dir/2],'linewidth',1.5,'color', 'blue')
text(handles.axes1,x,y,z+1000*z_dir/2,(['z',num2str(num)]))
else
hold on
line(handles.axes1,[x x+200*x_dir],[y y+200*y_dir],[z z],'linewidth',1.5,'color', 'red')
text(handles.axes1,x+200*x_dir,y+200*y_dir,z,(['x',num2str(num)]))

line(handles.axes1,[x x-200*y_dir],[y y+200*x_dir],[z z],'linewidth',1.5,'color', 'green')
text(handles.axes1,x-200*y_dir,y+200*x_dir,z,(['y',num2str(num)]))

line(handles.axes1,[x x],[y y],[z z+200*z_dir],'linewidth',1.5,'color', 'blue')
text(handles.axes1,x,y,z+200*z_dir,(['z',num2str(num)]))
end
end
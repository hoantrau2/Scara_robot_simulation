% function [break_signal,theta1_new,theta2_new,theta4_new,d3_new] = Inverse_kinematics(handles,a,alpha,d,theta,px,py,pz,yaw)
% %%
% global a alpha d theta
% break_signal = 0;
% 
% %%
% %Inverse Kinematics
% d3_new = d(1) - pz;
% if (d3_new < 0 || abs(d3_new) > 150)
%     error('The new d3 is out of range');
%     break_signal = 1;
%     return
% end 
% 
% c2 = ( px^2 + py^2 - a(1)^2 - a(2)^2)/(2*a(1)*a(2));
% theta2_new =  acos(c2);
% if (theta2_new < -145*pi/180 || theta2_new > 145*pi/180)
%     error('The new theta2 is out of range');
%     break_signal = 1;
%     return
% end
% 
% tmp = (a(1) + a(2)*cos(theta2_new))^2 + (a(2)*sin(theta2_new))^2;
% c1 = (px*(a(1) + a(2)*cos(theta2_new)) + py*a(2)*sin(theta2_new))/tmp;
% s1 = (py*(a(1) + a(2)*cos(theta2_new)) - px*a(2)*sin(theta2_new))/tmp;
% theta1_new = atan2(s1,c1);
% if (theta1_new < -125*pi/180 || theta1_new > 125*pi/180)
%     error('The new theta1 is out of range');
%     break_signal = 1;
%     return
% end
% 
% theta4_new = yaw - theta1_new - theta2_new;
% 
% %% Update values to plot
%     set(handles.d3_val,'String',num2str(round(d3_new,2)));
%     set(handles.sliderd3,'Value',d3_new);
%     set(handles.Theta1_val,'String',num2str(round(theta1_new*180/pi,2)));
%     set(handles.sliderTheta1,'Value',theta1_new*180/pi);
%     set(handles.Theta2_val,'String',num2str(round(theta2_new*180/pi,2)));
%     set(handles.sliderTheta2,'Value',theta2_new*180/pi);
%     set(handles.Theta4_val,'String',num2str(round(theta4_new*180/pi,2)));
%     set(handles.sliderTheta4,'Value',theta4_new*180/pi);
%     theta(1) = wrapTo360(str2double(handles.Theta1_val.String))*pi/180;
%     theta(2) = wrapTo360(str2double(handles.Theta2_val.String))*pi/180;
%     theta(4) = wrapTo360(str2double(handles.Theta4_val.String))*pi/180;
%     d(3) = -(str2double(handles.d3_val.String));
% 
% end

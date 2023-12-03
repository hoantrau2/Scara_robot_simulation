function [update_theta, update_d]=Forward_Kinematics(a,alpha,d,theta,handles,opacity)
 sub_theta = theta;
 sub_d = d; 
 
 pre_theta1 = wrapTo360(handles.sliderTheta1.Value)*pi/180;
 pre_theta2 = wrapTo360(handles.sliderTheta2.Value)*pi/180;
 pre_theta4 = wrapTo360(handles.sliderTheta4.Value)*pi/180;
 pre_d3 = (handles.slider_d3.Value);
 velocity = str2double(handles.velocity_rate_box.String);
 
 for i= 1:velocity
sub_theta(1) = sub_theta(1)+(pre_theta1 - theta(1))/velocity;
sub_theta(2) = sub_theta(2)+(pre_theta2 - theta(2))/velocity;
sub_d(3) = sub_d(3)+(-pre_d3 - d(3))/velocity;
sub_theta(4) = sub_theta(4)+(pre_theta4 - theta(4))/velocity;
pause(0.001);
T = Transformation_matrix(a,alpha,sub_d,sub_theta,handles,opacity);
Draw_robot(a,alpha,sub_d,sub_theta,handles,opacity,T);
%In a Scara robot, only 4 parameters are of interest: X, Y, Z, and Yaw. 
%In this case, Roll and Pitch are both equal to zero
handles.Pos_X.String = num2str(round(T(1,4,4),3));
handles.Pos_Y.String = num2str(round(T(2,4,4),3));
handles.Pos_Z.String = num2str(round(T(3,4,4),3));
handles.Yaw_value.String   = num2str(round(atan2(T(2,1,4),T(1,1,4))*180/pi,3));
 end

msgbox('Finished the forward kinematics movement', 'Notice', 'modal');
update_theta = sub_theta;
update_d = sub_d; 
end
function T_new = Inverse_Kinematics(a,alpha,d,theta,yaw,x,y,z,handles,opacity)
T = Transformation_matrix(a,alpha,d,theta,handles,opacity);
% calculate d3
d(3) = d(1) + d(2) - z;
if (d(3) < 0)
    msgbox('The new d(3) is out of range d3 <0', 'Notice', 'modal');
    d(3)= 0;
    return
end 
if ( d(3) > 150)
    msgbox('The new d(3) is out of range d3 >150', 'Notice', 'modal');
    d(3) = 150;
    return
end 

% calculate theta(2)
c2 = (x^2 + y^2 -a(1)^2 - a(2)^2)/((2*a(1)*a(2)));
theta(2) =  atan2(sqrt(1-c2^2),c2);
if (theta(2) < -145*pi/180)
    msgbox('The new theta(2) is out of range theta(2) < -145', 'Notice', 'modal');
    theta(2) = -145*pi/180;
    return
end
if (theta(2) > 145*pi/180)
    msgbox('The new theta(2) is out of range theta(2) > 145', 'Notice', 'modal');
    theta(2) = 145*pi/180;
    return
end

% calculate theta(1)
denominator = a(1)^2 + a(2)^2 + 2*a(1)*a(2)*cos(theta(2));
s1 = (y*(a(1) + a(2)*cos(theta(2))) - x*a(2)*sin(theta(2)))/denominator;
theta(1)  = atan2(s1,sqrt(1-s1^2));
if (theta(1) < -125*pi/180)
    msgbox('The new theta1 is out of range theta(1) < -125', 'Notice', 'modal');
    theta(1) =  -125*pi/180;
    return
end
if (theta(1) > 125*pi/180)
    msgbox('The new theta1 is out of range theta(1) > 125', 'Notice', 'modal');
    theta(1) =  125*pi/180;
    return
end

% calculate theta(4)
   R_4to0 = [cos(yaw)     -sin(yaw)    0;
             sin(yaw)      cos(yaw)    0;
             0             0           1];
   R_4to3 = inv(T(1:3, 1:3, 3))*R_4to0;
theta(4) = atan2(R_4to3(2,1),R_4to3(1,1));
d(3) = -d(3);
T_new = Transformation_matrix(a,alpha,d,theta,handles,opacity);
Draw_robot(a,alpha,d,theta,handles,opacity,T_new);
handles.Theta1_val.String = num2str(round(theta(1),3)*180/pi);handles.sliderTheta1.Value = str2double(handles.Theta1_val.String);
handles.Theta2_val.String = num2str(round(theta(2),3)*180/pi);handles.sliderTheta2.Value = str2double(handles.Theta2_val.String);
handles.d3_val.String = num2str(round(-d(3),3));handles.slider_d3.Value = str2double(handles.d3_val.String);
handles.Theta4_val.String = num2str(round(theta(4),3)*180/pi);handles.sliderTheta4.Value = str2double(handles.Theta4_val.String);
end

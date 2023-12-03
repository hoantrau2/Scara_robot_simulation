function T_new = Inverse_kinematics(a,alpha,d,theta,yaw,x,y,z,T)
% calculate d3
d(3) = d(1) + d(2) - z;
if (d(3) < 0)
    error('The new d(3) is out of range d3 <0');
    d(3)= 0;
    return
end 
if ( d(3) > 150)
    error('The new d(3) is out of range d3 >150');
    d(3) = 150;
    return
end 

% calculate theta(2)
c2 = (x^2 + y^2 -a(1)^2 - a(2)^2)/((2*a(1)*a(2));
theta(2) =  atan2(sqrt(1-c2^2)/c2);
if (theta(2) < -145*pi/180)
    error('The new theta(2) is out of range theta(2) < -145');
    theta(2) = -145*pi/180;
    return
end
if (theta(2) > 145*pi/180)
    error('The new theta(2) is out of range  theta(2) > 145');
    theta(2) = 145*pi/180;
    return
end

% calculate theta(1)
denominator = a(1)^2 + a(2)^2 + 2*a(1)*a(2)*cos(theta(2));
s1 = (y*(a(1) + a(2)*cos(theta(2))) - x*a(2)*sin(theta(2)))/denominator;
theta(1)  = atan2(s1,sqrt(1-s1^2));
if (theta(1) < -125*pi/180)
    error('The new theta1 is out of range theta(1) < -125');
    theta(1) =  -125*pi/180;
    return
end
if (theta(1) > 125*pi/180)
    error('The new theta1 is out of range theta(1) > 125');
    theta(1) =  125*pi/180;
    return
end

% calculate theta(4)
   R_4to0 = [cos(yaw)     -sin(yaw)    0;
             sin(yaw)      cos(yaw)    0;
             0             0           1];
   R_4to3 = inv(T(1:3, 1:3, 3)*R_4to0;
   theta(4) = atan2(sqrt(1-R_4to3(1,1)^2)/R_4to3(1,1));
T_new = T;
end

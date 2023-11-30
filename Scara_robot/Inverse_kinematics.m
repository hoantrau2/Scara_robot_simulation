function Inverse_kinematics(a,alpha,d,theta,handles,opacity,yaw,x,y,z)

global break_signal
break_signal = 0;

d3 = d(1) + d(2) - z;
if (d3 < 0 || abs(d3) > 150)
    error('The new d(3) is out of range');
    break_signal = 1;
    return
end 

c2 = (x^2 + y^2 -a(1)^2 - a(2)^2)/((2*a(1)*a(2));
theta(2) =  atan2(sqrt(1-c2^2)/c2);
if (theta(2) < -145*pi/180 || theta(2) > 145*pi/180)
    error('The new theta(2) is out of range');
    break_signal = 1;
    return
end

denominator = a(1)^2 + a(2)^2 + 2*a(1)*a(2)*cos(theta(2));
c1 = (y* (a(2)*cos(theta(2)) +a(1) - )/denominator;
s1 = (py*(a(1) + a(2)*cos(theta2_new)) - px*a(2)*sin(theta2_new))/denominator;
theta1_new = atan2(s1,c1);
if (theta1_new < -125*pi/180 || theta1_new > 125*pi/180)
    error('The new theta1 is out of range');
    break_signal = 1;
    return
end



end

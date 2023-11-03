function T = Forward_Kinematics(a,alpha,d,theta,handles)
    T(:,:,1)= Denavit_Hartenberg_matrix(a(1),alpha(1),d(1),theta(1));
    for i = 2:4
        T(:,:,i) = T(:,:,i-1)*Denavit_Hartenberg_matrix(a(i),alpha(i),d(i),theta(i));
    end  
handles.Pos_X.String = num2str(round(T(1,4,4),2));
handles.Pos_Y.String = num2str(round(T(2,4,4),2));
handles.Pos_Z.String = num2str(round(T(3,4,4),2));

handles.Roll_value.String  = num2str(round(atan2(-T(2,3,4),T(3,3,4))*180/pi,2));
handles.Pitch_value.String = num2str(round(asin(abs(T(1,3,4)))*180/pi,2));
handles.Yaw_value.String   = num2str(round(atan2(T(1,2,4),T(1,1,4))*180/pi,2));
 
end
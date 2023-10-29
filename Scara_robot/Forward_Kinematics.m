function T = Forward_Kinematics(a,alpha,d,theta,handles)
A0_1 = Link_matrix(a(1),alpha(1),d(1),theta(1));
A1_2 = Link_matrix(a(2),alpha(2),d(2),theta(2));
A2_3 = Link_matrix(a(3),alpha(3),d(3),theta(3));
A3_4 = Link_matrix(a(4),alpha(4),d(4),theta(4));

T(:,:,1) =  A0_1;
T(:,:,2) =  A0_1 * A1_2;
T(:,:,3) =  A0_1 * A1_2 * A2_3;
T(:,:,4) =  A0_1 * A1_2 * A2_3 * A3_4;   

handles.Pos_X.String = num2str(round(T(1,4,4),2));
handles.Pos_Y.String = num2str(round(T(2,4,4),2));
handles.Pos_Z.String = num2str(round(T(3,4,4),2));

handles.Roll_value.String  = num2str(round(atan2(-T(2,3,4),T(3,3,4))*180/pi,2));
handles.Pitch_value.String = num2str(round(asin(abs(T(1,3,4)))*180/pi,2));
handles.Yaw_value.String   = num2str(round(atan2(T(1,2,4),T(1,1,4))*180/pi,2));
 
end
function [q_max, a1_xy, a3_xy, a1_z, a3_z, O_cir,r]= Path_Circular_Interpolation_3D(handles)
%%
    % Old value
    p_x_old = str2double(get(handles.Pos_X,'String'));
    p_y_old = str2double(get(handles.Pos_Y,'String'));
    p_z_old = str2double(get(handles.Pos_Z,'String'));
    %yaw_old = str2double(get(handles.Yaw_val,'String'))*pi/180;

    % desired value
    p_x = str2double(get(handles.Pos_X_Desire,'String'));
    p_y = str2double(get(handles.Pos_Y_Desire,'String'));
    p_z = str2double(get(handles.Pos_Z_Desire,'String'));
    %yaw = str2double(get(handles.Yaw_val_Next,'String'))*pi/180;

    %Find the third point
    p_x_mid = abs(p_x - p_x_old)/2;
    p_y_mid = abs(p_y + p_y_old)/2;
    p_z_mid = abs(p_z - p_z_old)/2;
    
    p3 = [p_x p_y p_z];
    p1 = [p_x_old p_y_old p_z_old];
    p2 = [p_x_mid p_y_mid p_z_mid];
%%
    %Caculate radius:
    a = norm(p2 - p3)^2;
    b = norm(p1 - p3)^2;
    c = norm(p1 - p2)^2;
    if ~(a + b > c && a + c > b && b + c > a)
    p_z_mid = abs(p_z + p_z_old)/2;
    p2 = [p_x_mid p_y_mid p_z_mid];
    a = norm(p2 - p3)^2;
    b = norm(p1 - p3)^2;
    c = norm(p1 - p2)^2;
    end
    s = (a + b + c) / 2;%Half circumference
    R_cir = (a * b * c) / (4 * sqrt(s * (s - a) * (s - b) * (s - c)));
    
    %Caculate Circle center point:
    N = a * (b + c - a) + b * (c + a - b) + c * (a + b - c);
    D = 2 * (a * (b + c - a) * p1 + b * (c + a - b) * p2 + c * (a + b - c) * p3);
    O_cir = D / N;
    
    
    
    
    
    
    
    
   
    a1_xy = atan2(p_y_old - O_cir(2) , p_x_old - O_cir(1));
    a3_xy = atan2(p_y - O_cir(2) , p_x - O_cir(1));

    a1_z = atan(sqrt((p1(1) - O_cir(1))^2+(p1(2) - O_cir(2))^2)/(p1(3) - O_cir(3)));
    a3_z = atan(sqrt((p3(1) - O_cir(1))^2+(p3(2) - O_cir(2))^2)/(p3(3) - O_cir(3)));
    
%     if (p_z_old == p_z)  
%         q_max = r*abs((a3_xy - a1_xy));
%     else 
%         q_max = r*abs((a3_z - a1_z));
%     end
    q_max = r*abs((a3_xy - a1_xy));
end
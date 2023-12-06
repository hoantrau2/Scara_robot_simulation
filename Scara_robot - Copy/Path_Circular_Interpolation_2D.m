function [q_max, a1, a3, r, O_cir]= Path_Circular_Interpolation_2D(handles)
%%
%2D Circular interpolation
%%
    % Old value
    p_x_old = str2double(get(handles.Pos_X,'String'));
    p_y_old = str2double(get(handles.Pos_Y,'String'));
    p_z_old = str2double(get(handles.Pos_Z,'String'));

    % desired value
    p_x = str2double(get(handles.Pos_X_Desire,'String'));
    p_y = str2double(get(handles.Pos_Y_Desire,'String'));
    p_z = str2double(get(handles.Pos_Z_Desire,'String'));
    
    %Find the third point
    p_x_mid = 850;
    p_y_mid = 0;
%%
    %Circle center point:
    A = 2*[(p_x_mid - p_x_old) (p_y_mid - p_y_old); (p_x - p_x_old) (p_y- p_y_old)];
    B = [p_x_mid^2 + p_y_mid^2; p_x^2 + p_y^2] - [p_x_old^2 + p_y_old^2; p_x_old^2 + p_y_old^2];
    Pc = inv(A)*B;
    Ox = Pc(1);
    Oy = Pc(2);
    O_cir = [Pc(1) Pc(2) p_z];
    
    %Radius of the circle
    r = sqrt((p_x_old - Ox)^2 + (p_y_old -Oy)^2);
    
    %Boundary angles
    a1 = atan2(p_y_old - Oy , p_x_old - Ox);
    a3 = atan2(p_y - Oy , p_x - Ox);
    
    %Lenght arc
    q_max = r*abs(a3 - a1);
end
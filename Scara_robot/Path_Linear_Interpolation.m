function [q_max, my_alpha, my_beta, p_sign, p_old]= Path_Linear_Interpolation(handles)
%%
    % Old values
    p_x_old = str2double(get(handles.Pos_X,'String'));
    p_y_old = str2double(get(handles.Pos_Y,'String'));
    p_z_old = str2double(get(handles.Pos_Z,'String'));
    p_old = [p_x_old; p_y_old; p_z_old];
    % Desired values
    p_x = str2double(get(handles.Pos_X_Desire,'String'));
    p_y = str2double(get(handles.Pos_Y_Desire,'String'));
    p_z = str2double(get(handles.Pos_Z_Desire,'String'));

    % Calculate sign
       if p_x >= p_x_old
    x_sign =  1 ;
    else
    x_sign = -1 ;
       end
    
      if p_y >= p_y_old
    y_sign =  1 ;
    else
    y_sign = -1 ;
      end
      
                                 if p_z >= p_z_old
    z_sign =  1 ;
    else
    z_sign = -1 ;
      end
      
   p_sign = [x_sign; y_sign; z_sign];
%%
    % Calculate distance q max
    q_max = sqrt((p_x - p_x_old)^2+(p_y - p_y_old)^2+(p_z - p_z_old)^2);
    
%%
    % Calculate 3d vector parameters 
   if p_y - p_y_old == 0
        my_alpha=0;
    else
    my_alpha = atan((p_y - p_y_old)/(p_x-p_x_old));
    end
    
    if (p_z - p_z_old) >= 0
    my_beta = atan(sqrt((p_x-p_x_old)^2+(p_y-p_y_old)^2)/(p_z - p_z_old));
    else
        my_beta = atan(sqrt((p_x-p_x_old)^2+(p_y-p_y_old)^2)/(p_z - p_z_old))+pi;
    end
end
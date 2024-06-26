function []=Path_Linear_Interpolation(handles,a,alpha,d,theta,opacity)
%%
    % Old values
    p_x_old = str2double(get(handles.Pos_X,'String'));
    p_y_old = str2double(get(handles.Pos_Y,'String'));
    p_z_old = str2double(get(handles.Pos_Z,'String'));
    p_old = [p_x_old; p_y_old; p_z_old];
    a_max = str2double(get(handles.a_max_value,'String'));
    v_max = str2double(get(handles.v_max_value,'String'));
    % Desired values
    p_x = str2double(get(handles.Pos_X_Desire,'String'));
    p_y = str2double(get(handles.Pos_Y_Desire,'String'));
    p_z = str2double(get(handles.Pos_Z_Desire,'String'));
    p_yaw = str2double(get(handles.Yaw_Desire,'String'))*pi/180;
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
    handles.q_max_value.String  = num2str(round(q_max,3));
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
%% Declare variable
    q2dot =[];
    qdot = [];
    q = [];

    theta1_ = [];
    theta1_dot= [];
    theta1_2dot= [];

    theta2_ = [];
    theta2_dot= [];
    theta2_2dot= [];

    theta4_ = [];
    theta4_dot= [];
    theta4_2dot= [];

    d3_ = [];
    d3_dot = [];
    d3_2dot = [];

    % define some axes
    Config_axes(handles);
    if q_max ~= 0
%% S curve Trajectory 
         if (handles.S_curve_select.Value == true)
     if (v_max >= sqrt(q_max*a_max/2))
     v_max = sqrt(q_max*a_max/2);
     end
                t1 = v_max/a_max;
                t2 = 2*t1;
                t3 = q_max/v_max;
                t4 = t3 + t1;
                te = t3 + t2;
                jerk = a_max/t1;
                N = 50;
                t = linspace(0,te,N);
                for i = 1:length(t)
                    if t(i) <= t1
                        q(i)     = jerk*t(i)^3/6;
                        qdot(i)  = jerk*t(i)^2/2;
                        q2dot(i) = jerk*t(i);
                    elseif t(i) <= t2
                        q(i)     = jerk*t1^3/6 + jerk*t1^2/2*(t(i)-t1) + a_max*(t(i)-t1)^2/2 - jerk*(t(i)-t1)^3/6;
                        qdot(i)  = jerk*t1^2/2 + a_max*(t(i)-t1) - jerk*(t(i)-t1)^2/2;
                        q2dot(i) = a_max - jerk*(t(i)-t1);
                    elseif t(i) <= t3       
                        q(i)     = a_max*t1^2 + v_max*(t(i)-t2);
                        qdot(i)  = v_max;
                        q2dot(i) = 0;
                    elseif t(i) <= t4
                        q(i)     = a_max*t1^2 + v_max*(t3-t2) + v_max*(t(i)-t3) - jerk*(t(i)-t3)^3/6;
                        qdot(i)  = v_max - jerk*(t(i)-t3)^2/2;
                        q2dot(i) = -jerk*(t(i)-t3);
                    elseif t(i) <= te
                        q(i)     = q_max - jerk*(te - t(i))^3/6;
                        qdot(i)  = v_max - jerk*(t4-t3)^2/2 - a_max*(t(i)-t4) + jerk*(t(i)-t4)^2/2;
                        q2dot(i) = -a_max + jerk*(t(i)-t4);
                    end     
 
                         % Calculate and plot q_x, q_y, q_z
                        q_x  = p_old(1) + p_sign(1) * q *  sin(my_beta) * cos(my_alpha); % my_alpha is always less than pi/2
                        q_y  = p_old(2) + p_sign(2)* q * sin(my_beta) * sin(abs(my_alpha));
                        q_z  = p_old(3) + p_sign(3) * q *  abs( cos(my_beta));

%                         % Calculate and plot q_x_dot, q_y_dot, q_z_dot
%                         q_x_dot  = p_sign(1)* qdot * sin(my_beta) * cos(my_alpha);
%                         q_y_dot  = p_sign(2) * qdot * sin(my_beta) * sin(abs(my_alpha));
%                         q_z_dot  = p_sign(3) * qdot * abs( cos(my_beta));
% 
%                         % Calculate and plot q_x_2dot, q_y_2dot, q_z_2dot
%                         q_x_2dot  = p_sign(1) * q2dot *  sin(my_beta) * cos(my_alpha);
%                         q_y_2dot  = p_sign(2) * q2dot * sin(my_beta) * sin(abs(my_alpha));
%                         q_z_2dot  = p_sign(3) * q2dot * abs( cos(my_beta));
                    
                    [T_sub, Infor_sub] = Inverse_Kinematics(a,alpha,d,theta,p_yaw,q_x(end),q_y(end),q_z(end),handles,opacity);
                    plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
                    if Infor_sub(1)
                        disp('Have the parameters exceed the specified value');
                    end
                    %Caculate derivative parameters
                    theta1_ = [theta1_;rad2deg(Infor_sub(2))];
                    theta2_ = [theta2_;rad2deg(Infor_sub(3))];
                    theta4_ = [theta4_;rad2deg(Infor_sub(5))];
                    d3_ = [d3_;Infor_sub(4)];
                    nop_dot =[theta1_;theta2_;theta4_;d3_];

                    if i>1
                        theta1_dot = [theta1_dot; (theta1_(i)-theta1_(i-1))/te*N];
                        theta2_dot = [theta2_dot; (theta2_(i)-theta2_(i-1))/te*N];
                        theta4_dot = [theta4_dot; (theta4_(i)-theta4_(i-1))/te*N];
                        d3_dot     = [d3_dot    ; (d3_(i)-d3_(i-1))/te*N];
                        one_dot = [theta1_dot; theta2_dot; theta4_dot; d3_dot];
                    else
                        one_dot = [0; 0; 0; 0];
                    end

                    if(i>2)
                        theta1_2dot = [theta1_2dot; (theta1_dot(i-1)-theta1_dot(i-2))/te*N];
                        theta2_2dot = [theta2_2dot; (theta2_dot(i-1)-theta2_dot(i-2))/te*N];
                        theta4_2dot = [theta4_2dot; (theta4_dot(i-1)-theta4_dot(i-2))/te*N];
                        d3_2dot     = [d3_2dot    ; (d3_dot(i-1)-d3_dot(i-2))/te*N];
                        two_dot = [theta1_2dot;theta2_2dot;theta4_2dot;d3_2dot];
                    else
                        two_dot = [0; 0; 0; 0];
                    end
                    pause(0.01);
                    plot(handles.q_graph,t(1:i),q,'linewidth',2);
                    grid(handles.q_graph,'on'); 
                    plot(handles.q_dot_graph,t(1:i),qdot,'linewidth',2);
                    grid(handles.q_dot_graph,'on'); 
                    plot(handles.q_2dot_graph,t(1:i),q2dot,'linewidth',2);
                    grid(handles.q_2dot_graph,'on'); 

                    plot(handles.q_x,t(1:i),q_x,'linewidth',2);
                    grid(handles.q_x,'on'); 
                    plot(handles.q_y,t(1:i),q_y,'linewidth',2);
                    grid(handles.q_y,'on'); 
                    plot(handles.q_z,t(1:i),q_z,'linewidth',2);
                    grid(handles.q_z,'on'); 

                    plot(handles.theta1_graph,t(1:i),theta1_,'linewidth',2);
                    plot(handles.theta2_graph,t(1:i),theta2_,'linewidth',2);
                    plot(handles.theta4_graph,t(1:i),theta4_,'linewidth',2);
                    plot(handles.d3_graph,t(1:i),d3_,'linewidth',2);

                    plot(handles.theta1_dot_graph,t(1:i-1),theta1_dot,'linewidth',2);
                    plot(handles.theta2_dot_graph,t(1:i-1),theta2_dot,'linewidth',2);
                    plot(handles.theta4_dot_graph,t(1:i-1),theta4_dot,'linewidth',2);
                    plot(handles.d3_dot_graph,t(1:i-1),d3_dot,'linewidth',2);

                    plot(handles.theta1_2dot_graph,t(1:i-2),theta1_2dot,'linewidth',2);
                    plot(handles.theta2_2dot_graph,t(1:i-2),theta2_2dot,'linewidth',2);
                    plot(handles.theta4_2dot_graph,t(1:i-2),theta4_2dot,'linewidth',2);
                    plot(handles.d3_2dot_graph,t(1:i-2),d3_2dot,'linewidth',2);

                    handles.Pos_X.String = num2str(round(T_sub(1,4,4),3));
                    handles.Pos_Y.String = num2str(round(T_sub(2,4,4),3));
                    handles.Pos_Z.String = num2str(round(T_sub(3,4,4),3));
                    handles.Yaw_value.String   = num2str(round(atan2(T_sub(2,1,4),T_sub(1,1,4))*180/pi,3));
                    Draw_robot(a,alpha,d,theta,handles,opacity,T_sub);
                    plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
                end
                  Run_Simulink(t,theta1_,theta2_, d3_, theta4_); 
         end
%% Linear Trapezoid Trajectory   
      if (handles.Trapezoidal_select.Value == true)
            if (v_max >= sqrt(q_max*a_max))
                 v_max = sqrt(q_max*a_max);
            end
            %Calulate profile
            tb = v_max/a_max;
                tm = tb + (q_max - 2* 1/2*a_max*tb^2)/v_max;
                te = tb + tm;
                N = 50;
                t = linspace(0,te,N);
                for i = 1:length(t)
                    if t(i) <= tb
                        q(i)     = 1/2*a_max*t(i)^2;
                        qdot(i)  = a_max*t(i);
                        q2dot(i) = a_max;
                    elseif t(i) <= tm
                        q(i)     = 1/2*a_max*tb^2 + v_max*(t(i)-tb);
                        qdot(i)  = v_max;
                        q2dot(i) = 0;
                    elseif t(i) <= te
                        q(i) = ( 1/2*a_max*tb^2 + v_max*(tm-tb) ) + v_max*(t(i)-tm) - 1/2*a_max*(t(i)-tm)^2;
                        qdot(i) = v_max -a_max*(t(i)-tm);
                        q2dot(i) = -a_max;
                    end          
                        % Calculate and plot q_x, q_y, q_z
                        q_x  = p_old(1) + p_sign(1) * q *  sin(my_beta) * cos(my_alpha); % my_alpha is always less than pi/2
                        q_y  = p_old(2) + p_sign(2)* q * sin(my_beta) * sin(abs(my_alpha));
                        q_z  = p_old(3) + p_sign(3) * q *  abs( cos(my_beta));

%                         % Calculate and plot q_x_dot, q_y_dot, q_z_dot
%                         q_x_dot  = p_sign(1)* qdot * sin(my_beta) * cos(my_alpha);
%                         q_y_dot  = p_sign(2) * qdot * sin(my_beta) * sin(abs(my_alpha));
%                         q_z_dot  = p_sign(3) * qdot * abs( cos(my_beta));
% 
%                         % Calculate and plot q_x_2dot, q_y_2dot, q_z_2dot
%                         q_x_2dot  = p_sign(1) * q2dot *  sin(my_beta) * cos(my_alpha);
%                         q_y_2dot  = p_sign(2) * q2dot * sin(my_beta) * sin(abs(my_alpha));
%                         q_z_2dot  = p_sign(3) * q2dot * abs( cos(my_beta));
                    
                    [T_sub, Infor_sub] = Inverse_Kinematics(a,alpha,d,theta,p_yaw,q_x(end),q_y(end),q_z(end),handles,opacity);
                    plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
                    if Infor_sub(1)
                        disp('Have the parameters exceed the specified value');
                    end
                    %Caculate derivative parameters
                    theta1_ = [theta1_;rad2deg(Infor_sub(2))];
                    theta2_ = [theta2_;rad2deg(Infor_sub(3))];
                    theta4_ = [theta4_;rad2deg(Infor_sub(5))];
                    d3_ = [d3_;Infor_sub(4)];
                    nop_dot =[theta1_;theta2_;theta4_;d3_];

                    if i>1
                        theta1_dot = [theta1_dot; (theta1_(i)-theta1_(i-1))/te*N];
                        theta2_dot = [theta2_dot; (theta2_(i)-theta2_(i-1))/te*N];
                        theta4_dot = [theta4_dot; (theta4_(i)-theta4_(i-1))/te*N];
                        d3_dot     = [d3_dot    ; (d3_(i)-d3_(i-1))/te*N];
                        one_dot = [theta1_dot; theta2_dot; theta4_dot; d3_dot];
                    else
                        one_dot = [0; 0; 0; 0];
                    end

                    if(i>2)
                        theta1_2dot = [theta1_2dot; (theta1_dot(i-1)-theta1_dot(i-2))/te*N];
                        theta2_2dot = [theta2_2dot; (theta2_dot(i-1)-theta2_dot(i-2))/te*N];
                        theta4_2dot = [theta4_2dot; (theta4_dot(i-1)-theta4_dot(i-2))/te*N];
                        d3_2dot     = [d3_2dot    ; (d3_dot(i-1)-d3_dot(i-2))/te*N];
                        two_dot = [theta1_2dot;theta2_2dot;theta4_2dot;d3_2dot];
                    else
                        two_dot = [0; 0; 0; 0];
                    end
                    pause(0.01);
                    plot(handles.q_graph,t(1:i),q,'linewidth',2);
                    grid(handles.q_graph,'on'); 
                    plot(handles.q_dot_graph,t(1:i),qdot,'linewidth',2);
                    grid(handles.q_dot_graph,'on'); 
                    plot(handles.q_2dot_graph,t(1:i),q2dot,'linewidth',2);
                    grid(handles.q_2dot_graph,'on'); 

                    plot(handles.q_x,t(1:i),q_x,'linewidth',2);
                    grid(handles.q_x,'on'); 
                    plot(handles.q_y,t(1:i),q_y,'linewidth',2);
                    grid(handles.q_y,'on'); 
                    plot(handles.q_z,t(1:i),q_z,'linewidth',2);
                    grid(handles.q_z,'on'); 

                    plot(handles.theta1_graph,t(1:i),theta1_,'linewidth',2);
                    plot(handles.theta2_graph,t(1:i),theta2_,'linewidth',2);
                    plot(handles.theta4_graph,t(1:i),theta4_,'linewidth',2);
                    plot(handles.d3_graph,t(1:i),d3_,'linewidth',2);

                    plot(handles.theta1_dot_graph,t(1:i-1),theta1_dot,'linewidth',2);
                    plot(handles.theta2_dot_graph,t(1:i-1),theta2_dot,'linewidth',2);
                    plot(handles.theta4_dot_graph,t(1:i-1),theta4_dot,'linewidth',2);
                    plot(handles.d3_dot_graph,t(1:i-1),d3_dot,'linewidth',2);

                    plot(handles.theta1_2dot_graph,t(1:i-2),theta1_2dot,'linewidth',2);
                    plot(handles.theta2_2dot_graph,t(1:i-2),theta2_2dot,'linewidth',2);
                    plot(handles.theta4_2dot_graph,t(1:i-2),theta4_2dot,'linewidth',2);
                    plot(handles.d3_2dot_graph,t(1:i-2),d3_2dot,'linewidth',2);

                    handles.Pos_X.String = num2str(round(T_sub(1,4,4),3));
                    handles.Pos_Y.String = num2str(round(T_sub(2,4,4),3));
                    handles.Pos_Z.String = num2str(round(T_sub(3,4,4),3));
                    handles.Yaw_value.String   = num2str(round(atan2(T_sub(2,1,4),T_sub(1,1,4))*180/pi,3));
                    Draw_robot(a,alpha,d,theta,handles,opacity,T_sub);
                    plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
                end
                Run_Simulink(t,theta1_,theta2_, d3_, theta4_);  
       end
    end
        hold on;
        msgbox('Path Linear Interpolation completed'); 
end
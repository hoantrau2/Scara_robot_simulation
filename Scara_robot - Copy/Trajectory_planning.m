function Trajectory_planning(handles,a,alpha,d,theta,opacity)
%%
    index_Trajectory = cellstr(get(handles.Trajectory_select, 'String'));
    Trajectory_type = index_Trajectory{get(handles.Trajectory_select, 'Value')}; 
    index_Path_planning = cellstr(get(handles.Path_Planning_select, 'String'));
    Path_planning_type = index_Path_planning{get(handles.Path_Planning_select, 'Value')};   
  
    if strcmp(Path_planning_type,'Linear_Interpolation')
        [q_max, my_alpha, my_beta, p_sign, p_old]= Path_Linear_Interpolation(handles);
            elseif strcmp(path_planning_type,'Circular_Interpolation_2D')
        [q_max, a1, a3, r, O_cir] = Path_Circular_Interpolation_3D(handles);
    elseif strcmp(path_planning_type,'Circular_Interpolation_3D')
        [q_max, a1_xy, a3_xy, a1_z, a3_z, O_cir,r]= Path_Circular_Interpolation_2D(handles);
    end
    
    a_max = str2double(get(handles.a_max_value,'String'));
    v_max = str2double(get(handles.v_max_value,'String'));
    handles.q_max_value.String  = num2str(round(q_max,3));
%% plot p, v, a
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
%% S curve

%% Linear Trapezoid Trajectory   
        if (strcmp(Trajectory_type,'LSPB'))
            if (v_max <= sqrt(q_max*a_max))
                tb = v_max/a_max;
                tm = tb + (q_max - 2* 1/2*a_max*tb^2)/v_max;
                te = tb + tm;
                N = 10;
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
%                     q0 =[q; qdot; q2dot];
                %Linear path planning
                    if strcmp(Path_planning_type,'Linear_Interpolation')
                        % Calculate and plot q_x, q_y, q_z
                        q_x  = p_old(1) + p_sign(1) * q *  sin(my_beta) * cos(my_alpha); % my_alpha is always less than pi/2
                        q_y  = p_old(2) + p_sign(2)* q * sin(my_beta) * sin(abs(my_alpha));
                        q_z  = p_old(3) + p_sign(3) * q *  abs( cos(my_beta));
%                         qq = [q_x;q_y;q_z];
                        % Calculate and plot q_x_dot, q_y_dot, q_z_dot
                        q_x_dot  = p_sign(1)* qdot * sin(my_beta) * cos(my_alpha);
                        q_y_dot  = p_sign(2) * qdot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_dot  = p_sign(3) * qdot * abs( cos(my_beta));
%                         qq_dot = [q_x_dot;q_y_dot;q_z_dot];

                        % Calculate and plot q_x_2dot, q_y_2dot, q_z_2dot
                        q_x_2dot  = p_sign(1) * q2dot *  sin(my_beta) * cos(my_alpha);
                        q_y_2dot  = p_sign(2) * q2dot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_2dot  = p_sign(3) * q2dot * abs( cos(my_beta));
%                         qq_2dot = [q_x_2dot;q_y_2dot;q_z_2dot];
                    end
                    
                    [T_sub, Infor_sub] = Inverse_Kinematics(a,alpha,d,theta,0,q_x(end),q_y(end),q_z(end),handles,opacity);
                    plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
                    if Infor_sub(1)
                        break
                    end
                    
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
%                     Plot(q0, qq, qq_dot, qq_2dot, T_sub, t(1:i), t(1:i-1), t(1:i-2), handles, nop_dot, one_dot, two_dot);
                    plot(handles.q_graph,t(1:i),q,'linewidth',2);
                    grid(handles.q_graph,'on'); 
                    plot(handles.q_dot_graph,t(1:i),qdot,'linewidth',2);
                    grid(handles.q_dot_graph,'on'); 
                    plot(handles.q_2dot_graph,t(1:i),q2dot,'linewidth',2);
                    grid(handles.q_2dot_graph,'on'); 

                    plot(handles.q_x,t(1:i),q_x,'linewidth',2);
                    grid(handles.q_x,'on'); 
                    plot(handles.v_x,t(1:i),q_x_dot,'linewidth',2);
                    grid(handles.v_x,'on'); 
                    plot(handles.a_x,t(1:i),q_x_2dot,'linewidth',2);
                    grid(handles.a_x,'on'); 

                    plot(handles.q_y,t(1:i),q_y,'linewidth',2);
                    grid(handles.q_y,'on'); 
                    plot(handles.v_y,t(1:i),q_y_dot,'linewidth',2);
                    grid(handles.v_y,'on'); 
                    plot(handles.a_y,t(1:i),q_y_2dot,'linewidth',2);
                    grid(handles.a_y,'on'); 

                    plot(handles.q_z,t(1:i),q_z,'linewidth',2);
                    grid(handles.q_z,'on'); 
                    plot(handles.v_z,t(1:i),q_z_dot,'linewidth',2);
                    grid(handles.v_z,'on'); 
                    plot(handles.a_z,t(1:i),q_z_2dot,'linewidth',2);
                    grid(handles.a_z,'on'); 

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
            else
                v_max_need = sqrt(q_max*a_max);
                set(handles.v_max_value,'string',num2str(v_max_need-0.0005));
                Trajectory(handles,a,alpha,d,theta)   
            end
        end
    end 
        hold on;
        msgbox('Trajectory planning compeleted');
    
end
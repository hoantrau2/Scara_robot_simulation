function Trajectory_planning(handles,a,alpha,d,theta,opacity)
%%
    index_Trajectory = cellstr(get(handles.Trajectory_select, 'String'));
    Trajectory_type = index_Trajectory{get(handles.Trajectory_select, 'Value')}; 
    index_Path_planning = cellstr(get(handles.Path_Planning_select, 'String'));
    Path_planning_type = index_Path_planning{get(handles.Path_Planning_select, 'Value')};   
  
    if strcmp(Path_planning_type,'Linear Interpolation')
        [q_max, my_alpha, my_beta, p_sign, p_old]= Path_Linear_Interpolation(handles);
    end
    
    a_max = str2double(get(handles.a_max_value,'String'));
    v_max = str2double(get(handles.v_max_value,'String'));
    handles.q_max_value.String  = num2str(round(q_max,3));
%% plot p, v, a
    q2dot =[];
    qdot = [];
    q = [];
    time  = [] ;

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
        if (strcmp(Trajectory_type,'LSBP'))
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
                    time  = [time ; t(i)];
                %Linear path planning
                    if strcmp(Path_planning_type,'Linear Interpolation')
                        % Calculate and plot q_x, q_y, q_z
                        q_x  = p_old(1) + p_sign(1) * q *  sin(my_beta) * cos(my_alpha); % my_alpha is always less than pi/2
                        q_y  = p_old(2) + p_sign(2)* q * sin(my_beta) * sin(abs(my_alpha));
                        q_z  = p_old(3) + p_sign(3) * q *  abs( cos(my_beta));

                        % Calculate and plot q_x_dot, q_y_dot, q_z_dot
                        q_x_dot  = p_sign(1)* qdot * sin(my_beta) * cos(my_alpha);
                        q_y_dot  = p_sign(2) * qdot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_dot  = p_sign(3) * qdot * abs( cos(my_beta));


                        % Calculate and plot q_x_2dot, q_y_2dot, q_z_2dot
                        q_x_2dot  = p_sign(1) * q2dot *  sin(my_beta) * cos(my_alpha);
                        q_y_2dot  = p_sign(2) * q2dot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_2dot  = p_sign(3) * q2dot * abs( cos(my_beta));


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

                    if i>1
                        theta1_dot = [theta1_dot; (theta1_(i)-theta1_(i-1))/te*N];
                        theta2_dot = [theta2_dot; (theta2_(i)-theta2_(i-1))/te*N];
                        theta4_dot = [theta4_dot; (theta4_(i)-theta4_(i-1))/te*N];
                        d3_dot     = [d3_dot    ; (d3_(i)-d3_(i-1))/te*N];
                    end

                    if(i>2)
                        theta1_2dot = [theta1_2dot; (theta1_dot(i-1)-theta1_dot(i-2))/te*N];
                        theta2_2dot = [theta2_2dot; (theta2_dot(i-1)-theta2_dot(i-2))/te*N];
                        theta4_2dot = [theta4_2dot; (theta4_dot(i-1)-theta4_dot(i-2))/te*N];
                        d3_2dot     = [d3_2dot    ; (d3_dot(i-1)-d3_dot(i-2))/te*N];
                    end

                    pause(0.01);
    %%
    % plot 
                    plot(handles.q_graph,time,q,'linewidth',2);
                    grid(handles.q_graph,'on'); 
                    plot(handles.q_dot_graph,time,qdot,'linewidth',2);
                    grid(handles.q_dot_graph,'on'); 
                    plot(handles.q_2dot_graph,time,q2dot,'linewidth',2);
                    grid(handles.q_2dot_graph,'on'); 

                    plot(handles.q_x,time,q_x,'linewidth',2);
                    grid(handles.q_x,'on'); 
                    plot(handles.v_x,time,q_x_dot,'linewidth',2);
                    grid(handles.v_x,'on'); 
                    plot(handles.a_x,time,q_x_2dot,'linewidth',2);
                    grid(handles.a_x,'on'); 

                    plot(handles.q_y,time,q_y,'linewidth',2);
                    grid(handles.q_y,'on'); 
                    plot(handles.v_y,time,q_y_dot,'linewidth',2);
                    grid(handles.v_y,'on'); 
                    plot(handles.a_y,time,q_y_2dot,'linewidth',2);
                    grid(handles.a_y,'on'); 

                    plot(handles.q_z,time,q_z,'linewidth',2);
                    grid(handles.q_z,'on'); 
                    plot(handles.v_z,time,q_z_dot,'linewidth',2);
                    grid(handles.v_z,'on'); 
                    plot(handles.a_z,time,q_z_2dot,'linewidth',2);
                    grid(handles.a_z,'on'); 

                    plot(handles.theta1_graph,time,theta1_,'linewidth',2);
                    plot(handles.theta2_graph,time,theta2_,'linewidth',2);
                    plot(handles.theta4_graph,time,theta4_,'linewidth',2);
                    plot(handles.d3_graph,time,d3_,'linewidth',2);

                    plot(handles.theta1_dot_graph,time(1:end-1),theta1_dot,'linewidth',2);
                    plot(handles.theta2_dot_graph,time(1:end-1),theta2_dot,'linewidth',2);
                    plot(handles.theta4_dot_graph,time(1:end-1),theta4_dot,'linewidth',2);
                    plot(handles.d3_dot_graph,time(1:end-1),d3_dot,'linewidth',2);

                    plot(handles.theta1_2dot_graph,time(1:end-2),theta1_2dot,'linewidth',2);
                    plot(handles.theta2_2dot_graph,time(1:end-2),theta2_2dot,'linewidth',2);
                    plot(handles.theta4_2dot_graph,time(1:end-2),theta4_2dot,'linewidth',2);
                    plot(handles.d3_2dot_graph,time(1:end-2),d3_2dot,'linewidth',2);

%                     T_sub = Transformation_matrix(a,alpha,d,theta,handles,opacity);
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
function Trajectory_planning(handles,a,alpha,d,theta)
%%
    contents_1 = cellstr(get(handles.Path_Planning_select, 'String'));
    path_planning_type = contents_1{get(handles.Path_Planning_select, 'Value')};   
    contents_2 = cellstr(get(handles.Trajectory_select, 'String'));
    Trajectory_type = contents_2{get(handles.Trajectory_select, 'Value')};   
    
    if strcmp(path_planning_type,'Linear Interpolation')
        [q_max,my_alpha,my_beta,x_sign,y_sign,z_sign,p_x_old,p_y_old,p_z_old]= PathPlanning(handles);
    elseif strcmp(path_planning_type,'2D Circular Interpolation')
        [q_max, a1, a3, r, O_cir] = PathPlanning3(handles);
    elseif strcmp(path_planning_type,'3D Circular Interpolation')
        [q_max, a1_xy, a3_xy, a1_z, a3_z, O_cir,r]= PathPlanning2(handles);
    end
    
    v_max = str2double(get(handles.v_max_val,'String'));
    a_max = str2double(get(handles.a_max_val,'String'));
    handles.q_max_val.String  = num2str(round(q_max,2));
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
    Define_axes(handles);

    if q_max ~= 0
%% S curve
        if (strcmp(Trajectory_type,'S curve'))
            if (v_max <= sqrt(q_max*a_max/2))
                t1 = v_max/a_max;
                t2 = 2*t1;
                t3 = q_max/v_max;
                t4 = t3 + t1;
                tf = t3 + t2;
                j = a_max/t1;
                N = 100;
                t = linspace(0,tf,N);
                for i = 1:length(t)
                    if t(i) <= t1
                        q(i)     = j*t(i)^3/6;
                        qdot(i)  = j*t(i)^2/2;
                        q2dot(i) = j*t(i);
                    elseif t(i) <= t2
                        q(i)     = j*t1^3/6 + j*t1^2/2*(t(i)-t1) + a_max*(t(i)-t1)^2/2 - j*(t(i)-t1)^3/6;
                        qdot(i)  = j*t1^2/2 + a_max*(t(i)-t1) - j*(t(i)-t1)^2/2;
                        q2dot(i) = a_max - j*(t(i)-t1);
                    elseif t(i) <= t3
                        q(i)     = a_max*t1^2 + v_max*(t(i)-t2);
                        qdot(i)  = v_max;
                        q2dot(i) = 0;
                    elseif t(i) <= t4
                        q(i)     = a_max*t1^2 + v_max*(t3-t2) + v_max*(t(i)-t3) - j*(t(i)-t3)^3/6;
                        qdot(i)  = v_max - j*(t(i)-t3)^2/2;
                        q2dot(i) = -j*(t(i)-t3);
                    elseif t(i) <= tf
                        q(i)     = q_max - j*(tf - t(i))^3/6;
                        qdot(i)  = v_max - j*(t4-t3)^2/2 - a_max*(t(i)-t4) + j*(t(i)-t4)^2/2;
                        q2dot(i) = -a_max + j*(t(i)-t4);
                    end             
                    time  = [time ; t(i)];
    %---------------------------------------------------------------------------------------------------------
                %Linear path planning
                    if strcmp(path_planning_type,'Linear Interpolation')
                        % Calc and plot q_x, q_y, q_z
                        q_x  = p_x_old + x_sign * q * sin(my_beta) * cos(my_alpha);
                        q_y  = p_y_old + y_sign * q * sin(my_beta) * sin(abs(my_alpha));
                        q_z  = p_z_old + z_sign * q * abs( cos(my_beta));

                        % Calc and plot q_x_dot, q_y_dot, q_z_dot
                        q_x_dot  = x_sign * qdot * sin(my_beta) * cos(my_alpha);
                        q_y_dot  = y_sign * qdot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_dot  = z_sign * qdot * abs( cos(my_beta));

                        % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
                        q_x_2dot  = x_sign * q2dot * sin(my_beta)* cos(my_alpha) ;
                        q_y_2dot  = y_sign * q2dot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_2dot  = z_sign * q2dot * abs( cos(my_beta));

                 %2D circular path planing
                    elseif strcmp(path_planning_type,'2D Circular Interpolation')
                        % Calc and plot q_x, q_y, q_z
                        th = q/q_max*(a3 - a1) + a1;
                        q_x = O_cir(1) + r*cos(th);
                        q_y = O_cir(2) + r*sin(th);
                        q_z = O_cir(3) + r*sin(th)*0;

                        % Calc and plot q_x_dot, q_y_dot, q_z_dot
                        th_dot = qdot/q_max*(a3 - a1);
                        q_x_dot = -r.*th_dot.*sin(th);
                        q_y_dot =  r.*th_dot.*cos(th);
                        q_z_dot = (th_dot.*r.*cos(th))*0;

                        % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
                        th_2dot = q2dot/q_max*(a3 - a1);
                        q_x_2dot = r.*(th_2dot.*cos(th) - th_2dot.^2.*sin(th));
                        q_y_2dot = (O_cir(1) + r*cos(th));
                        q_z_2dot = (th_dot.*r.*cos(th))*0;

                 %3D circular path planing
                    elseif strcmp(path_planning_type,'3D Circular Interpolation')
                        % Calc and plot q_x, q_y, q_z
                        th   = q/q_max*(a3_xy - a1_xy) + a1_xy;
                        th_1 = q/q_max*(a3_z - a1_z) + a1_z;
                        q_x = O_cir(1) + r.*cos(th).*sin(th_1);
                        q_y = O_cir(2) + r.*sin(th).*sin(th_1);
                        q_z = O_cir(3) + r.*cos(th_1);                 

                        % Calc and plot q_x_dot, q_y_dot, q_z_dot
                        th_dot = qdot/q_max*(a3_xy - a1_xy);
                        th_1_dot = qdot/q_max*(a3_z - a1_z);
                        q_x_dot = r.*(-th_dot.*sin(th).*sin(th_1) + th_1_dot.*cos(th).*cos(th_1));
                        q_y_dot = r.*(th_dot.*sin(th).*sin(th_1) + th_1_dot.*cos(th).*cos(th_1));
                        q_z_dot = r.*th_1_dot.*cos(th_1);

                        % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
                        th_2dot = q2dot/q_max*(a3_xy - a1_xy);
                        th_1_2dot = q2dot/q_max*(a3_z - a1_z);
                        q_x_2dot = r.*(-th_dot.*(th_dot.*cos(th).*sin(th_1) + th_1_dot.*sin(th).*cos(th_1)) - th_2dot.*sin(th).*sin(th_1)...
                            - th_1_dot.*(th_dot.*sin(th).*cos(th_1) + th_1_dot.*cos(th).*sin(th_1)) + th_1_2dot.*cos(th).*cos(th_1));
                        q_y_2dot = r.*(th_dot.*(th_dot.*cos(th).*sin(th_1) + th_1_dot.*sin(th).*cos(th_1)) + th_2dot.*sin(th).*sin(th_1)...
                            - th_1_dot.*(th_dot.*sin(th).*cos(th_1) + th_1_dot.*cos(th).*sin(th_1)) + th_1_2dot.*cos(th).*cos(th_1));
                        q_z_2dot = r.*(th_1_2dot.*cos(th_1) - th_1_dot.^2.*sin(th_1)); 
                    end

                    [break_signal,theta1_new,theta2_new,theta4_new,d3_new] = Inverse_kinematics(handles,a,alpha,d,theta,q_x(end),q_y(end),q_z(end),0);
                    if break_signal
                        break
                    end

                    theta1_ = [theta1_;rad2deg(theta1_new)];
                    theta2_ = [theta2_;rad2deg(theta2_new)];
                    theta4_ = [theta4_;rad2deg(theta4_new)];
                    d3_ = [d3_;d3_new];

                    if i>1
                        theta1_dot = [theta1_dot; (theta1_(i)-theta1_(i-1))/tf*N];
                        theta2_dot = [theta2_dot; (theta2_(i)-theta2_(i-1))/tf*N];
                        theta4_dot = [theta4_dot; (theta4_(i)-theta4_(i-1))/tf*N];
                        d3_dot     = [d3_dot    ; (d3_(i)-d3_(i-1))/tf*N];
                    end

                    if(i>2)
                        theta1_2dot = [theta1_2dot; (theta1_dot(i-1)-theta1_dot(i-2))/tf*N];
                        theta2_2dot = [theta2_2dot; (theta2_dot(i-1)-theta2_dot(i-2))/tf*N];
                        theta4_2dot = [theta4_2dot; (theta4_dot(i-1)-theta4_dot(i-2))/tf*N];
                        d3_2dot     = [d3_2dot    ; (d3_dot(i-1)-d3_dot(i-2))/tf*N];
                    end

                    pause(0.01);
    %%
    % plot 
                    plot(handles.ax_q,time,q,'linewidth',2);
                    grid(handles.ax_q,'on'); 
                    plot(handles.ax_qdot,time,qdot,'linewidth',2);
                    grid(handles.ax_qdot,'on'); 
                    plot(handles.ax_q2dot,time,q2dot,'linewidth',2);
                    grid(handles.ax_q2dot,'on'); 

                    plot(handles.ax_q_x,time,q_x,'linewidth',2);
                    grid(handles.ax_q_x,'on'); 
                    plot(handles.ax_q_xdot,time,q_x_dot,'linewidth',2);
                    grid(handles.ax_q_xdot,'on'); 
                    plot(handles.ax_q_x2dot,time,q_x_2dot,'linewidth',2);
                    grid(handles.ax_q_x2dot,'on'); 

                    plot(handles.ax_q_y,time,q_y,'linewidth',2);
                    grid(handles.ax_q_y,'on'); 
                    plot(handles.ax_q_ydot,time,q_y_dot,'linewidth',2);
                    grid(handles.ax_q_ydot,'on'); 
                    plot(handles.ax_q_y2dot,time,q_y_2dot,'linewidth',2);
                    grid(handles.ax_q_y2dot,'on'); 

                    plot(handles.ax_q_z,time,q_z,'linewidth',2);
                    grid(handles.ax_q_z,'on'); 
                    plot(handles.ax_q_zdot,time,q_z_dot,'linewidth',2);
                    grid(handles.ax_q_zdot,'on'); 
                    plot(handles.ax_q_z2dot,time,q_z_2dot,'linewidth',2);
                    grid(handles.ax_q_z2dot,'on'); 

                    plot(handles.ax_theta1,time,theta1_,'linewidth',2);
                    plot(handles.ax_theta2,time,theta2_,'linewidth',2);
                    plot(handles.ax_theta4,time,theta4_,'linewidth',2);
                    plot(handles.ax_d3,time,d3_,'linewidth',2);

                    plot(handles.ax_theta1_dot,time(1:end-1),theta1_dot,'linewidth',2);
                    plot(handles.ax_theta2_dot,time(1:end-1),theta2_dot,'linewidth',2);
                    plot(handles.ax_theta4_dot,time(1:end-1),theta4_dot,'linewidth',2);
                    plot(handles.ax_d3_dot,time(1:end-1),d3_dot,'linewidth',2);

                    plot(handles.ax_theta1_2dot,time(1:end-2),theta1_2dot,'linewidth',2);
                    plot(handles.ax_theta2_2dot,time(1:end-2),theta2_2dot,'linewidth',2);
                    plot(handles.ax_theta4_2dot,time(1:end-2),theta4_2dot,'linewidth',2);
                    plot(handles.ax_d3_2dot,time(1:end-2),d3_2dot,'linewidth',2);

                    plot_frame_arm(a,alpha,d,theta,handles)
                    plot3(handles.axes1,q_x,q_y,q_z,'b','linewidth',2);
                end
            else
                v_max_need = sqrt(q_max*a_max/2);
                set(handles.v_max_val,'string',num2str(v_max_need-0.0005));
                Trajectory(handles,a,alpha,d,theta)   
            end
        end
%% LSBP Trajectory   
        if (strcmp(Trajectory_type,'LSBP'))
            if (v_max <= sqrt(q_max*a_max))
                tb = v_max/a_max;
                tm = tb + (q_max - v_max*tb)/v_max;
                te = tb + tm;
                N = 100;
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
                        q(i) = v_max*tm  - 1/2*a_max*(t(i)-tm-tb)^2;
                        qdot(i) = -a_max*(t(i)-te);
                        q2dot(i) = -a_max;
                    end
                    time  = [time ; t(i)];
                %Linear path planning
                    if strcmp(path_planning_type,'Linear Interpolation')
                        % Calc and plot q_x, q_y, q_z
                        q_x  = p_x_old + x_sign * q * sin(my_beta) * cos(my_alpha);
                        q_y  = p_y_old + y_sign * q * sin(my_beta) * sin(abs(my_alpha));
                        q_z  = p_z_old + z_sign * q * abs( cos(my_beta));

                        % Calc and plot q_x_dot, q_y_dot, q_z_dot
                        q_x_dot  = x_sign * qdot * sin(my_beta) * cos(my_alpha);
                        q_y_dot  = y_sign * qdot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_dot  = z_sign * qdot * abs( cos(my_beta));

                        % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
                        q_x_2dot  = x_sign * q2dot * sin(my_beta)* cos(my_alpha) ;
                        q_y_2dot  = y_sign * q2dot * sin(my_beta) * sin(abs(my_alpha));
                        q_z_2dot  = z_sign * q2dot * abs( cos(my_beta));

                 %2D circular path planing
                    elseif strcmp(path_planning_type,'2D Circular Interpolation')
                        % Calc and plot q_x, q_y, q_z
                        th = q/q_max*(a3 - a1) + a1;
                        q_x = O_cir(1) + r*cos(th);
                        q_y = O_cir(2) + r*sin(th);
                        q_z = O_cir(3) + r*sin(th)*0;

                        % Calc and plot q_x_dot, q_y_dot, q_z_dot
                        th_dot = qdot/q_max*(a3 - a1);
                        q_x_dot = -r.*th_dot.*sin(th);
                        q_y_dot =  r.*th_dot.*cos(th);
                        q_z_dot = (th_dot.*r.*cos(th))*0;

                        % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
                        th_2dot = q2dot/q_max*(a3 - a1);
                        q_x_2dot = r.*(th_2dot.*cos(th) - th_2dot.^2.*sin(th));
                        q_y_2dot = (O_cir(1) + r*cos(th));
                        q_z_2dot = (th_dot.*r.*cos(th))*0;

                 %3D circular path planing
                    elseif strcmp(path_planning_type,'3D Circular Interpolation')
                        % Calc and plot q_x, q_y, q_z
                        th   = q/q_max*(a3_xy - a1_xy) + a1_xy;
                        th_1 = q/q_max*(a3_z - a1_z) + a1_z;
                        q_x = O_cir(1) + r.*cos(th).*sin(th_1);
                        q_y = O_cir(2) + r.*sin(th).*sin(th_1);
                        q_z = O_cir(3) + r.*cos(th_1);                 

                        % Calc and plot q_x_dot, q_y_dot, q_z_dot
                        th_dot = qdot/q_max*(a3_xy - a1_xy);
                        th_1_dot = qdot/q_max*(a3_z - a1_z);
                        q_x_dot = r.*(-th_dot.*sin(th).*sin(th_1) + th_1_dot.*cos(th).*cos(th_1));
                        q_y_dot = r.*(th_dot.*sin(th).*sin(th_1) + th_1_dot.*cos(th).*cos(th_1));
                        q_z_dot = r.*th_1_dot.*cos(th_1);

                        % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
                        th_2dot = q2dot/q_max*(a3_xy - a1_xy);
                        th_1_2dot = q2dot/q_max*(a3_z - a1_z);
                        q_x_2dot = r.*(-th_dot.*(th_dot.*cos(th).*sin(th_1) + th_1_dot.*sin(th).*cos(th_1)) - th_2dot.*sin(th).*sin(th_1)...
                            - th_1_dot.*(th_dot.*sin(th).*cos(th_1) + th_1_dot.*cos(th).*sin(th_1)) + th_1_2dot.*cos(th).*cos(th_1));
                        q_y_2dot = r.*(th_dot.*(th_dot.*cos(th).*sin(th_1) + th_1_dot.*sin(th).*cos(th_1)) + th_2dot.*sin(th).*sin(th_1)...
                            - th_1_dot.*(th_dot.*sin(th).*cos(th_1) + th_1_dot.*cos(th).*sin(th_1)) + th_1_2dot.*cos(th).*cos(th_1));
                        q_z_2dot = r.*(th_1_2dot.*cos(th_1) - th_1_dot.^2.*sin(th_1)); 
                    end

                    [break_signal,theta1_new,theta2_new,theta4_new,d3_new] = Inverse_kinematics(handles,a,alpha,d,theta,q_x(end),q_y(end),q_z(end),0);
                    if break_signal
                        break
                    end

                    theta1_ = [theta1_;rad2deg(theta1_new)];
                    theta2_ = [theta2_;rad2deg(theta2_new)];
                    theta4_ = [theta4_;rad2deg(theta4_new)];
                    d3_ = [d3_;d3_new];

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
                    plot(handles.ax_q,time,q,'linewidth',2);
                    grid(handles.ax_q,'on'); 
                    plot(handles.ax_qdot,time,qdot,'linewidth',2);
                    grid(handles.ax_qdot,'on'); 
                    plot(handles.ax_q2dot,time,q2dot,'linewidth',2);
                    grid(handles.ax_q2dot,'on'); 

                    plot(handles.ax_q_x,time,q_x,'linewidth',2);
                    grid(handles.ax_q_x,'on'); 
                    plot(handles.ax_q_xdot,time,q_x_dot,'linewidth',2);
                    grid(handles.ax_q_xdot,'on'); 
                    plot(handles.ax_q_x2dot,time,q_x_2dot,'linewidth',2);
                    grid(handles.ax_q_x2dot,'on'); 

                    plot(handles.ax_q_y,time,q_y,'linewidth',2);
                    grid(handles.ax_q_y,'on'); 
                    plot(handles.ax_q_ydot,time,q_y_dot,'linewidth',2);
                    grid(handles.ax_q_ydot,'on'); 
                    plot(handles.ax_q_y2dot,time,q_y_2dot,'linewidth',2);
                    grid(handles.ax_q_y2dot,'on'); 

                    plot(handles.ax_q_z,time,q_z,'linewidth',2);
                    grid(handles.ax_q_z,'on'); 
                    plot(handles.ax_q_zdot,time,q_z_dot,'linewidth',2);
                    grid(handles.ax_q_zdot,'on'); 
                    plot(handles.ax_q_z2dot,time,q_z_2dot,'linewidth',2);
                    grid(handles.ax_q_z2dot,'on'); 

                    plot(handles.ax_theta1,time,theta1_,'linewidth',2);
                    plot(handles.ax_theta2,time,theta2_,'linewidth',2);
                    plot(handles.ax_theta4,time,theta4_,'linewidth',2);
                    plot(handles.ax_d3,time,d3_,'linewidth',2);

                    plot(handles.ax_theta1_dot,time(1:end-1),theta1_dot,'linewidth',2);
                    plot(handles.ax_theta2_dot,time(1:end-1),theta2_dot,'linewidth',2);
                    plot(handles.ax_theta4_dot,time(1:end-1),theta4_dot,'linewidth',2);
                    plot(handles.ax_d3_dot,time(1:end-1),d3_dot,'linewidth',2);

                    plot(handles.ax_theta1_2dot,time(1:end-2),theta1_2dot,'linewidth',2);
                    plot(handles.ax_theta2_2dot,time(1:end-2),theta2_2dot,'linewidth',2);
                    plot(handles.ax_theta4_2dot,time(1:end-2),theta4_2dot,'linewidth',2);
                    plot(handles.ax_d3_2dot,time(1:end-2),d3_2dot,'linewidth',2);

                    plot_frame_arm(a,alpha,d,theta,handles)
                    plot3(handles.axes1,q_x,q_y,q_z,'b','linewidth',2);
                end
            else
                v_max_need = sqrt(q_max*a_max);
                set(handles.v_max_val,'string',num2str(v_max_need-0.0005));
                Trajectory(handles,a,alpha,d,theta)   
            end
        end
    end
    msgbox('Trajectory planning compeleted');
end
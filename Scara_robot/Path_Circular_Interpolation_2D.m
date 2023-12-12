function Path_Circular_Interpolation_2D(handles,a,alpha,d,theta,opacity)
%%
%2D Circular interpolation
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
    %Find the third point to reach singularities
    p_x_new = a(1) + a(2);
    p_y_new = 0;
%%
    %Circle center point:
    A = 2*[(p_x_new - p_x_old) (p_y_new - p_y_old); (p_x - p_x_old) (p_y- p_y_old)];
    B = [p_x_new^2 + p_y_new^2; p_x^2 + p_y^2] - [p_x_old^2 + p_y_old^2; p_x_old^2 + p_y_old^2];
    Pc = inv(A)*B;
    O_cir = [Pc(1) Pc(2) p_z];
    %Radius of the circle
    r = sqrt((p_x_old -  O_cir(1))^2 + (p_y_old - O_cir(2))^2);
    %Caculate Boundary angles
    theta1 = atan2(p_y_old - O_cir(2) , p_x_old - O_cir(1));
    theta3 = atan2(p_y - O_cir(2) , p_x - O_cir(1));
    %Lenght max arc
    q_max = r*abs( theta3 - theta1);
    handles.q_max_value.String  = num2str(round(q_max,3));
%% Declare variable
    q2dot =[];
    qdot = [];
    q = [];
    
    q_x =[];
    q_y =[];
    q_z =[];

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
               %Calulate profile
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
                        % Calc and plot q_x, q_y, q_z
                        th = q(i)/q_max*(theta3 - theta1) + theta1;
                        q_x(i) = O_cir(1) + r*cos(th);
                        q_y(i) = O_cir(2) + r*sin(th);
                        q_z(i) = O_cir(3) ;

%                         % Calc and plot q_x_dot, q_y_dot, q_z_dot
%                         th_dot = qdot/q_max*(theta3 - theta1);
%                         q_x_dot = -r.*th_dot.*sin(th);
%                         q_y_dot =  r.*th_dot.*cos(th);
%                         q_z_dot = 0;
% 
%                         % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
%                         th_2dot = q2dot/q_max*(theta3 - theta1);
%                         q_x_2dot = r.*(th_2dot.*cos(th) - th_2dot.^2.*sin(th));
%                         q_y_2dot = (O_cir(1) + r*cos(th));
%                         q_z_2dot = 0;
                    
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
                    plot(handles.q_graph,t(1:i),q,'linewidth',2,'color', 'red');
                    grid(handles.q_graph,'on'); 
                    plot(handles.q_dot_graph,t(1:i),qdot,'linewidth',2,'color', 'red');
                    grid(handles.q_dot_graph,'on'); 
                    plot(handles.q_2dot_graph,t(1:i),q2dot,'linewidth',2,'color', 'red');
                    grid(handles.q_2dot_graph,'on'); 

                    plot(handles.q_x,t(1:i),q_x,'linewidth',2,'color', 'red');
                    grid(handles.q_x,'on'); 
                    plot(handles.q_y,t(1:i),q_y,'linewidth',2,'color', 'red');
                    grid(handles.q_y,'on'); 
                    plot(handles.q_z,t(1:i),q_z,'linewidth',2,'color', 'red');
                    grid(handles.q_z,'on'); 

                    plot(handles.theta1_graph,t(1:i),theta1_,'linewidth',2,'color', 'red');
                    plot(handles.theta2_graph,t(1:i),theta2_,'linewidth',2,'color', 'red');
                    plot(handles.theta4_graph,t(1:i),theta4_,'linewidth',2,'color', 'red');
                    plot(handles.d3_graph,t(1:i),d3_,'linewidth',2,'color', 'red');

                    plot(handles.theta1_dot_graph,t(1:i-1),theta1_dot,'linewidth',2,'color', 'red');
                    plot(handles.theta2_dot_graph,t(1:i-1),theta2_dot,'linewidth',2,'color', 'red');
                    plot(handles.theta4_dot_graph,t(1:i-1),theta4_dot,'linewidth',2,'color', 'red');
                    plot(handles.d3_dot_graph,t(1:i-1),d3_dot,'linewidth',2,'color', 'red');

                    plot(handles.theta1_2dot_graph,t(1:i-2),theta1_2dot,'linewidth',2,'color', 'red');
                    plot(handles.theta2_2dot_graph,t(1:i-2),theta2_2dot,'linewidth',2,'color', 'red');
                    plot(handles.theta4_2dot_graph,t(1:i-2),theta4_2dot,'linewidth',2,'color', 'red');
                    plot(handles.d3_2dot_graph,t(1:i-2),d3_2dot,'linewidth',2,'color', 'red');

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
                          % Calc and plot q_x, q_y, q_z
                        th = q(i)/q_max*(theta3 - theta1) + theta1;
                        q_x(i) = O_cir(1) + r*cos(th);
                        q_y(i) = O_cir(2) + r*sin(th);
                        q_z(i) = O_cir(3) ;

%                         % Calc and plot q_x_dot, q_y_dot, q_z_dot
%                         th_dot = qdot/q_max*(theta3 - theta1);
%                         q_x_dot = -r.*th_dot.*sin(th);
%                         q_y_dot =  r.*th_dot.*cos(th);
%                         q_z_dot = 0;
% 
%                         % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
%                         th_2dot = q2dot/q_max*(theta3 - theta1);
%                         q_x_2dot = r.*(th_2dot.*cos(th) - th_2dot.^2.*sin(th));
%                         q_y_2dot = (O_cir(1) + r*cos(th));
%                         q_z_2dot = 0;
                    
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
        msgbox('Path Circular Interpolation 2D completed'); 
end

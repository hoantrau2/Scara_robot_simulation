function  Path_Circular_Interpolation_3D(handles,a,alpha,d,theta,opacity)
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
    index_Trajectory = cellstr(get(handles.Trajectory_select, 'String'));
    Trajectory_type = index_Trajectory{get(handles.Trajectory_select, 'Value')};
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
    % Check if triangle sides satisfy the triangle inequality
    if ~(a + b > c && a + c > b && b + c > a)
    p_z_mid = abs(p_z + p_z_old)/2;
    p2 = [p_x_mid p_y_mid p_z_mid];
    a = norm(p2 - p3)^2;
    b = norm(p1 - p3)^2;
    c = norm(p1 - p2)^2;
    end
%     s = (a + b + c) / 2;%Half circumference
%     r = (a * b * c) / (4 * sqrt(s * (s - a) * (s - b) * (s - c)));
%     
%     %Caculate Circle center point:
%     N = a * (b + c - a) + b * (c + a - b) + c * (a + b - c);
%     D = 2 * (a * (b + c - a) * p1 + b * (c + a - b) * p2 + c * (a + b - c) * p3);
%     O_cir = D / N;
x_c = (p1(1) + p2(1) + p3(1)) / 3;
y_c = (p1(2) + p2(2) + p3(2)) / 3;
z_c = (p1(3) + p2(3) + p3(3)) / 3;
     O_cir=[x_c ,y_c, z_c];
     r = sqrt((x_c - p_x_old)^2+(y_c - p_y_old)^2 + (z_c  - p_z_old)^2);
   %Switch coordinate system to map system in O_cir spherical coordinate system 
    a1_phi = atan2(p_y_old - O_cir(2) , p_x_old - O_cir(1));
    a3_phi = atan2(p_y - O_cir(2) , p_x - O_cir(1));

    a1_theta = atan(sqrt((p_x_old - O_cir(1))^2+(p_y_old - O_cir(2))^2)/(p_z_old  - O_cir(3)));
    a3_theta = atan(sqrt((p_x - O_cir(1))^2+(p_y - O_cir(2))^2)/(p_z  - O_cir(3)));
 
   % Caculate circular arc
    cos_circular = sin(a1_phi) * sin(a3_phi) * cos(a1_theta - a3_theta) + cos(a1_phi) * cos(a3_phi);
   % Length circular arc
   q_max = r * acos(cos_circular);
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
% %% S curve Trajectory 
%  if (strcmp(Trajectory_type,'S_curve'))
%                      %Calulate profile
%                 if (v_max <= sqrt(q_max*a_max/2))
%                 t1 = v_max/a_max;
%                 t2 = 2*t1;
%                 t3 = q_max/v_max;
%                 t4 = t3 + t1;
%                 te = t3 + t2;
%                 jerk = a_max/t1;
%                 N = 10;
%                 t = linspace(0,te,N);
%                 for i = 1:length(t)
%                     if t(i) <= t1
%                         q(i)     = jerk*t(i)^3/6;
%                         qdot(i)  = jerk*t(i)^2/2;
%                         q2dot(i) = jerk*t(i);
%                     elseif t(i) <= t2
%                         q(i)     = jerk*t1^3/6 + jerk*t1^2/2*(t(i)-t1) + a_max*(t(i)-t1)^2/2 - jerk*(t(i)-t1)^3/6;
%                         qdot(i)  = jerk*t1^2/2 + a_max*(t(i)-t1) - jerk*(t(i)-t1)^2/2;
%                         q2dot(i) = a_max - jerk*(t(i)-t1);
%                     elseif t(i) <= t3
%                         q(i)     = a_max*t1^2 + v_max*(t(i)-t2);
%                         qdot(i)  = v_max;
%                         q2dot(i) = 0;
%                     elseif t(i) <= t4
%                         q(i)     = a_max*t1^2 + v_max*(t3-t2) + v_max*(t(i)-t3) - jerk*(t(i)-t3)^3/6;
%                         qdot(i)  = v_max - jerk*(t(i)-t3)^2/2;
%                         q2dot(i) = -jerk*(t(i)-t3);
%                     elseif t(i) <= te
%                         q(i)     = q_max - jerk*(te - t(i))^3/6;
%                         qdot(i)  = v_max - jerk*(t4-t3)^2/2 - a_max*(t(i)-t4) + jerk*(t(i)-t4)^2/2;
%                         q2dot(i) = -a_max + jerk*(t(i)-t4);
%                     end            
%                         % Calculate and plot q_x, q_y, q_z
%       th    = q/q_max*(a3_phi - a1_phi) + a1_phi;
%                         th_1  = q/q_max*(a3_theta - a1_theta) + a1_theta;
%                         q_x = O_cir(1) + r*cos(th)*sin(th_1);
%                         q_y = O_cir(2) + r*sin(th)*sin(th_1);
%                         q_z = O_cir(3) + r*cos(th_1);                 
% 
%                         % Calc and plot q_x_dot, q_y_dot, q_z_dot
%                         th_dot = qdot/q_max*(a3_phi - a1_phi);
%                         th_1_dot = qdot/q_max*(a3_theta - a1_theta);
%                         q_x_dot = r*(-th_dot*sin(th)*sin(th_1) + th_1_dot*cos(th)*cos(th_1));
%                         q_y_dot = r*(th_dot*sin(th)*sin(th_1) + th_1_dot*cos(th)*cos(th_1));
%                         q_z_dot = r*th_1_dot*cos(th_1);
% 
%                         % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
%                         th_2dot = q2dot/q_max*(a3_phi - a1_phi);
%                         th_1_2dot = q2dot/q_max*(a3_theta - a1_theta);
%                         q_x_2dot = r*(-th_dot*(th_dot*cos(th)*sin(th_1) + th_1_dot*sin(th)*cos(th_1)) - th_2dot*sin(th)*sin(th_1)...
%                             - th_1_dot*(th_dot*sin(th)*cos(th_1) + th_1_dot*cos(th)*sin(th_1)) + th_1_2dot*cos(th)*cos(th_1));
%                         q_y_2dot = r*(th_dot*(th_dot*cos(th)*sin(th_1) + th_1_dot*sin(th)*cos(th_1)) + th_2dot*sin(th)*sin(th_1)...
%                             - th_1_dot*(th_dot*sin(th)*cos(th_1) + th_1_dot*cos(th)*sin(th_1)) + th_1_2dot*cos(th)*cos(th_1));
%                         q_z_2dot = r*(th_1_2dot*cos(th_1) - th_1_dot^2*sin(th_1));
%                     
%                     [T_sub, Infor_sub] = Inverse_Kinematics(a,alpha,d,theta,0,q_x(end),q_y(end),q_z(end),handles,opacity);
%                     plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
%                     if Infor_sub(1)
%                         break
%                     end
%                     %Caculate derivative parameters
%                     theta1_ = [theta1_;rad2deg(Infor_sub(2))];
%                     theta2_ = [theta2_;rad2deg(Infor_sub(3))];
%                     theta4_ = [theta4_;rad2deg(Infor_sub(5))];
%                     d3_ = [d3_;Infor_sub(4)];
%                     nop_dot =[theta1_;theta2_;theta4_;d3_];
% 
%                     if i>1
%                         theta1_dot = [theta1_dot; (theta1_(i)-theta1_(i-1))/te*N];
%                         theta2_dot = [theta2_dot; (theta2_(i)-theta2_(i-1))/te*N];
%                         theta4_dot = [theta4_dot; (theta4_(i)-theta4_(i-1))/te*N];
%                         d3_dot     = [d3_dot    ; (d3_(i)-d3_(i-1))/te*N];
%                         one_dot = [theta1_dot; theta2_dot; theta4_dot; d3_dot];
%                     else
%                         one_dot = [0; 0; 0; 0];
%                     end
% 
%                     if(i>2)
%                         theta1_2dot = [theta1_2dot; (theta1_dot(i-1)-theta1_dot(i-2))/te*N];
%                         theta2_2dot = [theta2_2dot; (theta2_dot(i-1)-theta2_dot(i-2))/te*N];
%                         theta4_2dot = [theta4_2dot; (theta4_dot(i-1)-theta4_dot(i-2))/te*N];
%                         d3_2dot     = [d3_2dot    ; (d3_dot(i-1)-d3_dot(i-2))/te*N];
%                         two_dot = [theta1_2dot;theta2_2dot;theta4_2dot;d3_2dot];
%                     else
%                         two_dot = [0; 0; 0; 0];
%                     end
%                     pause(0.01);
% %                     Plot(q0, qq, qq_dot, qq_2dot, T_sub, t(1:i), t(1:i-1), t(1:i-2), handles, nop_dot, one_dot, two_dot);
%                     plot(handles.q_graph,t(1:i),q,'linewidth',2);
%                     grid(handles.q_graph,'on'); 
%                     plot(handles.q_dot_graph,t(1:i),qdot,'linewidth',2);
%                     grid(handles.q_dot_graph,'on'); 
%                     plot(handles.q_2dot_graph,t(1:i),q2dot,'linewidth',2);
%                     grid(handles.q_2dot_graph,'on'); 
% 
%                     plot(handles.q_x,t(1:i),q_x,'linewidth',2);
%                     grid(handles.q_x,'on'); 
%                     plot(handles.v_x,t(1:i),q_x_dot,'linewidth',2);
%                     grid(handles.v_x,'on'); 
%                     plot(handles.a_x,t(1:i),q_x_2dot,'linewidth',2);
%                     grid(handles.a_x,'on'); 
% 
%                     plot(handles.q_y,t(1:i),q_y,'linewidth',2);
%                     grid(handles.q_y,'on'); 
%                     plot(handles.v_y,t(1:i),q_y_dot,'linewidth',2);
%                     grid(handles.v_y,'on'); 
%                     plot(handles.a_y,t(1:i),q_y_2dot,'linewidth',2);
%                     grid(handles.a_y,'on'); 
% 
%                     plot(handles.q_z,t(1:i),q_z,'linewidth',2);
%                     grid(handles.q_z,'on'); 
%                     plot(handles.v_z,t(1:i),q_z_dot,'linewidth',2);
%                     grid(handles.v_z,'on'); 
%                     plot(handles.a_z,t(1:i),q_z_2dot,'linewidth',2);
%                     grid(handles.a_z,'on'); 
% 
%                     plot(handles.theta1_graph,t(1:i),theta1_,'linewidth',2);
%                     plot(handles.theta2_graph,t(1:i),theta2_,'linewidth',2);
%                     plot(handles.theta4_graph,t(1:i),theta4_,'linewidth',2);
%                     plot(handles.d3_graph,t(1:i),d3_,'linewidth',2);
% 
%                     plot(handles.theta1_dot_graph,t(1:i-1),theta1_dot,'linewidth',2);
%                     plot(handles.theta2_dot_graph,t(1:i-1),theta2_dot,'linewidth',2);
%                     plot(handles.theta4_dot_graph,t(1:i-1),theta4_dot,'linewidth',2);
%                     plot(handles.d3_dot_graph,t(1:i-1),d3_dot,'linewidth',2);
% 
%                     plot(handles.theta1_2dot_graph,t(1:i-2),theta1_2dot,'linewidth',2);
%                     plot(handles.theta2_2dot_graph,t(1:i-2),theta2_2dot,'linewidth',2);
%                     plot(handles.theta4_2dot_graph,t(1:i-2),theta4_2dot,'linewidth',2);
%                     plot(handles.d3_2dot_graph,t(1:i-2),d3_2dot,'linewidth',2);
% 
%                     handles.Pos_X.String = num2str(round(T_sub(1,4,4),3));
%                     handles.Pos_Y.String = num2str(round(T_sub(2,4,4),3));
%                     handles.Pos_Z.String = num2str(round(T_sub(3,4,4),3));
%                     handles.Yaw_value.String   = num2str(round(atan2(T_sub(2,1,4),T_sub(1,1,4))*180/pi,3));
%                     Draw_robot(a,alpha,d,theta,handles,opacity,T_sub);
%                     plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
%                 end
%             else
%                 v_max_need = sqrt(q_max*a_max);
%                 set(handles.v_max_value,'string',num2str(v_max_need-0.0005));
%                 Trajectory(handles,a,alpha,d,theta)   
%             end
%         end

%% Linear Trapezoid Trajectory   
        if (strcmp(Trajectory_type,'LSPB'))
            %Calulate profile
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
                        % Calculate and plot q_x, q_y, q_z
                           th    = q(i)/q_max*(a3_phi - a1_phi) + a1_phi;
                           th_1  = q(i)/q_max*(a3_theta - a1_theta) + a1_theta;
                        q_x = O_cir(1) + r*cos(th)*sin(th_1);
                        q_y = O_cir(2) + r*sin(th)*sin(th_1);
                        q_z = O_cir(3) + r*cos(th_1); 
                        plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);

                     plot(handles.q_x,t(1:i),q_x,'linewidth',2);
                    grid(handles.q_x,'on'); 
              

                  
                    
%                        [T_sub, Infor_sub] = Inverse_Kinematics(a,alpha,d,theta,0,q_x(1),q_y(1),q_z(1),handles,opacity);

%                         % Calc and plot q_x_dot, q_y_dot, q_z_dot
%                         th_dot = qdot(i)/q_max*(a3_phi - a1_phi);
%                         th_1_dot = qdot(i)/q_max*(a3_theta - a1_theta);
%                         q_x_dot = r*(-th_dot*sin(th)*sin(th_1) + th_1_dot*cos(th)*cos(th_1));
%                         q_y_dot = r*(th_dot*sin(th)*sin(th_1) + th_1_dot*cos(th)*cos(th_1));
%                         q_z_dot = r*th_1_dot*cos(th_1);
% 
%                         % Calc and plot q_x_2dot, q_y_2dot, q_z_2dot
%                         th_2dot = q2dot(i)/q_max*(a3_phi - a1_phi);
%                         th_1_2dot = q2dot(i)/q_max*(a3_theta - a1_theta);
%                         q_x_2dot = r*(-th_dot*(th_dot*cos(th)*sin(th_1) + th_1_dot*sin(th)*cos(th_1)) - th_2dot*sin(th)*sin(th_1)...
%                             - th_1_dot*(th_dot*sin(th)*cos(th_1) + th_1_dot*cos(th)*sin(th_1)) + th_1_2dot*cos(th)*cos(th_1));
%                         q_y_2dot = r*(th_dot*(th_dot*cos(th)*sin(th_1) + th_1_dot*sin(th)*cos(th_1)) + th_2dot*sin(th)*sin(th_1)...
%                             - th_1_dot*(th_dot*sin(th)*cos(th_1) + th_1_dot*cos(th)*sin(th_1)) + th_1_2dot*cos(th)*cos(th_1));
%                         q_z_2dot = r*(th_1_2dot*cos(th_1) - th_1_dot^2*sin(th_1));
%                     
%                     plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
%                     if Infor_sub(1)
%                         break
%                     end
%                     %Caculate derivative parameters
%                     theta1_ = [theta1_;rad2deg(Infor_sub(2))];
%                     theta2_ = [theta2_;rad2deg(Infor_sub(3))];
%                     theta4_ = [theta4_;rad2deg(Infor_sub(5))];
%                     d3_ = [d3_;Infor_sub(4)];
%                     nop_dot =[theta1_;theta2_;theta4_;d3_];
% 
%                     if i>1
%                         theta1_dot = [theta1_dot; (theta1_(i)-theta1_(i-1))/te*N];
%                         theta2_dot = [theta2_dot; (theta2_(i)-theta2_(i-1))/te*N];
%                         theta4_dot = [theta4_dot; (theta4_(i)-theta4_(i-1))/te*N];
%                         d3_dot     = [d3_dot    ; (d3_(i)-d3_(i-1))/te*N];
%                         one_dot = [theta1_dot; theta2_dot; theta4_dot; d3_dot];
%                     else
%                         one_dot = [0; 0; 0; 0];
%                     end
% 
%                     if(i>2)
%                         theta1_2dot = [theta1_2dot; (theta1_dot(i-1)-theta1_dot(i-2))/te*N];
%                         theta2_2dot = [theta2_2dot; (theta2_dot(i-1)-theta2_dot(i-2))/te*N];
%                         theta4_2dot = [theta4_2dot; (theta4_dot(i-1)-theta4_dot(i-2))/te*N];
%                         d3_2dot     = [d3_2dot    ; (d3_dot(i-1)-d3_dot(i-2))/te*N];
%                         two_dot = [theta1_2dot;theta2_2dot;theta4_2dot;d3_2dot];
%                     else
%                         two_dot = [0; 0; 0; 0];
%                     end
%                     pause(0.01);
% %                     Plot(q0, qq, qq_dot, qq_2dot, T_sub, t(1:i), t(1:i-1), t(1:i-2), handles, nop_dot, one_dot, two_dot);
%                     plot(handles.q_graph,t(1:i),q,'linewidth',2);
%                     grid(handles.q_graph,'on'); 
%                     plot(handles.q_dot_graph,t(1:i),qdot,'linewidth',2);
%                     grid(handles.q_dot_graph,'on'); 
%                     plot(handles.q_2dot_graph,t(1:i),q2dot,'linewidth',2);
%                     grid(handles.q_2dot_graph,'on'); 
% 
%                     plot(handles.q_x,t(1:i),q_x,'linewidth',2);
%                     grid(handles.q_x,'on'); 
%                     plot(handles.v_x,t(1:i),q_x_dot,'linewidth',2);
%                     grid(handles.v_x,'on'); 
%                     plot(handles.a_x,t(1:i),q_x_2dot,'linewidth',2);
%                     grid(handles.a_x,'on'); 
% 
%                     plot(handles.q_y,t(1:i),q_y,'linewidth',2);
%                     grid(handles.q_y,'on'); 
%                     plot(handles.v_y,t(1:i),q_y_dot,'linewidth',2);
%                     grid(handles.v_y,'on'); 
%                     plot(handles.a_y,t(1:i),q_y_2dot,'linewidth',2);
%                     grid(handles.a_y,'on'); 
% 
%                     plot(handles.q_z,t(1:i),q_z,'linewidth',2);
%                     grid(handles.q_z,'on'); 
%                     plot(handles.v_z,t(1:i),q_z_dot,'linewidth',2);
%                     grid(handles.v_z,'on'); 
%                     plot(handles.a_z,t(1:i),q_z_2dot,'linewidth',2);
%                     grid(handles.a_z,'on'); 
% 
%                     plot(handles.theta1_graph,t(1:i),theta1_,'linewidth',2);
%                     plot(handles.theta2_graph,t(1:i),theta2_,'linewidth',2);
%                     plot(handles.theta4_graph,t(1:i),theta4_,'linewidth',2);
%                     plot(handles.d3_graph,t(1:i),d3_,'linewidth',2);
% 
%                     plot(handles.theta1_dot_graph,t(1:i-1),theta1_dot,'linewidth',2);
%                     plot(handles.theta2_dot_graph,t(1:i-1),theta2_dot,'linewidth',2);
%                     plot(handles.theta4_dot_graph,t(1:i-1),theta4_dot,'linewidth',2);
%                     plot(handles.d3_dot_graph,t(1:i-1),d3_dot,'linewidth',2);
% 
%                     plot(handles.theta1_2dot_graph,t(1:i-2),theta1_2dot,'linewidth',2);
%                     plot(handles.theta2_2dot_graph,t(1:i-2),theta2_2dot,'linewidth',2);
%                     plot(handles.theta4_2dot_graph,t(1:i-2),theta4_2dot,'linewidth',2);
%                     plot(handles.d3_2dot_graph,t(1:i-2),d3_2dot,'linewidth',2);
% 
%                     handles.Pos_X.String = num2str(round(T_sub(1,4,4),3));
%                     handles.Pos_Y.String = num2str(round(T_sub(2,4,4),3));
%                     handles.Pos_Z.String = num2str(round(T_sub(3,4,4),3));
%                     handles.Yaw_value.String   = num2str(round(atan2(T_sub(2,1,4),T_sub(1,1,4))*180/pi,3));
%                     Draw_robot(a,alpha,d,theta,handles,opacity,T_sub);
%                     plot3(handles.axes1,q_x,q_y,q_z-30,'b','linewidth',2);
                end
            else
                v_max_need = sqrt(q_max*a_max);
                set(handles.v_max_value,'string',num2str(v_max_need-0.0005));
                Trajectory(handles,a,alpha,d,theta)   
            end
        end
    end 
        hold on;
        msgbox('Path Linear Interpolation completed'); 
end
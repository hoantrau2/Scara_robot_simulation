function Config_axes(handles)
%% Trajectory
    cla(handles.q_graph,'reset');
    grid(handles.q_graph,'on'); 
    hold(handles.q_graph,'on'); 
    y_label = sprintf('${%c}$','q');
    ylabel(handles.q_graph,y_label, 'Interpreter', 'LaTeX','fontsize',13);

    cla(handles.q_dot_graph,'reset');
    grid(handles.q_dot_graph,'on'); 
    hold(handles.q_dot_graph,'on'); 
    y_label = sprintf('$\\dot{%c}$','q');
    ylabel(handles.q_dot_graph,y_label, 'Interpreter', 'LaTeX','fontsize',13);

    cla(handles.q_2dot_graph,'reset');
    grid(handles.q_2dot_graph,'on'); 
    hold(handles.q_2dot_graph,'on'); 
    xlabel(handles.q_2dot_graph,'time(s)');
    y_label = sprintf('$\\ddot{%c}$','q');
    ylabel(handles.q_2dot_graph,y_label, 'Interpreter', 'LaTeX','fontsize',13);
%---------------------------------------------------------------------------------------------------------
% End_effector
    cla(handles.q_x,'reset');
    grid(handles.q_x,'on');
    hold(handles.q_x,'on');
    str2='$$q_x$$';
    ylabel(handles.q_x,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.v_x,'reset');
    grid(handles.v_x,'on');
    hold(handles.v_x,'on');
    str2='$$v_x$$';
    ylabel(handles.v_x,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.a_x,'reset');
    grid(handles.a_x,'on');
    hold(handles.a_x,'on');
    str2='$$a_x$$';
    ylabel(handles.a_x,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.q_y,'reset');
    grid(handles.q_y,'on');
    hold(handles.q_y,'on');
    str2='$$q_y$$';
    ylabel(handles.q_y,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.v_y,'reset');
    grid(handles.v_y,'on');
    hold(handles.v_y,'on');
    str2='$$v_y$$';
    ylabel(handles.v_y,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.a_y,'reset');
    grid(handles.a_y,'on');
    hold(handles.a_y,'on');
    str2='$$a_y$$';
    ylabel(handles.a_y,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.q_z,'reset');
    grid(handles.q_z,'on');
    hold(handles.q_z,'on');
    xlabel(handles.q_z,'time(s)');
    str2='$$q_z$$';
    ylabel(handles.q_z,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.v_z,'reset');
    grid(handles.v_z,'on');
    hold(handles.v_z,'on');
    xlabel(handles.v_z,'time(s)');
    str2='$$v_z$$';
    ylabel(handles.v_z,str2,'interpreter','latex','fontsize',13,'fontweight','bold');

    cla(handles.a_z,'reset');
    grid(handles.a_z,'on');
    hold(handles.a_z,'on');
    xlabel(handles.a_z,'time(s)');
    str2='$$a_z$$';
    ylabel(handles.a_z,str2,'interpreter','latex','fontsize',13,'fontweight','bold');
%---------------------------------------------------------------------------------------------------------
    cla(handles.theta1_graph,'reset');
    grid(handles.theta1_graph,'on'); 
    hold(handles.theta1_graph,'on'); 
    str2='$$\theta_1 (Deg)$$';
    ylabel(handles.theta1_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.theta1_dot_graph,'reset');
    grid(handles.theta1_dot_graph,'on'); 
    hold(handles.theta1_dot_graph,'on'); 
    str2='$$\omega_1 (Deg/s)$$';
    ylabel(handles.theta1_dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.theta1_2dot_graph,'reset');
    grid(handles.theta1_2dot_graph,'on'); 
    hold(handles.theta1_2dot_graph,'on'); 
    str2='$$a_1 (Deg/s^2)$$';
    ylabel(handles.theta1_2dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');


    cla(handles.theta2_graph,'reset');
    grid(handles.theta2_graph,'on'); 
    hold(handles.theta2_graph,'on'); 
    str2='$$\theta_2(Deg)$$';
    ylabel(handles.theta2_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.theta2_dot_graph,'reset');
    grid(handles.theta2_dot_graph,'on'); 
    hold(handles.theta2_dot_graph,'on'); 
    str2='$$\omega_2(Deg/s)$$';
    ylabel(handles.theta2_dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.theta2_2dot_graph,'reset');
    grid(handles.theta2_2dot_graph,'on'); 
    hold(handles.theta2_2dot_graph,'on'); 
    str2='$$a_2(Deg/s^2)$$';
    ylabel(handles.theta2_2dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');      


    cla(handles.d3_graph,'reset');
    grid(handles.d3_graph,'on'); 
    hold(handles.d3_graph,'on'); 
    str2='$$d_3(m)$$';
    ylabel(handles.d3_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.d3_dot_graph,'reset');
    grid(handles.d3_dot_graph,'on'); 
    hold(handles.d3_dot_graph,'on'); 
    str2='$$v_{d_3(m/s)}$$';
    ylabel(handles.d3_dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.d3_2dot_graph,'reset');
    grid(handles.d3_2dot_graph,'on'); 
    hold(handles.d3_2dot_graph,'on'); 
    str2='$$a_{d_3(m^2/s)}$$';
    ylabel(handles.d3_2dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');


    cla(handles.theta4_graph,'reset');
    grid(handles.theta4_graph,'on'); 
    hold(handles.theta4_graph,'on'); 
    xlabel(handles.theta4_graph,'time(s)');
    str2='$$\theta_4(Deg)$$';
    ylabel(handles.theta4_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.theta4_dot_graph,'reset');
    grid(handles.theta4_dot_graph,'on'); 
    hold(handles.theta4_dot_graph,'on'); 
    xlabel(handles.theta4_dot_graph,'time(s)');
    str2='$$\omega_4(Deg/s)$$';
    ylabel(handles.theta4_dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.theta4_2dot_graph,'reset');
    grid(handles.theta4_2dot_graph,'on'); 
    hold(handles.theta4_2dot_graph,'on'); 
    xlabel(handles.theta4_2dot_graph,'time(s)');
    str2='$$a_4(Deg/s^2)$$';
    ylabel(handles.theta4_2dot_graph,str2,'interpreter','latex','fontsize',10,'fontweight','bold');
end
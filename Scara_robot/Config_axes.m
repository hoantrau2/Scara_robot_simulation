function Config_axes(handles)
%% axes of Trajectory planning
    cla(handles.q_graph,'reset');
    grid(handles.q_graph,'on'); 
    hold(handles.q_graph,'on'); 
    y_label = sprintf('${%c}$','q');
    ylabel(handles.q_graph,y_label, 'Interpreter', 'LaTeX','fontsize',10);

    cla(handles.q_dot_graph,'reset');
    grid(handles.q_dot_graph,'on'); 
    hold(handles.q_dot_graph,'on'); 
    y_label = sprintf('$\\dot{%c}$','q');
    ylabel(handles.q_dot_graph,y_label, 'Interpreter', 'LaTeX','fontsize',10);

    cla(handles.q_2dot_graph,'reset');
    grid(handles.q_2dot_graph,'on'); 
    hold(handles.q_2dot_graph,'on'); 
    xlabel(handles.q_2dot_graph,'time(s)');
    y_label = sprintf('$\\ddot{%c}$','q');
    ylabel(handles.q_2dot_graph,y_label, 'Interpreter', 'LaTeX','fontsize',10);
%---------------------------------------------------------------------------------------------------------
% End_effector
    cla(handles.q_x,'reset');
    grid(handles.q_x,'on');
    hold(handles.q_x,'on');
    str2='$$q_x$$';
    ylabel(handles.q_x,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.q_y,'reset');
    grid(handles.q_y,'on');
    hold(handles.q_y,'on');
    str2='$$q_y$$';
    ylabel(handles.q_y,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

    cla(handles.q_z,'reset');
    grid(handles.q_z,'on');
    hold(handles.q_z,'on');
    xlabel(handles.q_z,'time(s)');
    str2='$$q_z$$';
    ylabel(handles.q_z,str2,'interpreter','latex','fontsize',10,'fontweight','bold');

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
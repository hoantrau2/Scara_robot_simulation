function plot_frame_arm(a,alpha,d,theta,handles,opacity, T)
    cla(handles.axes1,'reset');
    hold on
    rotate3d(handles.axes1,'on')
    grid on
    xlabel('x(mm)')
    ylabel('y(mm)')
    zlabel('z(mm)')   
    axis([-1000 1000 -1000 1000 0 700])
    view(3);
%%
    %all arm
    plot_arm_link_3(handles,T,a,alpha,d,theta,opacity);
    plot_link_1(handles,T,a,alpha,d,theta,opacity);
    plot_link_2(handles,T,a,alpha,d,theta,opacity);

%% 
    %End effector
    plot3(handles.axes1,[(round(T(1,4,3),2) - (-30)*cos(theta(4))) round(T(1,4,3),2)],[(round(T(2,4,3),2) - (-30)*sin(theta(4))) round(T(2,4,3),2)],[d(1)+d(2)+d(3)+(-30) d(1)+d(2)+d(3)+(-30)],'green','linewidth',5);
    plot3(handles.axes1,[(round(T(1,4,3),2) + (-30)*cos(theta(4))) round(T(1,4,3),2)],[(round(T(2,4,3),2) + (-30)*sin(theta(4))) round(T(2,4,3),2)],[d(1)+d(2)+d(3)+(-30) d(1)+d(2)+d(3)+(-30)],'green','linewidth',5);
    plot3(handles.axes1,[(round(T(1,4,3),2) - (-30)*cos(theta(4))) (round(T(1,4,3),2) - (-30)*cos(theta(4)))],[(round(T(2,4,3),2) - (-30)*sin(theta(4))) (round(T(2,4,3),2) - (-30)*sin(theta(4)))],[d(1)+d(2)+d(3)+(-30) d(1)+d(2)+d(3)+(-50)+(-30)],'Color',[128 0 0]/255,'linewidth',5);
    plot3(handles.axes1,[(round(T(1,4,3),2) + (-30)*cos(theta(4))) (round(T(1,4,3),2) + (-30)*cos(theta(4)))],[(round(T(2,4,3),2) + (-30)*sin(theta(4))) (round(T(2,4,3),2) + (-30)*sin(theta(4)))],[d(1)+d(2)+d(3)+(-30) d(1)+d(2)+d(3)+(-50)+(-30)],'Color',[128 0 0]/255,'linewidth',5);


%%
    %plot coordinate
    if (handles.Show_coordination.Value ==1)
        plot_coordinate(handles,0,0,0,1,1,1,0);
        plot_coordinate(handles,round(T(1,4,1),2),round(T(2,4,1),2),round(T(3,4,1),2),cos(theta(1)),sin(theta(1)),1,1);
        plot_coordinate(handles,round(T(1,4,2),2),round(T(2,4,2),2),round(T(3,4,2),2),cos(theta(2)),sin(theta(2)),1,2);
        plot_coordinate(handles,round(T(1,4,3),2),round(T(2,4,3),2),round(T(3,4,3),2),cos(theta(2)),sin(theta(2)),-1,3);
        plot_coordinate(handles,round(T(1,4,4),2),round(T(2,4,4),2),round(T(3,4,4),2),cos(theta(4)),sin(theta(4)),-1,4); 
    end
    if handles.ChB_WoSp.Value
        draw_workspace();
    end
end

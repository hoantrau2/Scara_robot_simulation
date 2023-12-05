function Draw_robot(a,alpha,d,theta,handles,opacity, T)
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
    % Draw all link
    Draw_link_1(handles,T,a,alpha,d,theta,opacity);
    Draw_link_2(handles,T,a,alpha,d,theta,opacity);
    Draw_link_3(handles,T,a,alpha,d,theta,opacity);
%%
    %plot coordinate
    if (handles.Show_coordination.Value ==1)
        Coordinate_frame(handles,0,0,0,1,1,1,0);
        Coordinate_frame(handles,round(T(1,4,1),2),round(T(2,4,1),2),round(T(3,4,1),2),cos(theta(1)),sin(theta(1)),1,1);
        Coordinate_frame(handles,round(T(1,4,2),2),round(T(2,4,2),2),round(T(3,4,2),2),cos(theta(2)),sin(theta(2)),1,2);
        Coordinate_frame(handles,round(T(1,4,3),2),round(T(2,4,3),2),round(T(3,4,3),2),cos(theta(2)),sin(theta(2)),-1,3);
        Coordinate_frame(handles,round(T(1,4,4),2),round(T(2,4,4),2),round(T(3,4,4),2),cos(theta(4)),sin(theta(4)),-1,4); 
    end
    if handles.Show_WS.Value
        Draw_workspace();
    end
end

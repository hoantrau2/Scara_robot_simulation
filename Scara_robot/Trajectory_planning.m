function Trajectory_planning(handles,a,alpha,d,theta,opacity) 
    index_Path_planning = cellstr(get(handles.Path_Planning_select, 'String'));
    Path_planning_type = index_Path_planning{get(handles.Path_Planning_select, 'Value')};   
  
    if strcmp(Path_planning_type,'Linear_Interpolation')
       Path_Linear_Interpolation(handles,a,alpha,d,theta,opacity);
    elseif strcmp(Path_planning_type,'Circular_Interpolation_2D')
       Path_Circular_Interpolation_2D(handles,a,alpha,d,theta,opacity)
    elseif strcmp(Path_planning_type,'Circular_Interpolation_3D')
       Path_Circular_Interpolation_3D(handles,a,alpha,d,theta,opacity);
    end
end
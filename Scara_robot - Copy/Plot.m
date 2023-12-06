function Plot(q0, qq, qq_dot, qq_2dot, T_sub, t,t1,t2, handles, nop_dot, one_dot, two_dot)
  % plot 
                    plot(handles.q_graph,t,q0(1),'linewidth',2);
                    grid(handles.q_graph,'on'); 
                    plot(handles.q_dot_graph,t,q0(2),'linewidth',2);
                    grid(handles.q_dot_graph,'on'); 
                    plot(handles.q_2dot_graph,t,q0(3),'linewidth',2);
                    grid(handles.q_2dot_graph,'on'); 

                    plot(handles.q_x,t,qq(1),'linewidth',2);
                    grid(handles.q_x,'on'); 
                    plot(handles.v_x,t,qq_dot(1),'linewidth',2);
                    grid(handles.v_x,'on'); 
                    plot(handles.a_x,t,qq_2dot(1),'linewidth',2);
                    grid(handles.a_x,'on'); 

                    plot(handles.q_y,t,qq(2),'linewidth',2);
                    grid(handles.q_y,'on'); 
                    plot(handles.v_y,t,qq_dot(2),'linewidth',2);
                    grid(handles.v_y,'on'); 
                    plot(handles.a_y,t,qq_2dot(2),'linewidth',2);
                    grid(handles.a_y,'on'); 

                    plot(handles.q_z,t,qq(3),'linewidth',2);
                    grid(handles.q_z,'on'); 
                    plot(handles.v_z,t,qq_dot(3),'linewidth',2);
                    grid(handles.v_z,'on'); 
                    plot(handles.a_z,t,qq_2dot(3),'linewidth',2);
                    grid(handles.a_z,'on'); 

                    plot(handles.theta1_graph,t,nop_dot(1),'linewidth',2);
                    plot(handles.theta2_graph,t,nop_dot(2),'linewidth',2);
                    plot(handles.theta4_graph,t,nop_dot(3),'linewidth',2);
                    plot(handles.d3_graph,t,nop_dot(4),'linewidth',2);

                    plot(handles.theta1_dot_graph,t1,one_dot(1),'linewidth',2);
                    plot(handles.theta2_dot_graph,t1,one_dot(2),'linewidth',2);
                    plot(handles.theta4_dot_graph,t1,one_dot(3),'linewidth',2);
                    plot(handles.d3_dot_graph,t1,one_dot(4),'linewidth',2);

                    plot(handles.theta1_2dot_graph,t2,two_dot(1),'linewidth',2);
                    plot(handles.theta2_2dot_graph,t2,two_dot(2),'linewidth',2);
                    plot(handles.theta4_2dot_graph,t2,two_dot(3),'linewidth',2);
                    plot(handles.d3_2dot_graph,t2,two_dot(4),'linewidth',2);

                    handles.Pos_X.String = num2str(round(T_sub(1,4,4),3));
                    handles.Pos_Y.String = num2str(round(T_sub(2,4,4),3));
                    handles.Pos_Z.String = num2str(round(T_sub(3,4,4),3));
                    handles.Yaw_value.String   = num2str(round(atan2(T_sub(2,1,4),T_sub(1,1,4))*180/pi,3));

end
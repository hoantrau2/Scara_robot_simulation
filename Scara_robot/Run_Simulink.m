function Run_Simulink(t, theta1,theta2, d3, theta4)

set_param('Dynamic_Control_PID/motor1/Integrator','InitialCondition',num2str(0));
set_param('Dynamic_Control_PID/motor2/Integrator','InitialCondition',num2str(90));
set_param('Dynamic_Control_PID/motor3/Integrator','InitialCondition',num2str(0));
set_param('Dynamic_Control_PID/motor4/Integrator','InitialCondition',num2str(0));

sig1 = [t;theta1'];
sig2 = [t;theta2'];
sig3 = [t;d3'];
sig4 = [t;theta4'];

save theta1set.mat sig1;
save theta2set.mat sig2;
save d3set.mat sig3;
save theta4set.mat sig4;

set_param('Dynamic_Control_PID','StopTime',num2str(t(end)));
set_param('Dynamic_Control_PID','SimulationCommand','start');
end
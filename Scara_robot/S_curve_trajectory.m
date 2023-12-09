function [q, qdot, q2dot, t]=S_curve_trajectory(a_max,v_max,v_max)
 if (v_max <= sqrt(q_max*a_max/2))
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
                end    
end
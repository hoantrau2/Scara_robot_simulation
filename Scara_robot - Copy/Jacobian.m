function q_dot = Jacobian(T,qe_dot)
%     T = Transformation_matrix(a,alpha,d,theta);
    z0 = [0; 0; 1];
    p0 = [0; 0; 0];
    
    z1 = T(1:3,3,1);  p1 = T(1:3,4,1);
    z2 = T(1:3,3,2);  p2 = T(1:3,4,2);
    z3 = T(1:3,3,3);  p3 = T(1:3,4,3);
    z4 = T(1:3,3,4);  p4 = T(1:3,4,4);
    
    %Jacobian matrix
    J = [cross(z0,p4-p0) cross(z1,p4-p1) z2 cross(z3,p4-p3);
            z0                z1      zeros(3,1)      z3   ];
    q_dot = pinv(J)* qe_dot;

end
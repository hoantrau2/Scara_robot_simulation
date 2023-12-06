function T = Transformation_matrix(a,alpha,d,theta,handles,opacity)
    T(:,:,1)= Denavit_Hartenberg_matrix(a(1),alpha(1),d(1),theta(1));
    for i = 2:4
        T(:,:,i) = T(:,:,i-1)*Denavit_Hartenberg_matrix(a(i),alpha(i),d(i),theta(i));
    end  
end
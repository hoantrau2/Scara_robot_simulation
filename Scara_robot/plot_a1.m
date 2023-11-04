function plot_a1(handles,T,a,alpha,d,theta)
    L = -a(1);
    W = 70; % W la y, L theo x, H theo z (do day)
    H1 =  + 20; 
    H2 =  - 20;
    opacity = str2double(handles.Opac_val.String);
    Color = [255, 140, 200]/255;
    
   %Ve mat phang chieu cao z = H1
      A = [  0     0    L    L;
            W/2 -W/2 -W/2  W/2;
             H1    H1   H1  H1;
             1    1   1  1];
      U = T(:,:,1)*A;
      X = U(1,:);
      Y = U(2,:);
      Z =  U(3,:);
       fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)
   %Ve mat phang chieu cao z = H2
      A = [  0     0    L    L;
            W/2 -W/2 -W/2  W/2;
             H2    H2   H2  H2;
             1    1   1  1];
       U = T(:,:,1)*A;
      X = U(1,:);
      Y = U(2,:);
      Z =  U(3,:);
       fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)      
   %Ve mat phang mat ben 1 y=W/2
      A = [  0     0    L    L;
            W/2 W/2 W/2  W/2;
             H1    H2   H2  H1;
             1    1   1  1];
      U = T(:,:,1)*A;
      X = U(1,:);
      Y = U(2,:);
      Z = U(3,:);
     fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)
   %Ve mat phang mat ben 2 y= - W/2
      A = [  0     0    L    L;
            -W/2 -W/2 -W/2  -W/2;
             H1    H2   H2  H1;
             1    1   1  1];
       U = T(:,:,1)*A;
      X = U(1,:);
      Y = U(2,:);
      Z =  U(3,:);
      fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)
end
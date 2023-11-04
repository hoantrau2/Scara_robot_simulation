function plot_a2(handles,T,a,alpha,d,theta)
x = T(1,4,1);%x, y la toa do goc cua truc xoyz1
y = T(2,4,1);
L = -a(2); %khoang cach z1 va z2 theo truc x2
W = 70; %do day theo chieu x, const
H1 =  + 60; %be day tren
H2 =  - 20; %be day duoi
opacity = str2double(handles.Opac_val.String);
Color = [255, 140, 200]/255;

   %Ve mat phang chieu cao z = H1
      A = [  0     0    L    L;
            W/2 -W/2 -W/2  W/2;
             H1    H1   H1  H1;
             1    1   1  1];
      U = T(:,:,2)*A;
      X = U(1,:);
      Y = U(2,:);
      Z =  U(3,:);
       fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)
   %Ve mat phang chieu cao z = H2
      A = [  0     0    L    L;
            W/2 -W/2 -W/2  W/2;
             H2    H2   H2  H2;
             1    1   1  1];
       U = T(:,:,2)*A;
      X = U(1,:);
      Y = U(2,:);
      Z =  U(3,:);
       fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)      
   %Ve mat phang mat ben 1 y=W/2
      A = [  0     0    L    L;
            W/2 W/2 W/2  W/2;
             H1    H2   H2  H1;
             1    1   1  1];
      U = T(:,:,2)*A;
      X = U(1,:);
      Y = U(2,:);
      Z = U(3,:);
     fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)
   %Ve mat phang mat ben 2 y= - W/2
      A = [  0     0    L    L;
            -W/2 -W/2 -W/2  -W/2;
             H1    H2   H2  H1;
             1    1   1  1];
       U = T(:,:,2)*A;
      X = U(1,:);
      Y = U(2,:);
      Z =  U(3,:);
      fill3(handles.axes1, X, Y, Z, Color, 'FaceAlpha', opacity)
end
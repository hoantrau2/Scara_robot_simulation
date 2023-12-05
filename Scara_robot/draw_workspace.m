function Draw_workspace(a,d)
% workspase when max a(1) + a(2)
    t1 = linspace(-125, 125,100)*pi/180; %vector has 500 elements between -120*pi/180 and 120*pi/180 degrees
    x1 = (a(1)+a(2))*cos(t1);
    y1 = (a(1)+a(2))*sin(t1);
    z1_low = ones(size(t1))*(d(1)+d(2)-150); 
    z1_high = ones(size(t1))*(d(1)+d(2)-30); %10 is a offset number
    surf([x1;x1], [y1;y1], [z1_low; z1_high],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',0.4)
%     fill3(x1, y1, z1_low,'c','EdgeColor','none', 'FaceAlpha',0.4)
%     fill3(x1, y1, z1_high,'c','EdgeColor','none', 'FaceAlpha',0.4)

% workspase when max a(1) - a(2)
    t2_sub = (180 -145);
    R_sub = sqrt(a(1)^2 + a(2)^2 - 2*a(1)*a(2)*cos( t2_sub*pi/180));
    alpha_sub=asin(sin(t2_sub*pi/180)*a(2)/R_sub);
    t2 = linspace(-125-alpha_sub *180/pi,125+alpha_sub *180/pi,100)*pi/180;
    x2 = R_sub*cos(t2);
    y2 = R_sub*sin(t2);
    z2_low = ones(size(t2))*(d(1)+d(2)-150);
    z2_high = ones(size(t2))*(d(1)+d(2)-30);
    surf([x2;x2], [y2;y2], [z2_low; z2_high],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',0.4)
    
 %Daw ring shape for work space
 fill3([x2, fliplr(x1)], [y2, fliplr(y1)], [z2_low, z2_low], 'c', 'EdgeColor', 'none', 'FaceAlpha', 0.25);
 fill3([x2, fliplr(x1)], [y2, fliplr(y1)], [z2_high, z2_high], 'c', 'EdgeColor', 'none', 'FaceAlpha', 0.25);
 
 % workspase when a(1)max ~ a(2)
    xa_origin = a(1)*cos(125*pi/180);
    ya_origin = a(1)*sin(125*pi/180);
    t3a = linspace(125, 125+145,100)*pi/180;
    x3a = 400*cos(t3a)+ xa_origin;
    y3a = 400*sin(t3a)+ya_origin;
    z3a_low = ones(size(t3a))*(d(1)+d(2)-150);
    z3a_high = ones(size(t3a))*(d(1)+d(2)-30);
    surf([x3a;x3a], [y3a;y3a], [z3a_low; z3a_high],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',0.4)
    fill3(x3a, y3a, z3a_low, 'c','EdgeColor','none', 'FaceAlpha',0.2)
    fill3(x3a, y3a, z3a_high, 'c','EdgeColor','none', 'FaceAlpha',0.2)
 
    xb_origin = a(1)*cos(-125*pi/180);
    yb_origin = a(1)*sin(-125*pi/180);
    t3b = linspace(-125-145, -125,100)*pi/180;
    x3b = 400*cos(t3b)+ xb_origin;
    y3b = 400*sin(t3b)+yb_origin;
    z3b_low = ones(size(t3b))*(d(1)+d(2)-150);
    z3b_high = ones(size(t3b))*(d(1)+d(2)-30);
    surf([x3b;x3b], [y3b;y3b], [z3b_low; z3b_high],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',0.4)
    fill3(x3b, y3b, z3b_low, 'c','EdgeColor','none', 'FaceAlpha',0.2)
    fill3(x3b, y3b, z3b_high, 'c','EdgeColor','none', 'FaceAlpha',0.2)
end
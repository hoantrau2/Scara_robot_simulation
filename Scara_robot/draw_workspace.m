function Draw_workspace()
    t1 = linspace(-120, 120,1000)*pi/180;
    x1 = (450+400)*cos(t1)+0;
    y1 = (450+400)*sin(t1)+0;
    z1a = ones(size(t1))*213;
    z1b = ones(size(t1))*353;
    z1 = zeros(size(t1));
    surf([x1;x1], [y1;y1], [z1a; z1b],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',1)
    fill3(x1, y1, z1a,'c','EdgeColor','none', 'FaceAlpha',0.25)

    t2 = linspace(-180, 180,1000)*pi/180;
    x2 = 260*cos(t2);
    y2 = 260*sin(t2);
    z2a = ones(size(t2))*213;
    z2b = ones(size(t2))*353;
    z2 = zeros(size(t2));
    surf([x2;x2], [y2;y2], [z2a; z2b],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',1)
    fill3(x2, y2, z2a,'w','EdgeColor','none', 'FaceAlpha',0.25)

    t3 = linspace(90, 246,1000)*pi/180;
    x3 = 400*cos(t3)-258.109;
    y3 = 400*sin(t3)-368.6184;
    z3a = ones(size(t3))*213;
    z3b = ones(size(t3))*353;
    z3 = zeros(size(t3));
    surf([x3;x3], [y3;y3], [z3a; z3b],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',1)
    fill3(x3, y3, z3a, 'c','EdgeColor','none', 'FaceAlpha',0.25)

    t4 = linspace(114, 270,1000)*pi/180;
    x4 = 400*cos(t4)-258.109;
    y4 = 400*sin(t4)+368.6184;
    z4a = ones(size(t4))*213;
    z4b = ones(size(t4))*353;
    z4 = zeros(size(t4));
    surf([x4;x4], [y4;y4], [z4a; z4b],'FaceColor','interp','EdgeColor','none', 'FaceAlpha',1)
    fill3(x4, y4, z4a, 'c','EdgeColor','none', 'FaceAlpha',0.25)
end
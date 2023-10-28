classdef arm
    properties
        a, alpha, d, theta
        type, base, n
        x, T, end_effector 
    end
    methods
        function obj = arm(a, alpha, d, theta, type, base)
            obj.a = a;
            obj.alpha = deg2rad(alpha);
            obj.d = d;
            obj.theta = deg2rad(theta);
            obj.type = type;
            obj.base = base;
            obj.n = 5;
        end
        
        function obj = set_joint_variable(obj, index, q)
            if obj.type(index) == 'r'   %revolute - xoay
                obj.theta(index) = q;
            elseif obj.type(index) == 'p'   %prismatic - truot
                obj.d(index) = q;
            end
        end
        
       
        function obj = update(obj)
            obj.T = forward_kinematics(obj.n, obj.a, obj.alpha, obj.d, obj.theta);
            for i = 1:obj.n+1
                obj.x(:,i) = (obj.T(1:3,4,i)) + obj.base;
            end

            obj.end_effector = [obj.x(:,obj.n+1); tform2eul(obj.T(:,:,obj.n+1))'];
        end
        
        function plot_frame(obj, axes)
            plot3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), '-o', 'LineWidth', 5);
        end
        

        function plot_arm(obj, axes)
            % Parameters
            COLOR_RED = [0.7, 0.3, 0.3];
            COLOR_GREEN = [0.3, 0.7, 0.3];
            COLOR_BLUE = [0.3, 0.7, 0.7];
            opacity = 0.6;
            
            W2 = 2;
            R1 = 1.5;
            R2 = W2/2;
            H2 = 0.5;
            H1 = obj.d(1) - H2;
            L2 = obj.a(2);
            H3 = 0.8;
            L3 = obj.a(3);
            
            % Link 1
            th = linspace(-pi, pi, 100);
            X = R1*cos(th) + obj.x(1,1);
            Y = R1*sin(th) + obj.x(2,1);
            Z1 = ones(1, size(th, 2))*obj.x(3,1);
            Z2 = ones(1, size(th, 2))*H1;
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_RED, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_RED, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_RED, 'FaceAlpha', opacity);
            
            % Link 2
            X = obj.x(1,2);
            Y = obj.x(2,2);
            Z1 = obj.x(3,2) - H2;
            Z2 = obj.x(3,2);
            yaw = (obj.theta(1)+obj.theta(2));
            
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], COLOR_GREEN, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], COLOR_GREEN, 'FaceAlpha', opacity)
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_GREEN, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_GREEN, 'FaceAlpha', opacity)
            
            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,2);
            Y = R2*sin(th) + obj.x(2,2);
            Z1 = ones(1,size(th,2))*(obj.x(3,2) - H2);
            Z2 = ones(1,size(th,2))*obj.x(3,2);
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_GREEN, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_GREEN, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_GREEN, 'FaceAlpha', opacity);
            
            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,3);
            Y = R2*sin(th) + obj.x(2,3);
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_GREEN, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_GREEN, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_GREEN, 'FaceAlpha', opacity);
            
            % Link 3
            X = obj.x(1,3);
            Y = obj.x(2,3);
            Z1 = obj.x(3,3);
            Z2 = obj.x(3,3) + H3;
            yaw = (obj.theta(1)+obj.theta(2)+obj.theta(3));
            
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            
            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,3);
            Y = R2*sin(th) + obj.x(2,3);
            Z1 = ones(1,size(th,2))*obj.x(3,3);
            Z2 = ones(1,size(th,2))*(obj.x(3,3) + H3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_BLUE, 'FaceAlpha', opacity);
            
            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,4);
            Y = R2*sin(th) + obj.x(2,4);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_BLUE, 'FaceAlpha', opacity);
        end
        
         function plot(obj, axes)
            cla(axes)
            hold on;
            rotate3d(axes, 'on');
            xlabel(axes, 'x');
            ylabel(axes, 'y'); 
            zlabel(axes, 'z');
            xlim(axes, [obj.base(1)-8 obj.base(1)+8]);
            ylim(axes, [obj.base(2)-8 obj.base(2)+8]);
            zlim(axes, [obj.base(3)   obj.base(3)+8]);
            obj.plot_frame(axes);
            obj.plot_arm(axes);
            view(axes, 3);
            drawnow;
         end
    end
 end

% Simscape(TM) Multibody(TM) version: 5.1

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(10).translation = [0.0 0.0 0.0];
smiData.RigidTransform(10).angle = 0.0;
smiData.RigidTransform(10).axis = [0.0 0.0 0.0];
smiData.RigidTransform(10).ID = '';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [0 0 0];  % mm
smiData.RigidTransform(1).angle = 3.1415926535897896;  % rad
smiData.RigidTransform(1).axis = [-1 -0 -0];
smiData.RigidTransform(1).ID = 'B[Part1-1:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [0 0 0];  % mm
smiData.RigidTransform(2).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(2).axis = [1 4.5995043095193447e-37 1.4608824573426752e-18];
smiData.RigidTransform(2).ID = 'F[Part1-1:-:]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [0 -7.6812589454548929e-13 220];  % mm
smiData.RigidTransform(3).angle = 3.4914813388431334e-15;  % rad
smiData.RigidTransform(3).axis = [1 0 0];
smiData.RigidTransform(3).ID = 'B[Part1-1:-:Part2-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [525.00000000000034 5.6843418860808015e-14 -34.999999999999943];  % mm
smiData.RigidTransform(4).angle = 3.5064518812389968e-15;  % rad
smiData.RigidTransform(4).axis = [0.99999974405653058 0.00071546269880757153 1.2543674420478323e-18];
smiData.RigidTransform(4).ID = 'F[Part1-1:-:Part2-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [0 -1.7512918125524247e-13 49.999999999999986];  % mm
smiData.RigidTransform(5).angle = 3.4914813388431337e-15;  % rad
smiData.RigidTransform(5).axis = [1 0 0];
smiData.RigidTransform(5).ID = 'B[Part2-1:-:Part4-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [9.9521622893812411e-14 7.2822011385530319e-14 -34.999999999999943];  % mm
smiData.RigidTransform(6).angle = 3.4423791915232532e-15;  % rad
smiData.RigidTransform(6).axis = [0.99964194399621809 0.026757873672287918 4.6038883366361339e-17];
smiData.RigidTransform(6).ID = 'F[Part2-1:-:Part4-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [0 -2.0539125955565396e-12 589.99999999999966];  % mm
smiData.RigidTransform(7).angle = 3.1415926535897896;  % rad
smiData.RigidTransform(7).axis = [-1 -0 -0];
smiData.RigidTransform(7).ID = 'B[Part3-1:-:Part4-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [-324.99999999999989 -1.7053025658242404e-12 500.28674379935291];  % mm
smiData.RigidTransform(8).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(8).axis = [1.6653345369377348e-16 -1 -1.7160030069856768e-15];
smiData.RigidTransform(8).ID = 'F[Part3-1:-:Part4-1]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [0 -2.0539125955565396e-12 589.99999999999966];  % mm
smiData.RigidTransform(9).angle = 3.1415926535897896;  % rad
smiData.RigidTransform(9).axis = [-1 -0 -0];
smiData.RigidTransform(9).ID = 'B[Part3-1:-:Part5-2]';

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(10).translation = [-6.8414565059465964e-15 1.9937963624583871e-12 -590.00000000000023];  % mm
smiData.RigidTransform(10).angle = 3.4659887068681334e-15;  % rad
smiData.RigidTransform(10).axis = [0.99993580064605014 0.011331133497698501 1.9635529700263736e-17];
smiData.RigidTransform(10).ID = 'F[Part3-1:-:Part5-2]';


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(5).mass = 0.0;
smiData.Solid(5).CoM = [0.0 0.0 0.0];
smiData.Solid(5).MoI = [0.0 0.0 0.0];
smiData.Solid(5).PoI = [0.0 0.0 0.0];
smiData.Solid(5).color = [0.0 0.0 0.0];
smiData.Solid(5).opacity = 0.0;
smiData.Solid(5).ID = '';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 4.8563990957346768;  % kg
smiData.Solid(1).CoM = [263.60376893651471 0 38.606323704331935];  % mm
smiData.Solid(1).MoI = [7013.8331150449167 136851.06345324524 138642.25650236499];  % kg*mm^2
smiData.Solid(1).PoI = [0 96.643761804980414 0];  % kg*mm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = 'Part2*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 13.116979565428974;  % kg
smiData.Solid(2).CoM = [-145.77084137810081 1.4108819192653446e-05 126.76542361472423];  % mm
smiData.Solid(2).MoI = [99381.902071491859 264570.07177663193 196347.60216800275];  % kg*mm^2
smiData.Solid(2).PoI = [-0.010152859706486295 -27818.813394256384 0.0043346319927577374];  % kg*mm^2
smiData.Solid(2).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = 'Part4*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.19414097332215746;  % kg
smiData.Solid(3).CoM = [0 -1.0586986666886338e-12 303.24037656515986];  % mm
smiData.Solid(3).MoI = [6161.5275150443158 6161.4879250110698 10.462499826523478];  % kg*mm^2
smiData.Solid(3).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(3).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = 'Part3*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 2.9361281029404123;  % kg
smiData.Solid(4).CoM = [2.7994035947020133 0 125.89915205034521];  % mm
smiData.Solid(4).MoI = [19159.063118603292 19781.011073600435 5910.6421090021204];  % kg*mm^2
smiData.Solid(4).PoI = [0 -896.74433508098537 0];  % kg*mm^2
smiData.Solid(4).color = [1 1 1];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = 'Part1*:*Default';

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 0.033813720263420118;  % kg
smiData.Solid(5).CoM = [0 0 8.0547926737853022];  % mm
smiData.Solid(5).MoI = [7.763338664992439 7.7634123948783254 7.5479625036808962];  % kg*mm^2
smiData.Solid(5).PoI = [0 0 0];  % kg*mm^2
smiData.Solid(5).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = 'Part5*:*Default';


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the PrismaticJoint structure array by filling in null values.
smiData.PrismaticJoint(1).Pz.Pos = 0.0;
smiData.PrismaticJoint(1).ID = '';

smiData.PrismaticJoint(1).Pz.Pos = 0;  % m
smiData.PrismaticJoint(1).ID = '[Part3-1:-:Part4-1]';


%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(4).Rz.Pos = 0.0;
smiData.RevoluteJoint(4).ID = '';

smiData.RevoluteJoint(1).Rz.Pos = 125.77070093485912;  % deg
smiData.RevoluteJoint(1).ID = '[Part1-1:-:]';

smiData.RevoluteJoint(2).Rz.Pos = -172.80102624496351;  % deg
smiData.RevoluteJoint(2).ID = '[Part1-1:-:Part2-1]';

smiData.RevoluteJoint(3).Rz.Pos = -17.992032299372699;  % deg
smiData.RevoluteJoint(3).ID = '[Part2-1:-:Part4-1]';

smiData.RevoluteJoint(4).Rz.Pos = -155.42924270969652;  % deg
smiData.RevoluteJoint(4).ID = '[Part3-1:-:Part5-2]';


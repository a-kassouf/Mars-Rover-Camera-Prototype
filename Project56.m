
clc
clear

%length, width1, width2, and thickness1, thickness2, of the leaf springs
%W_fold
which('spacar')

%0.0065    0.0004    0.0065
%L = 0.0746; % should be 5e-2
L = 0.05;
W = 0.075;
Dim3 = 0.1; %10

LeafWidth = 0.075;
LeafThickness = 0.00015;
LeafWidthFold = 0.075;

%W_fold = W - 4.3671*W/10; %length of fold-rigid
W_fold = W - 5*W/10;
%from 0.01 till W - x(7)
W_start = W_fold; %x of leaf-rigid connection

%foldedY = 7.0249*L/10;

foldedY = 1*L/10; %make this - 0.02 or something like that or maybe -1*L/10
%fix for the length ratio, if W_start is larger than W_fold it'll get
%just smaller.
%if abs(W_fold - W_start) < 0.01
%    W_start = W_fold - 0.01;
%end
zDir = 10*Dim3/20;
%fixedY = 7.0793*(L-foldedY)/10;
fixedY = 0;

nodes = [   W_start, 0, 0; %fix
            W_start, L, 0;    
            0, L, 0;  %this is node 3
            W, L, 0; %this is node 4
            W_start, foldedY, 0;
            W_start, foldedY+fixedY, zDir; %fix
            ]; 



%this changes from project 5 a bit where node 2 and node 3 are equivalent

elements = [    1,   2; %is the leaf spring
                2,   3; %rigidBody, platform 
                2,   4; %same
                2,   5; %Folded leaf spring fold p1, chilling
                5,   6; %folded leaf spring p2.
                ];

nprops(1).fix = true;
nprops(6).fix = true;

thicknessRb = 1e-2;

%garbage
%nprops(3).moment = [0 0 MomentZ]; %in the z direction
%nprops(3).moment = [0 MomentY 0]; %in the y direction

Max_angle = deg2rad(5);
%nprops(2).rot = [Max_angle, 0, 0, 1];
nprops(2).rot = [Max_angle, 0, 1, 0];

eprops(1).elems = 1;
eprops(1).emod = 210e9;
eprops(1).smod = 69e9;
eprops(1).dens = 7800; %E leaf spring
eprops(1).cshape = 'rect';
eprops(1).dim = [LeafWidth LeafThickness];
eprops(1).orien = [0 0 1]; %right
eprops(1).nbeams = 3; 
eprops(1).flex = 1:6;
eprops(1).color = 'darkblue';
eprops(1).opacity = 0.7;
eprops(1).warping = true;

eprops(2).elems = [4, 5];
eprops(2).emod = 210e9;
eprops(2).smod = 69e9;
eprops(2).dens = 7800; %E leaf spring for fold
eprops(2).cshape = 'rect';
eprops(2).dim = [LeafWidthFold LeafThickness];
eprops(2).orien = [1 0 0]; %right
eprops(2).nbeams = 3; 
eprops(2).flex = 1:6;
eprops(2).color = 'green';
eprops(2).opacity = 0.7;
eprops(2).warping = true;

eprops(3).elems = [2,3];
eprops(3).dens = 7800; %E rb
eprops(3).cshape = 'rect';
eprops(3).dim = [Dim3 thicknessRb];
eprops(3).orien = [0 0 1]; %right
eprops(3).nbeams = 1; 
eprops(3).color = 'grey';
eprops(3).opacity = 0.7;
eprops(3).warping = true;


LoadstepsN = 10;

opt.loadsteps = LoadstepsN;
%opt.gravity = [0, -9.81, 0];
out = spacarlight(nodes, elements, nprops, eprops, opt);

maxStress = out.step(LoadstepsN).stressmax
opt.gravity = [0, -9.81, 0];


nprops(2).rot = [Max_angle, 0, 0, 1];
out = spacarlight(nodes, elements, nprops, eprops, opt);

maxStress2 = out.step(LoadstepsN).stressmax

 %{
%proof that node 4 is neglectable when the rotation is around z
out.step(LoadstepsN).node(4).Freac %folded connect-rigid
out.step(LoadstepsN).node(5).Freac %folded connect connect
out.step(LoadstepsN).node(2).Freac %leaf spring connect-rigid
%}

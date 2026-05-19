%% part 1
clear 
clc


which('spacar')


L = 0.1;
W = 0.1;


nodes = [   0, 0, 0;      
            0, L, 0;    
            W, L, 0;  
            W, 0, 0;
            W/2, L, 0;
            W/2, L/2, 0;
            ]; 

elements = [    1,   2; 
                2,   5; 
                5,   3;
                3,   4;
                5,   6];


%fix the nodes fixed to the fixed world
nprops(1).fix = true;
nprops(4).fix = true;    

%force at 2
nprops(5).force = [150 0 0];      



eprops(1).elems = [1 4];            %Add this set of properties to elements 1 and 4, basically flexible things
eprops(1).emod = 210e9;            %E-modulus [Pa]
eprops(1).smod = 69e9;             %G-modulus [Pa]
eprops(1).dens = 7800;             %Density [kg/m^3]
eprops(1).cshape = 'rect';           %Rectangular cross-section
eprops(1).dim = [4e-2 1e-3];   %Width: 4 cm, thickness: 1 mm

eprops(1).orien = [0 0 1];          %Orientation of the cross-section as a vector pointing along "width-direction"
%the orientation vector is the direction of the width essentially, the x
%and y are defined based ony our nodes definition.

eprops(1).nbeams = 1; %how many minibeams (the more you add the slower it runs but the more accurate it becomes, (for leaf springs)
eprops(1).flex = 1:6;        	   %Model all deformation modes (1 to 6) as flexible
eprops(1).color = 'grey';           %Color (visualization only)
eprops(1).opacity = 0.7;              %Opacity (visualization only)
eprops(1).warping = true;



%Property set 2 (for the rigid body between the two leaf springs)
eprops(2).elems = [2, 3];                %Add this set of properties to element 2
eprops(2).dens = 2700;             %Density [kg/m^3]
eprops(2).cshape = 'rect';           %Rectangular cross-section
eprops(2).dim = [4e-2 5e-3];    %Width: 4 cm, thickness: 5 mm
eprops(2).orien = [0 0 1]; %Orientation of the cross-section as a vector pointing along "width-direction"
%width direction of element 2 (the beam) is 0 0 1, so it points in the z
%direction: perpendicular to the node placement.
eprops(2).nbeams = 1;                %Number of beams used to model elements in this set (as elements in this set are rigid, 1 is enough)
eprops(2).color = 'darkblue';       %Color (visualization only)
eprops(2).warping = true;             %Enable the modeling of warping (including constrained warping effects)
% eprops(2).hide = true;           %Hide element (visualization only)



%notice that the number of your struct called eprops isn't directly
%correlated with the element's number
eprops(3).elems = 5;                %Add this set of properties to element 2
eprops(3).dens = 0;             %Density [kg/m^3]
eprops(3).cshape = 'rect';           %Rectangular cross-section
eprops(3).dim = [4e-2 5e-3];    %Width: 4 cm, thickness: 5 mm
eprops(3).orien = [0 0 1]; 


eprops(3).nbeams = 1;
eprops(3).color = 'darkblue';
eprops(3).warping = true;


opt.loadsteps = 10;
out = spacarlight(nodes, elements, nprops, eprops,opt);


%a: this
out.step(10).node(1).Freac

%b: at the exact middle the stress is 0, it's maximum on the top and bottom
%of the leaf springs. That does make sense mathematically

%c: 

%% part 2

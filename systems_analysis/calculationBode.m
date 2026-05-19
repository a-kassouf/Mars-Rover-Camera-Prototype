E = 210e9;
G = 69e9;


L = 0.05;
W = 0.075;
H = 0.1;
L2 = H/2;

thicknessRb = 1e-2;

Wl = 0.07;
t = 0.00015;
Wf = 0.06;

W_fold = W - Wf/2;
W_start = 0.01;
d = W_fold - W_start;

I_leafspring = (t^2+L^2)*(t*L)/12;
I_foldedleafspring_bending = (t^2+L2^2)*(t*L2)/12;
I_foldedleafspring_torque = (t^2+Wl^2)*(t*Wl)/12;


Density_leafSprings = 7800;
Density_platform = 7800;

Area_platform = H*W*thicknessRb;
Area_l = L*t*Wl;
Area_f = t*(L+L2)*Wf;

M_l1 = Density_leafSprings*Area_l;
M_fl2 = Density_leafSprings*Area_f;
M_platform = Area_platform*Density_platform;
M_cam = 2;
Meq = M_cam + M_l1/3 + M_fl2/3 + M_platform;


d_air = 0.05;


stiffness_l1 = 3*E*I_leafspring/L;
stiffness_f1 = 3*E*I_foldedleafspring_bending/L2;
stiffness_f2 = 3*E*I_leafspring/(Wf/2);

cl1 = stiffness_l1 * L^2;
cf1 = stiffness_f1 * L2^2;
cf2 = stiffness_f2 * Wf^2/2; %it's over 2 and not over 4 cause it's multiplied by 2
%cause it will torque twice from both sides (assumption) 
%it'll make sense if I show it

%c_eq
ceq = cl1/3+cf1/3+cf2/3; %cause they're fixed to the fixed world

%d_eq
deq = (d_air*(L^2 + Wf^2/2 + L2^2))/4;

%equivalent inertia final
Jeq = Meq*(t^2+W^2)/12 + Meq*d^2;

num = 1;
denum = [Jeq, deq, ceq];

sys = tf(num, denum);

bode(sys);
grid on;
title('Bode plot of G(s) = (1)/(s2 + ds + c)');


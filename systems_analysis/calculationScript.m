E = 210e9;
G = 69e9;


L = 0.05;
W = 0.075;
H = 0.1;
L2 = H/2;

Wl = 0.07;
t = 0.00015;
Wf = 0.06;

W_fold = W - Wf/2;
W_start = 0.01;
d = W_fold - W_start;


I_f1 = (Wf*L)*(Wf^2 + L^2)/12;
I_f2 = (Wf*L2)*(Wf^2 + L2^2)/12; %2 parameters cause of the cross section

J_f1 = Wf*t^3/3;
J_f2 = Wf*t^3/3;

O = deg2rad(5);

%this is the complicated one, M_bending_fold1 (fold 1 not case 1)
M_max1 = 2*E*J_f1*O*(2*L-3*d)/L^2 + L*6*E*J_f1*O*(2*d-L)/L^3; %this one
M_max2 = 2*E*J_f1*O*(2*L-3*d)/L^2 + 0*6*E*J_f1*O*(2*d-L)/L^3; 

stressb1 = M_max1*Wf/(2*I_f1)

%M_max2 is much higher and that means meaning M_max is at x = L


%now for the 2nd folded leaf spring in the up and down face rotation

M_max3 = -2*E*J_f2*O/L2 + 6*E*J_f2*O/L2; %this one
M_max4 = -2*E*J_f2*O/L2 + 0*6*E*J_f2*O/L2^2;

M_max3 = -2*E*J_f2*O*d/L2^2 + 2*6*E*J_f2*O*d/L2^2;
M_max4 = -2*E*J_f2*O*d/L2^2 + 0*6*E*J_f2*O*d/L2^2; %this one

stressb2 = M_max3*Wf/(2*J_f2);
stressb2 = M_max3*Wf/(2*J_f2)

taoMax1 = (Wf/2)*O*L/(G*J_f1^2)
taoMax2 = (Wf/2)*O*L2/(G*J_f2^2)

maxstress1 = sqrt(stressb1^2+3*taoMax1^2)
maxstress2 = sqrt(stressb2^2+3*taoMax2^2)
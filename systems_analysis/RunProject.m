    %(L W LeafWidth) LeafThickness LeafWidthFold (distFoldFromEdge W_start
    %thicknessRb)
%{
    LeafThickness = x_opt(1);
    LeafWidthFold = x_opt(2);
    LeafWidth = x_opt(3);
    lengthAboveGround = x_opt(4);
    LeafThicknessFold = x_opt(5);


%}
clear
clc

which('spacar'); 

%L W Dim3 LEAFW LeafT leafW_fold W_fold W_start
% x_min = [5e-2, 5e-2, 9.9e-2, 0.3e-2, 0.03e-2, 0.03e-2, 0, 1, 0, 1, 0];
% x_max = [10e-2, 10e-2, 10e-2, 0.7e-2, 0.07e-2, 0.07e-2, 7, 8, 9, 10, 9];

%final optimization rounds
x_min = [0.6e-2, 0.03e-2, 0.3e-2];
x_max = [0.7e-2, 0.07e-2, 0.7e-2];

%X initial 17/10/2025
%x_init = [0.0743766802555907, 0.0753986639072307, 0.0999999951056491, 0.01, 0.00100000000000, 0.01000000000, 4.54314280398522, 6.90837632028693, 8.04969972280121, 8.83031793066851, 7.83031793070020];

%X_initial 18/10/2025
x_init = [0.00650    0.0004    0.0065];
[x_opt, minStress] = fmincon(@Project55, x_init, [], [], [], [], x_min, x_max, @anotha, optimoptions('fmincon', 'Display', 'iter'));

[c, ~, model] = anotha(x_opt);

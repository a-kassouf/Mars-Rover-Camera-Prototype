disp("DFT script manually without matlab help");


%% 
disp("this section gets you the uks");

N = 16;
Ts = 1/2;

Tm = N * Ts;

u = @(t) 3*sin(2*pi*t/Tm);

for k=0:(N-1)
    tk = Ts*k;
    uk = u(tk);
    uk = round(uk, 1);
    disp("t"+ num2str(k)+ " is: "+ num2str(tk)+ " ---- u"+ num2str(k)+ " is: "+ num2str(uk));
end


%%
disp("power and energy of a DFT: ")


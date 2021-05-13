clc;

t = linspace(0.0,Ts*length(reference),length(reference));
solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

Pyc_uc = tf([1],[0.1 1]);
Pyt_ut = tf([1],[0.2 1]);
Pyt_uc = tf([-0.2],[0.1 1]);
Pyc_ut = tf([-0.1],[0.2 1]);

a11 = randn();
a12 = randn();
b11 = randn();
b12 = randn();

a21 = randn();
a22 = randn();
b21 = randn();
b22 = randn();

% Kd_c = 5+5*randn();
% Kp_c = 5+5*randn();
% Tc_c = 5+5*randn();
% PD_c = tf([Kd_c Kp_c], [1 Tc_c]);
PD_c = tf([a11 a12],[b11 b12]);

% Kd_t = 5+5*randn();
% Kp_t = 5+5*randn();
% Tc_t = 5+5*randn();
% PD_t = tf([Kd_t Kp_t], [1 Tc_t]);
PD_t = tf([a21 a22],[b21 b22]);

Gyc_rc = (PD_c*Pyc_uc+PD_c*PD_t*(Pyc_uc*Pyt_ut - Pyc_ut*Pyt_uc)) / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);
Gyc_rt = PD_t*Pyc_ut / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);

% Gyt_rt = (PD_t*Pyt_ut+PD_c*PD_t*(Pyc_uc*Pyt_ut - Pyc_ut*Pyt*uc)) / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);
% Gyt_rc = PD_c*Pyt_uc / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);

[A,B,C,D] = ssdata(Gyc_rc);
IC = zeros(16,1);
[T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
yc_rc = C*X.';

[A,B,C,D] = ssdata(Gyc_rt);
IC = zeros(10,1);
[T,X] = ode45(@rollout,t,IC,solverOptions,A,B,ones(1,length(reference)),Ts);
yc_rt = C*X.';

yc = yc_rc + yc_rt;

clf; plot(yc); hold on; plot(reference,'--'); ylim([0,1.2]);
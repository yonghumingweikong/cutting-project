clc; close all;

P = tf(1,[0.1 1]);
P0 = tf(1,[0.1 1]); % Internal model matches the true process
L = 1;
s = zpk('s');
delay = exp(-L*s);

Kp = 3;
Kd = 1;
Tc = 0.001;
C0 = tf([Kd Kp],[1 Tc]); % PD controller + Low-pass filter

Cpred = 1 / (1 + C0*P0*(1 - delay));
% C = C0*Cpred;
% bode(Cpred);

Gyr = (P0*C0)*delay/(1+P0*C0);

y = zeros(1,length(reference));
[A,B,C,D] = ssdata(Gyr);
t = linspace(0.0,Ts*length(reference),length(reference));
IC = zeros(4,1);
solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);
[T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
y = C*X.';

figure; plot(y); hold on; plot(reference,'--'); ylim([0,1.2]); grid on;
figure; bode(Gyr); grid on;
clf; clc;

a1 = randn();
a2 = randn();
b1 = randn();
b2 = randn();
Td = 20;

N = length(a1);
L = length(reference);
y = zeros(N,L);
s = zpk('s');
P0 = 1 + tf([1],[0.1 1]);
t = linspace(0.0,Ts*length(reference),length(reference));
solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

C0 = 1 + tf([a1 a2],[b1 b2]);
delay = exp(-Td*s);

Gyr = (P0*C0)*delay/(1+P0*C0);
% figure; bode(Gyr); grid on;

[A,B,C,D] = ssdata(Gyr);
IC = zeros(4,1);
[T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
y = C*X.';

plot(y); hold on; plot(reference,'--'); ylim([0,1.2]);
clc; close all;
solverOptions = odeset('RelTol', 1e-3, 'AbsTol', 1e-5);

E = 1; % elastic modulus
eta = 0.25; % viscosity
Gfe = tf([eta 0],[eta/E 1]); % strain to force transfer function
Gef = tf([eta/E 1],[eta 0]); % force to strain transfer function

force = profiles(1,:);
% figure; plot(force); grid on;

% Infer the applied strain, given the forces
[A,B,C,D] = ssdata(Gef);
IC = 0;
[T,X] = ode45(@rollout,t,IC,solverOptions,A,B,force,Ts);
strain = C*X.';
figure; plot(strain,'--'); hold on; plot(strain_sim(:,2)); grid on;
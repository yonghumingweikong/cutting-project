clc; close all;

E = 1; % elastic modulus
eta = 0.25; % viscosity
Gfe = tf([eta 0],[eta/E 1]); % strain to force transfer function
Gef = tf([eta/E 1],[eta 0]); % force to strain transfer function

figure; hold on;
for i = 1:12
    force = profiles_12(i,:);

    % Infer applied strain profile
    tspan = linspace(0.0,Ts*length(force),length(force));
    ic = 0;
    opts = odeset('RelTol', 1e-5, 'AbsTol', 1e-5, 'MaxStep', 0.0333);
    [A,B,C,D] = ssdata(Gef);
    ut = linspace(0.0,Ts*length(force),length(force));
    [t,x] = ode45(@(t,x) myode(t,x,A,B,ut,force), tspan, ic, opts);
    strain = C*x.' + D*force;
    plot(strain); % hold on; plot(out.strain_sim.data); grid on; 
    
    writematrix(force,'./data/student_12_force_'+string(i)+'.csv')
    writematrix(strain,'./data/student_12_strain_'+string(i)+'.csv')
end
title('Strain (Student #11)'); 

% figure; hold on;
% for i = 121:132
%     force = profiles(i,:);
%     plot(force)
% end
% title('Force (Student #11)'); 

    % Check if the recovered strain can reconstruct the same force profile
%     tspan = linspace(0.0,Ts*length(strain),length(strain));
%     ic = 0;
%     opts = odeset('RelTol', 1e-5, 'AbsTol', 1e-5, 'MaxStep', 0.0333);
%     [A,B,C,D] = ssdata(Gfe);
%     ut = linspace(0.0,Ts*length(strain),length(strain));
%     [t,x] = ode45(@(t,x) myode(t,x,A,B,ut,strain), tspan, ic, opts);
%     force_hat = C*x.' + D*strain;
%     figure; plot(force); hold on; plot(force_hat,'--'); grid on;
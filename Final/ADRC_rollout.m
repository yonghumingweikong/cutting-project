function [y] = ADRC_rollout(Kp,Kd,l1,l2,l3,b0,reference,Ts)

    N = length(Kp);
    L = length(reference);
    y = zeros(N,L);

    % Plant
    %P = tf(1,[1 0]);
    
    E = 1; % elastic modulus
    eta = 0.25; % viscosity
    P = tf([eta],[eta/E 1 0]); % strain to force transfer function x double integrator

    for i = 1:N
        
        Ki = (1.0/b0(i))*(Kp(i)*l3(i))/(Kp(i)+Kd(i)*l1(i)+l2(i));
        alpha1 = (Kd(i)+l1(i))/(Kp(i)+Kd(i)*l1(i)+l2(i));
        alpha2 = 1.0/(Kp(i)+Kd(i)*l1(i)+l2(i));
        beta1 = (l2(i)/l3(i) + Kd(i)/Kp(i));
        beta2 = l1(i)/l3(i) + (Kd(i)/Kp(i))*(l2(i)/l3(i)) + 1/Kp(i);
        gamma1 = l2(i)/l3(i);
        gamma2 = l1(i)/l3(i);
        
        Cfb = tf([Ki*beta2 Ki*beta1 Ki],[alpha2 alpha1 1 0]);
        Cpf = tf([gamma2 gamma1 1],[beta2 beta1 1]);
        Cff = tf([Ki 0 0],[l3(i)*alpha2 l3(i)*alpha1 l3(i)]);
        
        Gyr = (P*Cff + P*Cfb*Cpf)/(1+P*Cfb);
        %Gyd = P / (1 + P*Cfb);

        [A,B,C,D] = ssdata(Gyr);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(16,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        y(i,:) = C*X.';
        
    end

end
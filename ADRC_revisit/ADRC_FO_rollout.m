function [y] = ADRC_FO_rollout(Kp,l1,l2,b0,reference,Ts)

    N = length(Kp);
    L = length(reference);
    y = zeros(N,L);

    E = 1; % elastic modulus
    eta = 0.25; % viscosity
    P = tf([eta 0],[eta/E 1]); % strain to force transfer function
    
    reference_n = reference + randn(1,180);

    for i = 1:N
        
        alpha = 1/(Kp(i)+l1(i));
        beta = (l1(i)/l2(i)) + 1/Kp(i);
        gamma = l1(i)/l2(i);
        Ki = (1/b0(i))*Kp(i)*l2(i)/(Kp(i)+l1(i));
        
        Cfb = tf([Ki*beta Ki],[alpha 1 0]);
        Cpf = tf([gamma 1],[beta 1]);
        Cff = tf([Ki 0],[l2(i)*alpha l2(i)]);
        
        Gyr = (P*Cff + P*Cfb*Cpf)/(1+P*Cfb);
        Gyd = P / (1 + P*Cfb);

        [A,B,C,D] = ssdata(Gyr);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(9,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference_n,Ts);
        y(i,:) = C*X.';
        
    end

end
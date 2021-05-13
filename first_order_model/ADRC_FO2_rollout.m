function [y] = ADRC_FO2_rollout(Kp_1,l1_1,l2_1,b0_1,Kp_2,l1_2,l2_2,b0_2,reference,reference2,Ts)

    N = length(Kp_1);
    L = length(reference);
    y_1 = zeros(N,L);
    y_2 = zeros(N,L);

    P = tf(1,[0.1 1]);

    for i = 1:N
        
        alpha_1 = 1/(Kp_1(i)+l1_1(i));
        beta_1 = (l1_1(i)/l2_1(i)) + 1/Kp_1(i);
        gamma_1 = l1_1(i)/l2_1(i);
        Ki_1 = (1/b0_1(i))*Kp_1(i)*l2_1(i)/(Kp_1(i)+l1_1(i));
        
        Cfb_1 = tf([Ki_1*beta_1 Ki_1],[alpha_1 1 0]);
        Cpf_1 = tf([gamma_1 1],[beta_1 1]);
        Cff_1 = tf([Ki_1 0],[l2_1(i)*alpha_1 l2_1(i)]);
        
        Gyr_1 = (P*Cff_1 + P*Cfb_1*Cpf_1)/(1+P*Cfb_1);

        [A,B,C,D] = ssdata(Gyr_1);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(9,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        y_1(i,:) = C*X.';
        
        
        alpha_2 = 1/(Kp_2(i)+l1_2(i));
        beta_2 = (l1_2(i)/l2_2(i)) + 1/Kp_2(i);
        gamma_2 = l1_2(i)/l2_2(i);
        Ki_2 = (1/b0_2(i))*Kp_2(i)*l2_2(i)/(Kp_2(i)+l1_2(i));
        
        Cfb_2 = tf([Ki_2*beta_2 Ki_2],[alpha_2 1 0]);
        Cpf_2 = tf([gamma_2 1],[beta_2 1]);
        Cff_2 = tf([Ki_2 0],[l2_2(i)*alpha_2 l2_2(i)]);
        
        Gyr_2 = (P*Cff_2 + P*Cfb_2*Cpf_2)/(1+P*Cfb_2);

        [A,B,C,D] = ssdata(Gyr_2);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(9,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference2,Ts);
        y_2(i,:) = C*X.';
        
        y = y_1 + y_2;
        
    end

end
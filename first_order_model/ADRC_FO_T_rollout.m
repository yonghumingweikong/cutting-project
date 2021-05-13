function [y] = ADRC_FO_T_rollout(Kp,l1,l2,b0,Kp_T,Kd_T,Tc_T,reference,Ts)

    N = length(Kp);
    L = length(reference);
    y = zeros(N,L);

    P = tf(1,[0.1 1]);

    for i = 1:N
        
        alpha = 1/(Kp(i)+l1(i));
        beta = (l1(i)/l2(i)) + 1/Kp(i);
        gamma = l1(i)/l2(i);
        Ki = (1/b0(i))*Kp(i)*l2(i)/(Kp(i)+l1(i));
        
        Cfb = tf([Ki*beta Ki],[alpha 1 0]);
        Cpf = tf([gamma 1],[beta 1]);
        Cff = tf([Ki 0],[l2(i)*alpha l2(i)]);
        Ct = tf([Kd_T(i) Kp_T(i)/Kd_T(i)],[1 Tc_T(i)]);
        
        Gyr = (Cff*P + Cpf*Cfb*P + Cpf*Ct*P) / (1 + Cfb*P + Ct*P);

        [A,B,C,D] = ssdata(Gyr);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(14,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        y(i,:) = C*X.';
    end

end
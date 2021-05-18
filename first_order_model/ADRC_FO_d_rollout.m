function [y] = ADRC_FO_d_rollout(Kp,l1,l2,b0,reference,Ts,d)

    N = length(Kp);
    L = length(reference);
    yr = zeros(N,L);
    yd = zeros(N,L);

    P = tf(1,[0.1 1]);

    for i = 1:N
        
%         d = lowpass(awgn(zeros(1,length(reference)),2),1,30);
        
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

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        yr(i,:) = C*X.';
        
        [A,B,C,D] = ssdata(Gyd);
        IC = zeros(4,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);
        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,d,Ts);
        yd(i,:) = C*X.';

        y = yr + yd;
    end

end
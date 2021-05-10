function [y] = ADRC_rollout(Kp,Kd,l1,l2,l3_,b0,reference,Ts)

    N = length(Kp);
    L = length(reference);
    y = zeros(N,L);

    P = tf([300],[1 20 300]);

    for i = 1:N
        
        fcoef = time2freq_coef([Kp(i),Kd(i),l1(i),l2(i),l3_(i),b0(i)]);
        
        a1 = fcoef(1);
        a2 = fcoef(2);
        b1 = fcoef(3);
        b2 = fcoef(4);
        g1 = fcoef(5);
        g2 = fcoef(6);
        Ki = fcoef(7);
        l3 = fcoef(8);
        
        Cfb = tf([Ki*b2 Ki*b1 Ki],[a2 a1 1 0]);
        Cpf = tf([g2 g1 1],[b2 b1 1]);
        Cff = tf([Ki 0 0],[l3*a2 l3*a1 l3]);
        G = (P*Cff + P*Cpf*Cfb)/(1+P*Cfb);

        [A,B,C,D] = ssdata(G);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(16,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        y(i,:) = C*X.';
    end

end
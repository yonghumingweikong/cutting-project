function [y] = ADRC_TF_rollout(a1,a2,b1,b2,g1,g2,Ki,l3,reference,Ts)

    N = length(a1);
    L = length(reference);
    y = zeros(N,L);

    P = tf([300],[1 20 300]);

    for i = 1:N
        Cfb = tf([Ki(i)*b2(i) Ki(i)*b1(i) Ki(i)],[a2(i) a1(i) 1 0]);
        Cpf = tf([g2(i) g1(i) 1],[b2(i) b1(i) 1]);
        Cff = tf([Ki(i) 0 0],[l3(i)*a2(i) l3(i)*a1(i) l3(i)]);
        G = (P*Cff + P*Cpf*Cfb)/(1+P*Cfb);

        [A,B,C,D] = ssdata(G);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(16,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        y(i,:) = C*X.';
    end

end
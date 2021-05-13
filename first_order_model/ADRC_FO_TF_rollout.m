function [y] = ADRC_FO_TF_rollout(alpha,beta,gamma,Ki,l2,reference,Ts)

    N = length(alpha);
    L = length(reference);
    y = zeros(N,L);

    P = tf(1,[0.1 1]);

    for i = 1:N
        
        Cfb = tf([Ki(i)*beta(i) Ki(i)],[alpha(i) 1 0]);
        Cpf = tf([gamma(i) 1],[beta(i) 1]);
        Cff = tf([Ki(i) 0],[l2(i)*alpha(i) l2(i)]);
        
        Gyr = (P*Cff + P*Cfb*Cpf)/(1+P*Cfb);

        [A,B,C,D] = ssdata(Gyr);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(9,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        y(i,:) = C*X.';
    end

end
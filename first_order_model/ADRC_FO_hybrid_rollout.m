function [y] = ADRC_FO_hybrid_rollout(Kp,l1,l2,b0,tau,T,reference,Ts)

    N = length(Kp);
    L = length(reference);
    y = zeros(N,L);

    P = tf(1,[0.1 1]);

    for i = 1:N
        tau(i) = ceil(tau(i));
        T(i) = ceil(T(i));
        ref = reference;
        ref(tau(i):end) = 0;
        if tau(i)+T(i) < length(reference)
            ref(tau(i)+T(i):end) = reference(1:length(reference)-(tau(i)+T(i))+1);
        end
            
        alpha = 1/(Kp(i)+l1(i));
        beta = (l1(i)/l2(i)) + 1/Kp(i);
        gamma = l1(i)/l2(i);
        Ki = (1/b0(i))*Kp(i)*l2(i)/(Kp(i)+l1(i));
        
        Cfb = tf([Ki*beta Ki],[alpha 1 0]);
        Cpf = tf([gamma 1],[beta 1]);
        Cff = tf([Ki 0],[l2(i)*alpha l2(i)]);
        
        Gyr = (P*Cff + P*Cfb*Cpf)/(1+P*Cfb);

        [A,B,C,D] = ssdata(Gyr);

        t = linspace(0.0,Ts*length(reference),length(reference));
        IC = zeros(9,1);
        solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,ref,Ts);
        y(i,:) = C*X.';
    end

end
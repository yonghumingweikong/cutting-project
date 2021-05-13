function [y] = smith_rollout(a1,a2,b1,b2,Td,reference,Ts)

    N = length(a1);
    L = length(reference);
    y = zeros(N,L);
    s = zpk('s');
    P0 = tf([1],[0.1 1]);
    t = linspace(0.0,Ts*length(reference),length(reference));
    solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

    for i = 1:N
        
        C0 = 1 + tf([a1(i) a2(i)],[b1(i) b2(i)]);
        delay = exp(-Td(i)*s);

        Gyr = (P0*C0)*delay/(1+P0*C0);

        [A,B,C,D] = ssdata(Gyr);
        IC = zeros(4,1);
        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
        y = C*X.';
        
    end

end
function y = plant_open_loop(u,Ts)
    
    P = tf([300],[1 20 300]);
    t = linspace(0.0,Ts*length(u),length(u));
    solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);
    
    [A,B,C,D] = ssdata(P);
    IC = zeros(2,1);
    [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,u,Ts);
    y = C*X.';

end
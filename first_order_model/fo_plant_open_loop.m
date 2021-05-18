function y = fo_plant_open_loop(u,P,Ts)
    
    t = linspace(0.0,Ts*length(u),length(u));
    solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);
    
    [A,B,C,D] = ssdata(P);
    IC = zeros(1,height(A));
    [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,u,Ts);
    y = C*X.';

end
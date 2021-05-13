function [yc] = mimo_rollout(a11,a12,b11,b12,a21,a22,b21,b22,reference_c,reference_t,Ts)

    N = length(a11);
    L = length(reference_c);
    yc = zeros(N,L);
    
    Pyc_uc = tf([1],[0.1 1]);
    Pyt_ut = tf([1],[0.2 1]);
    Pyt_uc = tf([-0.2],[0.1 1]);
    Pyc_ut = tf([-0.1],[0.2 1]);
    
    t = linspace(0.0,Ts*length(reference_c),length(reference_c));
    solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

    for i = 1:N
        
        PD_c = tf([a11(i) a12(i)],[b11(i) b12(i)]);
        PD_t = tf([a21(i) a22(i)],[b21(i) b22(i)]);

        Gyc_rc = (PD_c*Pyc_uc+PD_c*PD_t*(Pyc_uc*Pyt_ut - Pyc_ut*Pyt_uc)) / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);
        Gyc_rt = PD_t*Pyc_ut / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);

        % Gyt_rt = (PD_t*Pyt_ut+PD_c*PD_t*(Pyc_uc*Pyt_ut - Pyc_ut*Pyt*uc)) / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);
        % Gyt_rc = PD_c*Pyt_uc / ((1+PD_c*Pyc_uc)*(1+PD_t*Pyt_ut) - PD_c*PD_t*Pyc_ut*Pyt_uc);

        [A,B,C,D] = ssdata(Gyc_rc);
        IC = zeros(16,1);
        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference_c,Ts);
        yc_rc = C*X.';

        [A,B,C,D] = ssdata(Gyc_rt);
        IC = zeros(10,1);
        [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference_t,Ts);
        yc_rt = C*X.';

        yc = yc_rc + yc_rt;
        
    end

end
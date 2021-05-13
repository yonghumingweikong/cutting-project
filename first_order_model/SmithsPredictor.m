clc; clf;

for i = 1:5
    a1 = randn();
    a2 = randn();
    a3 = randn();
    b1 = randn();
    b2 = randn();
    b3 = randn();

    P0 = tf([1],[0.1 1]);
    C0 = tf([a1 a2 a3],[b1 b2 b3]);
    L = abs(10*randn());
    s = zpk('s');
    delay = exp(-L*s);

    Cpred = 1 / (1 + C0*P0*(1 - delay));
    C = C0*Cpred;
    % bode(Cpred);

    Gyr = (P0*C0)*delay/(1+P0*C0);
    % bode(Gyr); grid on;

    y = zeros(1,length(reference));
    [A,B,C,D] = ssdata(Gyr);
    t = linspace(0.0,Ts*length(reference),length(reference));
    IC = zeros(6,1);
    solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);
    [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
    y = C*X.';
    plot(y); hold on; plot(reference,'--'); ylim([0,1.2]);
end
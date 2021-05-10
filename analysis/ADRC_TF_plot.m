function ADRC_TF_plot(coef,reference,actual,Ts)

    t = linspace(0.0,Ts*length(reference),length(reference));
    solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

    P = tf([300],[1 20 300]);
    
    % coef = [a1,a2,b1,b2,g1,g2,Ki,l3]
    Cfb = tf([coef(7)*coef(4) coef(7)*coef(3) coef(7)],[coef(2) coef(1) 1 0]);
    Cpf = tf([coef(6) coef(5) 1],[coef(4) coef(3) 1]);
    Cff = tf([coef(7) 0 0],[coef(8)*coef(2) coef(8)*coef(1) coef(8)]);
    Gyr = (P*Cff + P*Cpf*Cfb)/(1+P*Cfb);
    
    IC = zeros(16,1);
    [A,B,C,D] = ssdata(Gyr);
    [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
    y = C*X.';

    figure; plot(y); grid on; hold on; plot(reference,'--','Color',[0.8 0.8 0.8]); plot(actual,'--'); legend('y','reference','actual');
    figure; plot(actual-y); grid on; title('residuals');

end
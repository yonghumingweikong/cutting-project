function [y,res,t] = ADRC_plot(tcoef,reference,actual,Ts)

    t = linspace(0.0,Ts*length(reference),length(reference));
    solverOptions = odeset('RelTol', 1e-5, 'AbsTol', 1e-5);

    P = tf([300],[1 20 300]);
    
    fcoef = time2freq_coef(tcoef);
    
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
    Gyr = (P*Cff + P*Cpf*Cfb)/(1+P*Cfb);
    
    IC = zeros(16,1);
    [A,B,C,D] = ssdata(Gyr);
    [T,X] = ode45(@rollout,t,IC,solverOptions,A,B,reference,Ts);
    y = C*X.';
    
    res = actual - y;

    figure; plot(y); grid on; hold on; plot(reference,'--','Color',[0.9 0.9 0.9]); plot(actual,'--'); legend('y','reference','actual');
    figure; plot(res); grid on; title('residuals');

end
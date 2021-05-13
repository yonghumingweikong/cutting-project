function plot_fo(coef,reference,actual,Ts)
    
    y_hat = ADRC_FO_rollout(coef(1),coef(2),coef(3),coef(4),reference,Ts);
    plot(y_hat);

end
function plot_pulse_fit(coef,profile,Ts)

    Pulse = pulse3(coef(1,:),180);
    y_hat = pulse_rollout3(coef(1),coef(2),coef(3),coef(4),...
        coef(5),coef(6),coef(7),coef(8),coef(9),...
        coef(10),coef(11),coef(12),coef(13),coef(14),...
        coef(15),coef(16),coef(17),coef(18),coef(19), ...
        coef(20),180,Ts);
    figure; plot(Pulse,'--'); hold on; plot(profile); plot(y_hat); grid on;

end
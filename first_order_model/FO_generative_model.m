close all; clc;
% [reference,profiles_1,Ts] = load_transient_dataset('student01');

figure; hold on;
for i = 1:20
    Kp = 5;
    l1 = randn();
    l2 = randn();
    b0 = 1+randn();

    y_hat = ADRC_FO_rollout(Kp,l1,l2,b0,reference,Ts);
    plot(y_hat);
    ylim([0,1.2]);
end
close all; clc;

P = tf([10],[1 4 10]);
indx = 12:12:144;

% figure; bar(squeeze(distr(student,1,:))); title('Ground truth = '+string(student));

pulse = pulse3(test_data(3,:),180);
y_hat = fo_plant_open_loop(pulse,P,Ts);

for student = 1:12
    figure; hold on; title('Student 1 vs Student '+string(student)+' distribution'); 
    plot(y_hat,'LineWidth',2); ylim([-0.4,1.2]);

    pulse = pulse3(mu(student,:),180);
    y_mu = fo_plant_open_loop(pulse,P,Ts);
    plot(y_mu,'--','LineWidth',2); ylim([-0.4,1.2]);

    for i = indx(student)-11:indx(student)
        plot1 = plot(profiles(i,:)); plot1.Color(4) = 0.3;
    end
end
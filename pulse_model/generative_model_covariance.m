clc; close all;

P = tf([10],[1 4 10]);

indx = 12:12:144;

student = 12;

param_avg = mean(pulse_params(indx(student)-11:indx(student),:));
param_cov = cov(pulse_params(indx(student)-11:indx(student),:));

pulse_avg = pulse3(param_avg,180);

param_cov_ = param_cov + 0.0001*eye(length(param_cov));
L = chol(param_cov_,'lower'); 

N = 3;
pulse_gen = zeros(N,180);
for i = 1:N
    param_sample = randn(1,20);
    param_sample = param_avg.' + L*param_sample.';
    
    pulse_gen(i,:) = pulse3(param_sample,180);
end

% figure; hold on;
% plot(pulse_avg+pulse_std,'--k');
% plot(pulse_avg-pulse_std,'--k');
% for i = 1:N
%     plot(pulse_gen(i,:));
% end

figure; hold on; 
for i = 1:N
    y = fo_plant_open_loop(pulse_gen(i,:),P,Ts);
    plot(y,'LineWidth',2); 
end

for i = indx(student)-11:indx(student)
    plot1 = plot(profiles(i,:)); plot1.Color(4) = 0.3;
end
grid on;
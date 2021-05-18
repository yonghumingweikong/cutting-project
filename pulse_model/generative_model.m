% clc; close all;

P = tf([10],[1 4 10]);

indx = 12:12:144;
student = 1;

Pulse = zeros(12,180);
inc = 1;
for i = indx(student)-11:indx(student)
    Pulse(inc,:) = pulse3(pulse_params(i,:),180);
    inc = inc + 1;
end
pulse_avg = mean(Pulse);
pulse_std = std(Pulse);

N = 3;
pulse_gen = zeros(N,180);
figure; hold on;
plot(pulse_avg+pulse_std,'--k');
plot(pulse_avg-pulse_std,'--k');
for i = 1:N
    p_ = zeros(1,180);
    p_(1:8) = pulse_avg(1) + pulse_std(1)*randn();
    for j = 9:9:171
        p_(j:j+9) = pulse_avg(j) + pulse_std(j)*randn();
    end
    pulse_gen(i,:) = p_;
    plot1 = plot(p_);
end

figure; hold on; 
for i = 1:N
    y = fo_plant_open_loop(pulse_gen(i,:),P,Ts);
    plot(y,'LineWidth',2); 
end

for i = indx(student)-11:indx(student)
    plot1 = plot(profiles(i,:)); plot1.Color(4) = 0.3;
end
grid on;
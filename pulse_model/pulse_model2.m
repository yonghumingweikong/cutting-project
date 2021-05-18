clc; clf;

actual = profiles_1(3,:);

N = length(actual);
% P = tf([1],[1 1 1]);
P = tf([10],[1 4 10]);
pulse = zeros(1,N);

% p_num = ceil(6+20*rand());
p_num = 10;
px = ceil((2*N/p_num)*rand(1,p_num)); 
pa = 2*rand(1,p_num);

indx = zeros(1,p_num);
indx(1) = px(1);
for i = 2:p_num
    indx(i) = indx(i-1) + px(i);
end

pulse(1:indx(1)) = pa(1);
for i = 2:p_num
    pulse(indx(i-1):indx(i)) = pa(i);
end

y_hat = fo_plant_open_loop(pulse,P,Ts);

plot(y_hat(1:N),'--'); hold on; plot(actual); plot(pulse);

indx
pa
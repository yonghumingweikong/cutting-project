clc; clf;

actual = profiles_1(3,:);

N = length(actual);
% P = tf([1],[1 1 1]);
P = tf([10],[1 4 10]);
pulse = zeros(1,N);

% p_num = ceil(6+20*rand());
p_num = 5;
px = ceil(N*rand(1,p_num)); px(1) = 1;
pl = ceil(30+100*rand(1,p_num));
pa = 2*rand(1,p_num);

for i = 1:p_num
    pulse(px(i):px(i)+pl(i)) = pa(i);
end

y_hat = fo_plant_open_loop(pulse,P,Ts);

plot(y_hat(1:N),'--'); hold on; plot(actual); plot(pulse)
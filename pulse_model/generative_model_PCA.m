% clc; close all;

P = tf([10],[1 4 10]);

indx = 12:12:144;
N = 20;
pulse_gen = zeros(12,N,180);
y_gen = zeros(12,N,180);

for student = 1:12

    param_avg = mean(pulse_params(indx(student)-11:indx(student),:));
    param_cov = cov(pulse_params(indx(student)-11:indx(student),:));

    pulse_avg = pulse3(param_avg,180);

    param_cov_ = param_cov + 0.0001*eye(length(param_cov));
    L = chol(param_cov_,'lower'); 

    for i = 1:N
        param_sample = randn(1,20);
        param_sample = param_avg.' + L*param_sample.';

        pulse_gen(student,i,:) = pulse3(param_sample,180);
        y_gen(student,i,:) = fo_plant_open_loop(pulse_gen(student,i,:),P,Ts);
    end

end

pca_data = zeros(12*N,180);
inc = 1;
for student = 1:12
    for i = 1:N
        pca_data(inc,:) = squeeze(pulse_gen(student,i,:));
        inc = inc + 1;
    end
end

pca_data_norm = normalize(pca_data);
[coeff,score,latent,tsquared,explained] = pca(pca_data_norm);

figure; hold on; 
inc = 1;
mark = ['+','o','*','x','s','d','^','v','>','<','p','h'];
for student = 1:12
    scatter(score(student*N-(N-1):student*N,1),score(student*N-(N-1):student*N,2),mark(student)); % student 1
end
title('PCA'); grid on;
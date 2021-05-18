close all; clc;

M = 12; % Number of students
L = 180; % length of trajectory 
D = 20; % number of features (pulses)

% Dataset.
% Each student has 12 cuts. 10 cuts for training, 2 cuts for valuation.
N_train = 10; 
N_test = 2;
training_data = zeros(M*N_train, D);
test_data = zeros(M*N_test, D);

for student = 1:M
    
    student_cuts = pulse_params(student*12-11:student*12,:);
    student_cuts_rand = student_cuts(randperm(size(student_cuts, 1)), :);
    training_data(student*N_train-(N_train-1):student*N_train,:) = student_cuts_rand(1:10,:);
    test_data(student*N_test-(N_test-1):student*N_test,:) = student_cuts_rand(11:12,:);
    
end

% Training
prior = 1/M; 
mu = zeros(M,D);
covar = zeros(M,D,D);

for student = 1:M
    
    mu(student,:) = mean(training_data(student*N_train-(N_train-1):student*N_train,:));
    covar(student,:,:) = cov(training_data(student*N_train-(N_train-1):student*N_train,:));
    covar(student,:,:) = squeeze(covar(student,:,:)) + 0.0001*eye(length(covar));
    
end

close all; clc; rng(99);

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

ground_truth = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12];
train_labels = zeros(1,height(training_data));
for i = 1:12
    train_labels(10*i-9 : 10*i) = i;
end

Mdl = fitcnb(training_data,train_labels);
[labels, posterior, cost] = Mdl.predict(test_data);

% Training
prior = 1/M; 
mu = zeros(M,D);
sd = zeros(M,D);

for student = 1:M
    mu(student,:) = mean(training_data(student*N_train-(N_train-1):student*N_train,:));
    sd(student,:) = std(training_data(student*N_train-(N_train-1):student*N_train,:));
end
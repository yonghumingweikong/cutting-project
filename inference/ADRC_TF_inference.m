clc; close all;

N = height(profiles_2);
Param = zeros(N,8);
feval = zeros(1,N);

for i = 1:N
    
    M = find(profiles_2(i,:),1,'last');
    actual = profiles_2(i,1:M);
    
    L1 = @(x) sum( (abs(ADRC_TF_disturbance_rollout(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7),x(:,8),reference(1:M),Ts) ...
        - actual)).' ) / M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 3e-2, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 100, 'Generations', 100);

    % Defining variables limits
    l = -10*ones(1,8); u = 10*ones(1,8);

    % Applying the optimization method
    [X_opt, y_opt] = ceo_tf(L1, l, u, options, [], [], reference, actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
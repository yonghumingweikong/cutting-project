clc; close all;

N = height(profiles_1);
Param = zeros(N,8);
feval = zeros(1,N);

for i = 3:N
    
    reference2 = sinc_rollout(sinc_param(1),sinc_param(2),sinc_param(3),reference,Ts);
    
    M = find(profiles_1(i,:),1,'last');
    actual = profiles_1(i,1:M);

    L1 = @(x) sum( (abs(ADRC_FO2_rollout(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7),x(:,8),reference(1:M),reference2(1:M),Ts) ...
        - actual)).' ) / M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 1e-2, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 50, 'Generations', 100);

    % Defining variables limits
    l = [-100 -10 -10 -10 -100 -10 -10 -10]; u = [100 10 10 10 100 10 10 10];

    % Applying the optimization method
    [X_opt, y_opt] = ceo_fo2(L1, l, u, options, [], [], reference(1:M), reference2(1:M), actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
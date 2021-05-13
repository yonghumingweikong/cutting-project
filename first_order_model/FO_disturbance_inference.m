clc; close all;

N = height(profiles_1);
Param = zeros(N,4);
feval = zeros(1,N);

for i = 3:N
    
    M = find(profiles_1(i,:),1,'last');
    actual = profiles_1(i,1:M);

    L1 = @(x) sum( (abs(ADRC_FO_d_rollout(x(:,1),x(:,2),x(:,3),x(:,4),reference(1:M),Ts) ...
        - actual)).' ) / M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 5e-0, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 100, 'Generations', 50);

    % Defining variables limits
    l = [-100 -100 -100 -10]; u = [100 100 100 10];

    % Applying the optimization method
    [X_opt, y_opt] = ceo_fo_d(L1, l, u, options, [], [], reference(1:M), actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
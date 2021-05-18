clc; close all;

N = height(profiles_1);
Param = zeros(N,6);
feval = zeros(1,N);

for i = 9:N
    
    M = find(profiles_1(i,:),1,'last');
    actual = profiles_1(i,1:M);

    L1 = @(x) sum( (abs(ADRC_FO_hybrid_rollout(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),reference_c(1:M),Ts) ...
        - actual)).' ) / M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 1e-1, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 50, 'Generations', 100);

    % Defining variables limits
    l = [-100 -10 -10 -10 1 1]; u = [100 10 10 10 M 50];

    % Applying the optimization method
    [X_opt, y_opt] = ceo_fo_hybrid(L1, l, u, options, [], [], reference_c(1:M), actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
clc; close all;

N = height(profiles_1);
Param = zeros(N,5);
feval = zeros(1,N);

for i = 3:N
    
    M = find(profiles_1(i,:),1,'last');
    actual = profiles_1(i,1:M);

    L1 = @(x) sum( (abs(smith_rollout(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),reference(1:M),Ts) ...
        - actual)).' ) / M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 5e-2, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 100, 'Generations', 100);

    % Defining variables limits
    l = [-10 -10 -10 -10 0.1]; u = [10 10 10 10 10];

    % Applying the optimization method
    [X_opt, y_opt] = ceo_smith(L1, l, u, options, [], [], reference(1:M), actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
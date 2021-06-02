clc; close all;

N = height(profiles_1);
Param = zeros(N,3);
feval = zeros(1,N);

for i = 1:1
    
    M = length(profiles_1(i,:));
    % actual = strain_actual;
    actual = profiles_1(i,:);

    L1 = @(x) sum( (abs(PID_rollout(x(:,1),x(:,2),x(:,3),force_reference(1:M),Ts) ...
        - actual)).' ) / M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 1e-3, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 50, 'Generations', 100);

    % Defining variables limits
    l = [-10 -10 -10]; u = [10 10 10];

    % Applying the optimization method
    [X_opt, y_opt] = ceo_PID(L1, l, u, options, [], [], force_reference(1:M), actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
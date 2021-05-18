clc; close all;

N = height(profiles_12);
Param = zeros(N,20);
feval = zeros(1,N);

for i = 1:N
    
    M = 180;
    actual = profiles_12(i,:);

    L1 = @(x) sum( ( abs(pulse_rollout2(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5), ...
        x(:,6),x(:,7),x(:,8),x(:,9),x(:,10),x(:,11),x(:,12), ... 
        x(:,13),x(:,14),x(:,15),x(:,16),x(:,17),x(:,18),x(:,19),x(:,20),M,Ts) - actual)).' )/M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 1e-0, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 100, 'Generations', 100);

    % Defining variables limits
    l = [1 1 1 1 1 1 1 1 1 1 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2]; 
    u = [2*M/10 2*M/10 2*M/10 2*M/10 2*M/10 2*M/10 2*M/10 2*M/10 2*M/10 2*M/10 ...
         2 2 2 2 2 2 2 2 2 2];

    % Applying the optimization method
    [X_opt, y_opt] = ceo_pulse2(L1, l, u, options, [], [], M, actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
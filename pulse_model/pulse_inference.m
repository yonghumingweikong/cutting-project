clc; close all;

N = height(profiles_5);
Param = zeros(N,14);
feval = zeros(1,N);

for i = 1:N
    
    M = find(profiles_5(i,:),1,'last');
    actual = profiles_5(i,1:M);

    L1 = @(x) sum( ( abs(pulse_rollout(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5), ...
        x(:,6),x(:,7),x(:,8),x(:,9),x(:,10), ... 
        x(:,11),x(:,12),x(:,13),x(:,14),M,Ts) - actual)).' )/M;
    
%     L2 = @(x) sum( ( (pulse_rollout(x(:,1),x(:,2),x(:,3),x(:,4), ...
%         x(:,5),x(:,6),x(:,7),x(:,8), ... 
%         x(:,9),x(:,10),x(:,11),x(:,12),M,Ts) - actual).^2).' ) / M;

    % Setting options
    options = ceoptdef('ConvergenceLimit', 1e-0, 'SmoothingType', 'fixed', 'EliteRatio', 0.1, ...
                       'Display', 'iter', 'PopulationSize', 100, 'Generations', 100);

    % Defining variables limits
    l = [1 1 1 1 30 30 30 30 30 -0.2 -0.2 -0.2 -0.2 -0.2]; u = [M M M M 100 100 100 100 100 2 2 2 2 2];

    % Applying the optimization method
    [X_opt, y_opt] = ceo_pulse(L1, l, u, options, [], [], M, actual, Ts);
    
    Param(i,:) = X_opt;
    feval(i) = y_opt;
    
end
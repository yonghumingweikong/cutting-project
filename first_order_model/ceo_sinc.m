function [X_opt, y_opt, time, flag] = ceo_sinc(f, l, u, options, g, gamma, reference, actual, Ts)
%SOCE Cross-entropy single-objective optimization
%   Applies the cross-entropy method to a single-objective optimization 
%   problem
%
%   Syntax:
%      [X_opt, y_opt, time, flag] = SOCE(f, l, u, options, g, gamma)
%
%   Arguments:
%      f [function reference or inline function] Objective functions. It
%         must return a scalar value.
%      l [real, n-values vector] Lower bound of the decision variables.
%      u [real, n-values vector] Upper bound of the decision variables.
%      options [structure] Optimization options. It can be defined by using
%         the function CEOPTDEF.
%      g [function reference or inline function]. Constraints functions. It
%         must return a p-values vector. For unconstrained problems this
%         argument should be empty.
%      gamma [real, p-values vector] Constraints penalty factors. For
%         unconstrained problems this argument should be empty.
%
%   Outputs:
%      x_opt [real, n-values vector] Values of the decision variables at the
%         optimal point
%      y_opt [real, scalar] Value of the objective function at the optimal point.
%      time [real, scalar] Execution time
%      flag [string] Text describing why the program stopped.
% 
%   Ref.: Rubinstein, R.Y.; Kroese, D.P., 2004. "A Tutorial Introduction 
%         to the Cross-Entropy Method�. The Cross-Entropy Method. New York:
%         Springer, ISBN 978-1-4419-1940-3, pp. 29-58.
%
%   Cross-Entropy Optimisation Toolbox
%   (c) 2018, GAMHE <http://www.gamhe.eu> and CEFAS <http://cefas.umcc.cu>
%

   % Verifying the arguments values (F)
   if (nargin < 1), error('Not enough input arguments.'); end
   if isempty(f), error('Argument ''f'' should not be empty.'); end
   if ~(isa(f, 'function_handle') || isa(f, 'inline')), error('Argument ''f'' should be a function reference or an inline funtion.'); end
   % L
   if (nargin < 2), error('Not enough input arguments.'); end
   if isempty(l), error('Argument ''l'' should not be empty.'); end
   if ~isnumeric(l), error('Argument ''l'' should be a numeric value.'); end
   if (size(l, 1) > 1), error('Argument ''l'' should be a single row vector.'); end
   % U
   if (nargin < 3), error('Not enough input arguments.'); end
   if isempty(u), error('Argument ''u'' should not be empty.'); end
   if ~isnumeric(u), error('Argument ''u'' should be a numeric value.'); end
   if (size(u, 1) > 1), error('Argument ''u'' should be a single row vector.'); end
   if ~(all(size(l) == size(u))), error('Arguments ''l'' and ''u'' should be vectors with the same length.'); end
   if any(u <= l), error('All values of argument ''u'' must be higher than the corresponding values of ''l''.'); end
   % OPTIONS
   if (nargin < 4), options = ceoptdef(); end
   if isempty(options), error('Argument ''options'' should not be empty.'); end
   if ~isstruct(options), error('Argument ''options'' should be a structure.'); end
   includedFields = { 'Generations', 'PopulationSize', 'EliteRatio', ...
                      'Display', 'ConvergenceLimit', 'Alpha', 'Beta', ...
                      'ExpFactor', 'SmoothingType' };
   for i = 1 : length(includedFields)
      if ~isfield(options, includedFields{i}), error(['Argument ''options'' should contain a field called ''', includedFields{i}, '''.']); end
   end
   % G
   if (nargin < 5), g = []; end
   if ~(isempty(g) || isa(g, 'function_handle') || isa(g, 'inline')), error('Argument ''g'' should be a function reference or an inline funtion.'); end
   % GAMMA
   if (nargin < 6), gamma = []; end
   if (isempty(gamma) && ~isempty(g)), error('Argument ''gamma'' should not be empty if argument G is not.'); end
   if ~isempty(g)
      if ~isnumeric(gamma), error('Argument ''gamma'' should be a numeric value.'); end
      if (size(g, 1) > 1), error('Argument ''gamma'' should be a single row vector.'); end
   end

   % Computing the number of decision variables and constraints
   n = length(l);
   p = length(gamma);
   
   % Loading options
   N = options.Generations;
   Z = options.PopulationSize;
   rho = options.EliteRatio;
   Ne = ceil(rho.*Z);
   display = options.Display;
   epsilon_max = options.ConvergenceLimit;
   alpha = options.Alpha;
   beta = options.Beta;
   q = options.ExpFactor;
   smoothingType = options.SmoothingType;

   % Initialization
   sigma(1 : n) = 2.*(u - l);
   mu(1 : n) = l + rand(1, n).*(u - l);
   mu_last = mu;
   sigma_last = sigma;
   X_opt = zeros(1, n);
   f_opt = Inf;
   t = 0;
   Q = zeros(Z, n + 1);
   time = now;
   if (strcmpi(display, 'iter'))
       fprintf('Generation  Evaluations       Time [s]           Convergence     Best f(x)     Mean f(x)\n');
   end
   
   % Iterations
   while 1
      % Increasing the epoch counter
      t = t + 1;
      % Updating means and standard deviations
      mu = alpha.*mu + (1 - alpha).*mu_last;
      beta_mod = beta - beta.*(1 - 1./t).^q;
      if (smoothingType == 1)
         sigma = beta_mod*sigma + (1 - beta_mod).*sigma_last;
      else
         sigma = alpha.*sigma + (1 - alpha).*sigma_last;
      end
      % Computing and recording variables values in the new population
      Q(:, 1 : n) = randnt(Z, n, mu, sigma, l, u);
      % Computing and recording objectives values in the new population
      Q(:, n + 1) = f(Q(:, 1 : n)); 
      % Computing and recording constraints values in the new population
      if (p > 0)
         G = g(Q(:, 1 : n));         
         Q(:, n + 1) = Q(:, n + 1) + sum(max(G, 0)*diag(gamma), 2);
      end
      % Sorting the solutions by their performance
      Q = sortrows(Q, n + 1);
      % Updating the best solution
      if (Q(1, n + 1) < f_opt)
         y_opt = Q(1, n + 1);
         X_opt = Q(1, 1 : n);
      end
      % Extractiing the elitist population
      E = Q(1 : Ne, :);
      % Considering the stop conditions
      mu_last = mu;
      sigma_last = sigma;
      % Showing process progress
      if (strcmpi(display, 'iter'))
         fprintf('Generation  Evaluations       Time [s]           Convergence     Best f(x)     Mean f(x)\n');
         fprintf(' %9d   %10d  %13.4f     %8.2e/%8.2e  %12.4e  %12.4e\n', ...
                 t, t*Z, (now - time)*24*60*60, max(sigma), epsilon_max, ...
                 min(E(:, n + 1)), mean(E(:, n + 1)));
         
         fprintf('Current solution: ');  
         for i = 1 : n
            fprintf('%f ', X_opt(i));
         end
         fprintf('\n')
         
         y_latest = sinc_rollout(X_opt(1),X_opt(2),X_opt(3),X_opt(4),reference,Ts);
         clf; plot(y_latest); hold on; plot(actual,'--'); grid on; pause(0.1); 
      end      
      if (t >= N)
         % Stop if raching the maximum number of epochs
         time = (now - time)*24*60*60;
         flag = 'Maximum epoch reached';
         break;
      elseif (max(sigma) <= epsilon_max)
         % Stop if all the standar deviations are lower than epsilon_max
         time = (now - time)*24*60*60;
         flag = 'Convergence limit reached';
         break;
      end
      % Computing the new means and standard deviations
      mu = mean(E(:, 1 : n));
      sigma = std(E(:, 1 : n));      
   end
  
   % Showing process completion
   if (strcmpi(display, 'iter') ||strcmpi(display, 'final'))
     fprintf('Optimization process completed.\n');
     fprintf('   Stop due to: %s.\n', flag);
     fprintf('   Epoch number: %d.\n', t);
     fprintf('   Objective function f(x) = %f.\n', y_opt);
     for i = 1 : n
         fprintf('   Decision variable x%d = %f.\n', i, X_opt(i));
     end
     if (p > 0)
         G_opt = g(X_opt);
         for i = 1 : p
             fprintf('   Constraint g%d(x) = %f.\n', i, G_opt(i));
         end
     end
   end 
end


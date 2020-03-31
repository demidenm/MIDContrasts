function [point_estimate, lower_bounds, upper_bounds] = bootstrap_ci(x, alpha, num_boots, method) 

%% Calculates a bootstrap CI for any given vector 

%% Input: x- Input vector 
%         alpha- alpha cut of for the CI
%         num_boots- how many bootstrap estimates you want 
%         method - Three methods possible: 'percentile', 'bootstrap' and 
%                  'bootnorm': Bootnorm is normal approximation with
%                  bootstrap standard error 
%% Output: point_estimate- Mean of the vector 
%          lower_bound- Lower bound of the CI
%          upper_bound- Upper bound of the CI
%% Author: Karthik G, 12/4/2019, University of Michigan 

%% Generate random shuffle labels
seq = randi([1, length(x)], length(x), num_boots);

%%Reshuffle data
new_x = x(seq);

%%Find real point estimates
point_estimate = mean(x);

%%Find bootstrap point estimates 
bootstrap_mean_estimates = mean(new_x,1);

%%%%%%% Find the bootstraped 95% CI %%%%%%%%%%%
if(strcmp(method,'percentile'))
    lower_bounds = quantile(bootstrap_mean_estimates,alpha/2);
    upper_bounds = quantile(bootstrap_mean_estimates,1-alpha/2);
elseif(strcmp(method,'bootstrap'))
    lower_bounds = 2*point_estimate - quantile(bootstrap_mean_estimates,1-alpha/2);
    upper_bounds = 2*point_estimate - quantile(bootstrap_mean_estimates,alpha/2);
elseif(strcmp(method,'bootnorm'))
    lower_bounds = point_estimate - norminv(1 - alpha/2)*std(bootstrap_mean_estimates);
    upper_bounds = point_estimate + norminv(1 - alpha/2)*std(bootstrap_mean_estimates);
end

end


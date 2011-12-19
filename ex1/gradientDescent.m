function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

n = length(theta);
m = length(y);
J_history = zeros(num_iters, 1);

for iter = 1:num_iters
    % Perform a single gradient step on the parameter vector theta. 
    err = X * theta - y;

    %delta = zeros(n, 1);
    %for i = 1:n
    %  delta(i) = (1/m) * err' * X(:, i);
    %end
    % ...better:
    delta = (1/m) * X' * err;

    theta = theta - alpha * delta;

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);
end

end

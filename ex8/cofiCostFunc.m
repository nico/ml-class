function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params.
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
            
D = (X * Theta' - Y) .* R;

% Normally sum(X(:)), but that looks weird here.
J = 1/2 * sum(sum(D .^ 2)) + lambda / 2 * sum(sum(Theta .^ 2)) ...
                           + lambda / 2 * sum(sum(X .^ 2));

X_grad = D * Theta + lambda * X;
Theta_grad = D' * X + lambda * Theta;

% Fold back into vectors.
grad = [X_grad(:); Theta_grad(:)];

end

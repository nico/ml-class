function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight
% matrices for our 2 layer neural network
Theta1 = ...
  reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
          hidden_layer_size, (input_layer_size + 1));

Theta2 = ...
  reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
          num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
num_labels = size(Theta2, 1);
         
% 1. Feed-forward to compute h = a3.
a1 = [ones(1, m); X'];  % 401 x m
z2 = Theta1 * a1;
a2 = [ones(1, m); sigmoid(z2)];  % 26 x m
a3 = sigmoid(Theta2 * a2);  % 10 x m

% Explode y into 10 values with Y[i] := i == y.
Y = zeros(num_labels, m);
Y(sub2ind(size(Y), y', 1:m)) = 1;

% Compute the non-regularized error. Fully vectorized, at the expense of
% having an expanded Y in memory (which is 1/40th the size of X, so it should be
% fine).
J = (1/m) * sum(sum(-Y .* log(a3) - (1 - Y) .* log(1 - a3)));

% Add regularized error. Drop the bias terms in the 1st columns.
J = J + (lambda / (2*m)) * sum(sum(Theta1(:, 2:end) .^ 2));
J = J + (lambda / (2*m)) * sum(sum(Theta2(:, 2:end) .^ 2));


% 2. Backpropagate to get gradient information.
d3 = a3 - Y;  % 10 x m
d2 = (Theta2' * d3) .* [ones(1, m); sigmoidGradient(z2)];  % 26 x m

% Vectorized ftw:
Theta2_grad = (1/m) * d3 * a2';
Theta1_grad = (1/m) * d2(2:end, :) * a1';

% Add gradient regularization.
Theta2_grad = Theta2_grad + ...
              (lambda / m) * ([zeros(size(Theta2, 1), 1), Theta2(:, 2:end)]);
Theta1_grad = Theta1_grad + ...
              (lambda / m) * ([zeros(size(Theta1, 1), 1), Theta1(:, 2:end)]);

% Unroll gradients.
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end

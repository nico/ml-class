function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

a1 = X';  % 400 x m
a2 = sigmoid(Theta1 * [ones(1, size(a1, 2)); a1]);  % 25 x m
a3 = sigmoid(Theta2 * [ones(1, size(a2, 2)); a2]);  % 10 x m

[maxval, maxindices] = max(a3);
p = maxindices';

end

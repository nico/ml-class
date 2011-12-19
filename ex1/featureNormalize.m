function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Normalizes the features in X 
%   FEATURENORMALIZE(X) returns a normalized version of X where
%   the mean value of each feature is 0 and the standard deviation
%   is 1. This is often a good preprocessing step to do when
%   working with learning algorithms.

m = size(X, 1); % number of training examples
mu = mean(X, 1);
sigma = std(X, 0, 1);  % 0: Use 1/(N-1) instead of 1/N for normalization.
X_norm = (X - repmat(mu, m, 1)) ./ repmat(sigma, m, 1);

end

function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

K = size(centroids, 1);
idx = zeros(size(X,1), 1);

for xi = 1:size(X,1)
  x = X(xi, :);

  % Find closest centroid for x.
  best = Inf;
  for mui = 1:K
    mu = centroids(mui, :);
    d = dot(x - mu, x - mu);
    if d < best
      best = d;
      idx(xi) = mui;
    end
  end

  %diff_vecs = repmat(x, K, 1) - centroids;
  %diffs = diff_vecs * diff_vecs'; ...
end

end


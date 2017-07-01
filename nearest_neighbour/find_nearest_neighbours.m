function [ nn ] = find_nearest_neighbours( X_train, X_test, k )
%find_nearest_neighbours find K nearest neighbouts of X_test in %X_train
%   Detailed explanation goes here

[m n] = size(X_train);
nn = zeros(k,1);

diff = X_train - repmat(X_test,m,1);
diff = diff .^ 2;

distance = sum(diff,2);
distance = distance .^ 0.5;
[~, neighbours] = sort(distance);

nn = neighbours(1:k)';

end
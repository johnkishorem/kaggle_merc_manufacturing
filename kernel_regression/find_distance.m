function [ distance ] = find_distance( x_train_args, x_test_args )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

[m, ~] = size(x_train_args);
distance = zeros(m,1);

diff = x_train_args - repmat(x_test_args,m,1);
diff = diff .^ 2;

help = sum(diff,2);
distance = help .^ 0.5;

end


function [ y ] = epanechnikov_kernel ( x_arg, lambda )
%epanechnikov_kernel Applies epanechnikov_kernel to args
%   Detailed explanation goes here

y = zeros(size(x_arg));
y = abs(x_arg) <= lambda;
y = y .* (1 - (x_arg .^ 2));
end


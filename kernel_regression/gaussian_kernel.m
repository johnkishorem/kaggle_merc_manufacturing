function [ y ] = gaussian_kernel(x_arg,lambda )
%gaussian_kernel Applies gaussian kernel
%   Detailed explanation goes here

y = zeros(size(x_arg));
y = exp(-1 .* (x_arg.^2) ./ lambda);

end


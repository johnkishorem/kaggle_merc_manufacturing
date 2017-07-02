function [ y ] = box_kernel( x_arg, lambda )
%box_kernel Applies box kernel
%   Detailed explanation goes here

y = abs(x_arg) <= lambda;

end


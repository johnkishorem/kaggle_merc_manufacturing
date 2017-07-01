function [theta, J_history, J_validation] = gradientDescentCrossValidation(X_train, y_train, X_cv, y_cv, theta, alpha, num_iters)
%GRADIENTDESCENTMULTI Performs gradient descent to learn theta
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y_train); % number of training examples
J_history = zeros(num_iters, 1);
J_validation = zeros(num_iters, 1);
X = [ones(m,1) X_train];
y = y_train;

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
    fprintf('Running gradient descent for iter = %d...\n',iter);
    H = X * theta;
    H = H - y;
    grad = (X' * H)/m;
    theta = theta - ((alpha * grad));
    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X_train, y_train, theta);
    J_validation(iter) = computeCost(X_cv, y_cv, theta);

end
end
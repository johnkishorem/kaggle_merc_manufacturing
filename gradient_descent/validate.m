%% Split train data, test data, cross validation data
train_len = 2525;
% train_len = 100;
cv_len = 842; test_len = 842; % total size of 4209 = 2525 + 842 + 842

%% Split train data, test data, cross validation data
X_train = X(1:train_len , :); y_train = y(1:train_len);
X_cv = X((train_len +1) : train_len + cv_len, :); y_cv = y((train_len +1) : train_len + cv_len);
X_test = X((cv_len +1) : cv_len + test_len, :); y_test = y((cv_len +1) : cv_len + test_len);


%% Curves to find the number of interations of gradient descent
theta_validate = zeros(n+1, 1);
alpha = 0.003;
num_iters = 30000;
[theta_validate, J_history_train, J_history_cv] = gradientDescentCrossValidation(X_train, y_train, X_cv, y_cv, theta_validate, alpha, num_iters);
figure;
plot(1:num_iters, J_history_train, 1:num_iters, J_history_cv);
legend('Train', 'Cross Validation');
xlabel('number of iter');
ylabel('Error');

%% Calculate learning curve data
J_train = zeros(train_len, 1);
J_cv = zeros(train_len, 1);
alpha = 0.003;
num_iters = 10173; %% values decided using cv
for i = 1 : train_len
    fprintf('Running gradient descent for m = %d...\n',i);
    % Choose some alpha value
    theta = zeros(n+1, 1);
    [theta, J_history] = gradientDescent(X_train(1:i,:), y_train(1:i), theta, alpha, num_iters);
    J_train(i) = computeCost(X_train(1:i,:), y_train(1:i), theta);
    J_cv(i) = computeCost(X_cv, y_cv, theta);
end

%% Plot the learning curves
figure;
plot(1:train_len, J_train, 1:train_len, J_cv);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');
figure;
plot(1:train_len, J_train);
figure;
plot(1:train_len, J_cv);
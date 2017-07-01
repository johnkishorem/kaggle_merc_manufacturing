
%% Code to read data from CSV file
load('train.mat')

%% Collect ground truth as a separate vector
y = cell2mat(train(:,2));

%% Code to find the following information from the data
% feature_type - 1 categorical feature 0 quantitive feature
% no_categories - number of categories in each categorical feature
% categories - mapping available for each categories
[feature_type, no_categories, categories] = extractCategory(train(:, 3:end));

%% Code to collect non categorical ie quantative features only
X = removeCategory(train(:, 3:end), feature_type);

%% Code to create new feature for each categorical feature
x_help = applyCategory(train(:, 3:end), feature_type, no_categories, categories);
X = [X x_help];

%% set parameters for gradient descent
[m n] = size(X);

% Choose some alpha value
alpha = 0.003;
num_iters = 10000;


%% Use gradient Descent
fprintf('Running gradient descent ...\n');
% Init Theta and Run Gradient Descent 
theta = zeros(n+1, 1);
[theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

%% Apply gradient descent on test set
load('test.mat');
test_X = removeCategory(test(:, 2:end), feature_type);
test_X_help = applyCategory(test(:, 2:end), feature_type, no_categories, categories);
test_X = [test_X test_X_help];
test_X = [ones(m,1) test_X];
test_y = test_X * theta;
test_y = [cell2mat(test(:,1)) test_y];

%% Store the result to a csv file
csvwrite('submit.csv',test_y);
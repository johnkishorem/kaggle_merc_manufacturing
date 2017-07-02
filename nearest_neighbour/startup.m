%% Process data as in gradient descent
y = cell2mat(train(:,2));
[feature_type, no_categories, categories] = extractCategory(train(:, 3:end));
X = removeCategory(train(:, 3:end), feature_type);
x_help = applyCategory(train(:, 3:end), feature_type, no_categories, categories);
X = [X x_help];

%% Split train data, test data, cross validation data
train_len = 2525;
cv_len = 842; test_len = 842; % total size of 4209 = 2525 + 842 + 842
X_train = X(1:train_len , :); y_train = y(1:train_len);
X_cv = X((train_len +1) : train_len + cv_len, :); y_cv = y((train_len +1) : train_len + cv_len);
X_test = X((cv_len +1) : cv_len + test_len, :); y_test = y((cv_len +1) : cv_len + test_len);

%% Using CV to select a value for K
count = 300;
error_history = zeros(count,1);
for iter = 1:count
    fprintf('\nRunning nearest neighbout with %d neighbours',iter);
    k = iter;
    mean_k_nn = zeros(cv_len,1);
    for i = 1:cv_len
        k_nearest_neighbours = find_nearest_neighbours(X_train, X_cv(i,:), k);
        sum_help = sum(y(k_nearest_neighbours));
        mean_k_nn(i) = sum_help / k;
    end
    squared_error = (y_cv - mean_k_nn) .^ 2;
    mean_error = sum(squared_error) / cv_len;
    root_mean_square = mean_error ^ 0.5;
    error_history(iter) = root_mean_square;
end
plot(1:numel(error_history),error_history);

%% Error on test set
k = 40; %%value obtained from the lease rms erros in cv set
for i = 1:test_len
    k_nearest_neighbours = find_nearest_neighbours(X_train, X_test(i,:), k);
    sum_help = sum(y(k_nearest_neighbours));
    mean_k_nn(i) = sum_help / k;
end
squared_error = (y_test - mean_k_nn) .^ 2;
mean_error = sum(squared_error) / test_len;
root_mean_square = mean_error ^ 0.5

%% Mean of K nearest neighbour
k_nearest_neighbours = find_nearest_neighbours(X_train, X_test(1,:), k);
mean_k_nn = sum(y(k_nearest_neighbours));
mean_k_nn = mean_k_nn / k;
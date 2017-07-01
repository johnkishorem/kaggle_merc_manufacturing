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

%% Mean of K nearest neighbour
k = 5;
k_nearest_neighbours = find_nearest_neighbours(X_train, X_test(1,:), k);
mean_k_nn = sum(y(k_nearest_neighbours));
mean_k_nn = mean_k_nn / k;
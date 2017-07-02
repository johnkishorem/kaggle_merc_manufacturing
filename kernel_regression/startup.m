%% Train data processing copied from gradient descent approach
y = cell2mat(train(:,2));
[feature_type, no_categories, categories] = extractCategory(train(:, 3:end));
X = removeCategory(train(:, 3:end), feature_type);
x_help = applyCategory(train(:, 3:end), feature_type, no_categories, categories);
X = [X x_help];
[m n] = size(X);

%% split data into train, test and cv
train_len = 2525;
cv_len = 842; test_len = 842; % total size of 4209 = 2525 + 842 + 842
X_train = X(1:train_len , :); y_train = y(1:train_len);
X_cv = X((train_len +1) : train_len + cv_len, :); y_cv = y((train_len +1) : train_len + cv_len);
X_test = X((cv_len +1) : cv_len + test_len, :); y_test = y((cv_len +1) : cv_len + test_len);

%% kernel regression
count = 30;
start_count = 1;
clear error_history;
error_history = zeros(iter - start_count + 1,1);
for iter = start_count:count
    fprintf('Calculating at lambda = %d\n',iter);
    lambda = iter;
    prediction = zeros(cv_len,1);
    for i = 1 : cv_len
        distance_from_train = find_distance(X_train, X_cv(i,:));
        weights = epanechnikov_kernel(distance_from_train,lambda);
        sum_weights = sum(weights);
        weighted_prediction = sum(weights .* y_train);
        if sum_weights == 0
            prediction(i) = 100000;
        else
            prediction(i) = weighted_prediction/sum_weights;
        end
    end
    squared_error = (prediction - y_cv) .^ 2;
    mean_error = sum(squared_error) / cv_len;
    root_mean_squared_error = mean_error ^ 0.5;
    error_history(iter - start_count + 1) = root_mean_squared_error;
end
plot(1:numel(error_history),error_history);
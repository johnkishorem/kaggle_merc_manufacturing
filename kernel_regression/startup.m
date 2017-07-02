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
error_history = zeros(count - start_count + 1,1);
for iter = start_count:count
    fprintf('Calculating at lambda = %d\n',iter);
    lambda = iter;
    prediction = zeros(cv_len,1);
    for i = 1 : cv_len
        distance_from_train = find_distance(X_train, X_cv(i,:));
        weights = gaussian_kernel(distance_from_train,lambda);
        sum_weights = sum(weights);
        weighted_prediction = sum(weights .* y_train);
        prediction(i) = weighted_prediction/sum_weights;
    end
    squared_error = (prediction - y_cv) .^ 2;
    mean_error = sum(squared_error) / cv_len;
    root_mean_squared_error = mean_error ^ 0.5;
    error_history(iter - start_count + 1) = root_mean_squared_error;
end
plot(1:numel(error_history),error_history);

%% apply kernel regression on submission
test_X = removeCategory(test(:, 2:end), feature_type);
test_X_help = applyCategory(test(:, 2:end), feature_type, no_categories, categories);
test_X = [test_X test_X_help];
[test_m, test_n] = size(test_X);
test_y = zeros(test_m,1);
%lambda = 8; %% Value choosen based on CV 
lambda = 6; %% Values choose based on CV for gaussian
for i = 1 : test_m
    distance_from_train = find_distance(X, test_X(i,:));
    weights = gaussian_kernel(distance_from_train,lambda);
    sum_weights = sum(weights);
    weighted_prediction = sum(weights .* y);
    test_y(i) = weighted_prediction/sum_weights;
end
test_y = [cell2mat(test(:,1)) test_y];

%% Store the result to a csv file
csvwrite('submit.csv',test_y);
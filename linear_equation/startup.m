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


%% Store the result to a csv file
csvwrite('submit.csv',test_y);
function [categorical_features, no_unique_categories, unique_categories] = extractCategory(train)
[m n] = size(train);
X = zeros(m,1);
y = zeros(m,1);

%% find the number of features which are categorical and quantitative
categorical_features = zeros(n,1);
for i = 1 : n
    if ischar(train{1,i}) == 1
        categorical_features(i) = 1;
    end
end

%% collect non categorical data first
for i = 1 : n
    if categorical_features(i) == 0 
        X = [X cell2mat(train(:,i))]; 
    end
end

%% collect no of unique categories in each categorical features
no_unique_categories = zeros(n,1);
for i = 1 : n
    if categorical_features(i) == 1
        dummy_unique = unique(train(:,i));
        no_unique_categories(i) = length(dummy_unique);
    end
end

%% collect unique categories for each feature
unique_categories = cell(n, max(no_unique_categories));
for i = 1 : n
    if categorical_features(i) == 1
        dummy_unique = unique(train(:,i));
        for j = 1 : no_unique_categories(i)
            unique_categories{i, j} = dummy_unique{j};
        end
    end    
end

%%drop first column as it is filled with zeros intially
X(:,1) = []; 

end
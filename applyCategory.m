function [ X ] = applyCategory( data,categorical_features, no_unique_categories, unique_categories)
% applyCategory Creates quantitive feature for each category
%   Detailed explanation goes here
[m n] = size(data);

%% Initialize output X as zeros
X = zeros(m,1);

%% Iterate over each feature column
for i = 1 : n
    if categorical_features(i) == 1
        help_array = zeros(m, no_unique_categories(i));
        for j = 1 : no_unique_categories(i)
           help_array(:,j) = strcmp(data(:,i),unique_categories{i,j});
        end
        X = [X help_array];
    end
end

%% Remove first column as it has only zeros
X(:,1) = [];

end


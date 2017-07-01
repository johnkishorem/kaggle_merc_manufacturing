function [ X ] = removeCategory( data, categorical_features)
%removeCategory Removes the category data from the dataset
%   Detailed explanation goes here

%% Initialize X and dimensions
[m n] = size(data);
X = zeros(m, 1);

%% Remove category data
for i = 1 : n
    if categorical_features(i) == 0
        X = [X cell2mat(data(1:m, i))];
    end
end

%% Drop first column as it has only zeros
X(:,1) = [];

end


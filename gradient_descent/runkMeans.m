function [centroids, idx, J_history_kmeans] = runkMeans(X, initial_centroids, ...
                                      max_iters, plot_progress)
%RUNKMEANS runs the K-Means algorithm on data matrix X, where each row of X
%is a single example
%   [centroids, idx] = RUNKMEANS(X, initial_centroids, max_iters, ...
%   plot_progress) runs the K-Means algorithm on data matrix X, where each 
%   row of X is a single example. It uses initial_centroids used as the
%   initial centroids. max_iters specifies the total number of interactions 
%   of K-Means to execute. plot_progress is a true/false flag that 
%   indicates if the function should also plot its progress as the 
%   learning happens. This is set to false by default. runkMeans returns 
%   centroids, a Kxn matrix of the computed centroids and idx, a m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%
% Initialize values
[m n] = size(X);
K = size(initial_centroids, 1);
centroids = initial_centroids;
previous_centroids = centroids;
idx = zeros(m, 1);
J_history_kmeans = zeros(max_iters,1);
% Run K-Means
for i=1:max_iters
    
    % Output progress
    % fprintf('K-Means iteration %d/%d...\n', i, max_iters);
    
    % For each example in X, assign it to the closest centroid
    idx = findClosestCentroids(X, centroids);
    
    J_history_temp = 0;
    for j = 1 : m
        J_history_temp = J_history_temp + sum((X(j,:) - centroids(idx(j),:)).^2);
    end
    J_history_kmeans(i) = J_history_temp / m;
    
    % Given the memberships, compute new centroids
    centroids = computeCentroids(X, idx, K);
end
end


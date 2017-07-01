%% Clustering
% Run your K-Means algorithm on this data
% You should try different values of K and max_iters here
max_number_clusters = n - 1;
max_number_clusters = 50;
% max_iters = 10;
elbow_curve = zeros(max_number_clusters-2,1);
for k = 2 : max_number_clusters
    
    fprintf('Running clustering with %d clusters\n',k);
    % When using K-Means, it is important the initialize the centroids
    % randomly. 
    % You should complete the code in kMeansInitCentroids.m before proceeding
    initial_centroids = kMeansInitCentroids(X, k);

    % Run K-Means
    [centroids, idx, J_history_kmeans] = runkMeans(X, initial_centroids, max_iters);
    
    idx = findClosestCentroids(X, centroids);
    
    clustering_error = 0;
    for j = 1 : m
        clustering_error = clustering_error + sum((X(j,:) - centroids(idx(j),:)).^2);
    end
    elbow_curve(k-1) = clustering_error / m;    
end
figure;
plot(1:numel(elbow_curve), elbow_curve);
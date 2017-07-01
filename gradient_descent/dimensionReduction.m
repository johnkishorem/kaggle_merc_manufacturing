%% PCA calculation
[U, S] = pca(X);

%% with 2D data
Z1 = projectData(X, U, 2);
figure;
mesh(Z1(:,1),Z1(:,2),diag(y));
figure;
surf(Z1(:,1),Z1(:,2),diag(y));

%% with 1D data
Z2 = projectData(X, U, 1);
figure;
plot(Z2,y,'x');
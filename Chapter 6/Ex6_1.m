%% Data Analysis Course 2021 - Exercise 6.1

% Clearing
clear;
close all;
clc;

%% Initializing
n = 1000;
sx = 1;
sy = 4;
W = [0.2 0.8; 0.4 0.5; 0.7 0.3];
sigma = [sx^2 0;0 sy^2];
X = mvnrnd([0 0],sigma,n);

%% a) eigenvalues, eigenvectors of variance matrix
% 2D scatter Plot
figure;
scatter(X(:,1),X(:,2))
grid on
title('2D Scatter plot')
xlabel('X_1')
ylabel('X_2')

% 3D scatter Plot 
X3d = X*W';
figure
scatter3(X3d(:,1),X3d(:,2),X3d(:,3))
grid on
title('3D Scatter plot')
xlabel('X_1')
ylabel('X_2')
zlabel('X_3')

% Normalizing before PCA, getting the eigvalues in descending order
X3d = normalize(X3d,'center');
covMat = cov(X3d);
[eigVec,eigVal] = eig(covMat)
eigVal = diag(eigVal)
eigVal = sort(eigVal,'descend')

% PCA component scores
n = size(eigVec,2)
eigVec = eigVec(:,n:-1:1)
scores = X3d*eigVec

% SVD
[U,S,V] = svd(X3d);

figure
scatter3(scores(:,1),scores(:,2),scores(:,3))
title('PCA Scores 3D Scatterplot')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')

%% B
% Scree plot
figure
plot(1:length(eigVal),eigVal,'-o')
title('Scree plot')
ylabel('eigevalues')

%% C
% PCA 2D scores scatterplot
figure
scatter(scores(:,1),scores(:,2))
title('PCA Scores 2D Scatterplot')
xlabel('PC1')
ylabel('PC2')

infoLoss = eigVal(3)/sum(eigVal)
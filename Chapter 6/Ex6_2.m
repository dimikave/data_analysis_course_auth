%% Data Analysis Course 2021 - Exercise 6.2

% Clearing
clear;
close all;
clc;

%% Initializing

% Import data
data = importdata('yeast.dat')

%% d<= p 
n = size(data,1)
data = normalize(data)

covMatrix = cov(data')
[~,eigVals] = eig(covMatrix);
eigVals = diag(eigVals);
eigVals = eigVals(end:-1:1);

% Scree plot
figure(1)
plot(1:length(eigVals),eigVals,'-o')
title('Scree plot')
ylabel('eigenvalues')

td = 90;
eigValsSum = sum(eigVals);
sumEigenValues = 0;
i = 0;
while(sumEigenValues < td)
    i = i + 1;
    sumEigenValues = sumEigenValues + 100*eigVals(i)/eigValsSum;
end
i
% B
[~,scores,~] = pca(data');
% PCA 2D scores scatterplot
figure(2)
scatter(scores(:,1),scores(:,2))
title('PCA Scores 2D Scatterplot')
xlabel('PC1')
ylabel('PC2')

% PCA 3D scores scatterplot
figure(3)
scatter3(scores(:,1),scores(:,2),scores(:,3))
title('PCA Scores 3D Scatterplot')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
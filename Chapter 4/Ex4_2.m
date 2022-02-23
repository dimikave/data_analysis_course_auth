%% Data Analysis Course 2021 - Exercise 4.2

% Clearing
clear;
close all;
clc;

% A
sx = 5; % uncertainty
X1 = 500;
X2 = 300;
sy = sqrt((X1+X2)^2*sx^2)
% sy = sqrt(X1^2*sx1^2 + X2^2*sx2^2);

% We search for a locus where the uncertainty is the same
lGraph = [1:1000];
wGraph = sqrt(sy^2 - lGraph.^2*sx^2)/sx;

figure;
plot(lGraph,wGraph)


% B
n = 1000;
% X1 = 1:1:n;
% X2 = 1:1:n;
% grid = zeros(n);
% for i = 1:n
%     for j = 1:n
%         grid(i,j) = sqrt( X1(i)^2*sx^2 + X2(j)^2*sx^2 );
%     end
% end
[X1,X2] = meshgrid(1:1:n,1:1:n);
grid = sqrt(sx^2*X1.^2+sx^2*X2.^2);

% Surface
surf(X1,X2,grid);
colorbar
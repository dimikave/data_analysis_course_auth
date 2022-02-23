%% Data Analysis Course 2021 - Exercise 3.10

% Clearing
clear;
close all;
clc;

M = 100;
n = 10;
B = 1000;
X = normrnd(0,1,M,n);
% bootstat = bootstrp(M,@mean,X)
Y = X;
flag = 0;
if (flag == 1)
    Y = X.^2;
end

h = zeros(M,1);
p = zeros(M,1);
mu = 0;
% mu = 0.5;
% mu = 1;
% mu = 4;
Xbar = zeros(size(X));
for i = 1:M
    Xbar(i,:) = X(i,:) - mean(X(i,:)) + mu;
end

bootstat = zeros(M,M,M+1);
for i = 1:M
    % Parametric
    [h(i),p(i),~,~] = ttest(Y(i,:),mu);
    % Bootstrap
    for j = 1:M
        bootstat(i,:,j) = bootstrp(M,@mean,Xbar(j,:)')';
    end
    bootstat(i,:,M+1) = bootstrp(M,@mean,X(i,:)')';
end

[bootstat,I] = sort(bootstat,2);

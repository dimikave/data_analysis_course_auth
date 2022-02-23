%% Data Analysis Course 2021 - Exercise 5.5

% Clearing
clear;
close all;
clc;

lightair = importdata("lightair.dat");

M = 1000;
n = 100;
b = zeros(M,2);

alpha = 5;
percentiles = [alpha/2 (100-alpha)/2];

% Bootstrap
for i = 1:M
    % Generate bootstrap sample
    tempData = lightair(unidrnd(n,n,1), :);
    
    % Calculate b coefficients
    X = tempData(:,1);
    Y = tempData(:,2);
    regressionModel = fitlm(X,Y);

    btemp = table2array(regressionModel.Coefficients);
    b(i,:) = btemp(:,1)';
end
b0CI = prctile(sort(b(:,1)),percentiles);
b1CI = prctile(sort(b(:,2)),percentiles);

% Parametrical
X = lightair(:,1);
Y = lightair(:,2);

regressionModel = fitlm(X,Y);
bParamCI = coefCI(regressionModel);
%% Data Analysis Course 2021 - Exercise 3.2

% Clearing
clear;
close all;
clc;


% Initializing
expMean = 5;
n = 1000;
M = 1000;

% a)
samples = exprnd(expMean,n,1);

expMeanEst = mle(samples,'distribution','Exponential');
mu = mean(samples);
fprintf(strcat('expMean estimator = ',num2str(expMeanEst),', mean = ',num2str(mu)))
disp(' ')


% b)
means = ex3_2b(n,M,expMean)
result = mean(means)

function means = ex3_2b(n,M,expMean)
    samples = exprnd(expMean,M,n,1);
    means = mean(samples,1);
    histogram(means);
    title(strcat('n = ',int2str(n),', M = ',int2str(M),', expMean = ',int2str(expMean)))
end
    
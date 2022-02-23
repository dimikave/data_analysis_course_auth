%% Data Analysis Course 2021 - Exercise 3.1

% Clearing
clear;
close all;
clc;

% Initializing
lamda = 3;
n = 1000;
M = 1000;
% 
% a)
samples = poissrnd(lamda,n,1);

lamdaEst = mle(samples,'distribution','Poisson');
mu = mean(samples);
fprintf(strcat('lamda estimator = ',num2str(lamdaEst),', mean = ',num2str(mu)))
disp(' ')


% b)
means = ex3_1b(n,M,lamda)
result = mean(means)

function means = ex3_1b(n,M,lamda)
    samples = poissrnd(lamda,M,n,1);
    means = mean(samples,1);
    histogram(means);
    title(strcat('n = ',int2str(n),', M = ',int2str(M),', lamda = ',int2str(lamda)))
end
    
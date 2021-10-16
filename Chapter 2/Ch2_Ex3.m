%% Data Analysis Course 2021 - Exercise 2.3

clear;
close all;
clc;

muX = 0; % Doesn't affect
muY = 0;
sigma1 = 1;
sigma2 = 10;
corr12 = 0; % Affects the result (if zero, no correlation)

% Random numbers length
n = 100000;

% Mean, Sigma Matrix of X and Y
mu = [muX muY];
Sigma = [sigma1 corr12; corr12 sigma2];
R = mvnrnd(mu,Sigma,n); % Matrix of random vectors chosen from mv normal dist

% Getting the new random vectors from mv normal dist
X = R(:,1);
Y = R(:,2); 

% Calculating
varX = var(X);
varY = var(Y);
varXsumY = var(X+Y);

% Printing the result
fprintf("Var[X]+Var[Y]=%f ----- Var[X+Y]=%f \n", varX+varY, varXsumY);
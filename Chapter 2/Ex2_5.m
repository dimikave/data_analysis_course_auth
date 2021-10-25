%% Data Analysis Course 2021 - Exercise 2.5

% Clearing
clear;
close all;
clc;

mu = 4;
sigma = 0.01;

% Probability of length being smaller than 3.9 == Destruction
pDest = normcdf(3.9,mu,sigma)

% Lower limit in order only the 1% of the rails get destroyed
limit = norminv(0.01, mu, sigma)
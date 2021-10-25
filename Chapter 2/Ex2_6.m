%% Data Analysis Course 2021 - Exercise 2.6

% Clearing
clear;
close all;
clc;

n = 100;
N = 1e5;

samples = zeros(n,1);
Y = zeros(N,1);

for i = 1:N
    samples = unifrnd(0,1,n,1);
    Y(i) = mean(samples);
end

% Plot means of the samples, and the normal distribution
histfit(Y)
% mean(Y) == 0.5 % as expected

% We can see the importance of normal distribution to 'attract' the sums of
% random variables that do not necessarily follow a normal distribution
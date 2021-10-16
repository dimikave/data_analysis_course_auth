%% Data Analysis Course 2021 - Exercise 2.2 

clear;
close all;
clc;

% Bins
bins = 100;
% Random Numbers
n = 1000;
lamda = 1;

randomNumbers = zeros(n,1);

% Getting the random values from exponential
for i=1:n
    randomNumbers(i) = expinv(rand(),lamda); % cdf/ask
end

histfit(randomNumbers,bins,'exponential');  % fits in the pdf/spp
title("Histogram and comparison with exponential distribution");
legend("Generator Distribution","Exponential Distribution");

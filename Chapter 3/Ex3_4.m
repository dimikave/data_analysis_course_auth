%% Data Analysis Course 2021 - Exercise 3.4

% Clearing
clear;
close all;
clc;

x = [41 46 47 47 48 50 50 50 50 50 50 50 48 50 ...
    50 50 50 50 50 50 52 52 53 55 50 50 50 50 ...
    52 52 53 53 53 53 53 57 52 52 53 53 53 53 53 53 54 54 55 68];
v = var(x);

% a and b
[h1,p1,CI,~] = vartest(x,25)
% c and d
[h2,p2,CI2,~] = ttest(x,52)
% e
[h3,p] = chi2gof(x)
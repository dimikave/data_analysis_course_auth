%% Data Analysis Course 2021 - Exercise 3.6

% Clearing
clear;
close all;
clc;

% A and B

% Generate data
n = 100;
X = normrnd(0,1,[n 1]);     % vector of n random numbers from norm distr with mu = 0, sigma = 1
mX = mean(X);

% Bootstrap
B = 1000;
bootstrapMean = bootstrp(B,@mean,X);
seX = std(X)/sqrt(n)           % tupiko sfalma Standard Error
seXB = std(bootstrapMean)      % sto bootstrap, SE einai to sigma tou ektimhth

% Plot
figure(1)
clf;
histfit(bootstrapMean)
hold on;
plot([mX mX],ylim,'r');

% C)
Y = exp(X);
mY = mean(Y);

% Bootstrap
bootstrapMean = bootstrp(B,@mean,Y);
seY = std(X)/sqrt(n);
seYB = std(bootstrapMean);

% Plot
figure(2)
clf;
histfit(bootstrapMean);
hold on;
plot([mY mY],ylim,'r');


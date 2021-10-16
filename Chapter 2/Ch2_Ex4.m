%% Data Analysis Course 2021 - Exercise 2.4 

clear;
close all;
clc;

% Sample size of X
sampleSize = [10 100 1000 10000 100000];
nOfSamples = length(sampleSize);

expected1_X = zeros(nOfSamples,1);
one_expectedX = zeros(nOfSamples,1);

% uniform distribution interval [a,b] 
% a = 1001;
% b = 1002;
a = 1;
b = 2;

%  Experiment
for i = 1:nOfSamples
    n = sampleSize(i);
    % Formula: a + (b-a).*rand(n,1) for uniform distribution in [a,b]
    X = a + (b-a).*rand(n,1);
    expected1_X(i) = mean((X).^-1);
%     plot(X)
%     mean(X)
    one_expectedX(i) = 1/mean(X);
%     pause
end

% Plot of comparison
figure;
plot(sampleSize,expected1_X,"-o");
hold on;
plot(sampleSize,one_expectedX,"-*");
title("E[1/X] ----- 1/E[X]");
legend("E[1/X]", "1/E[X]");
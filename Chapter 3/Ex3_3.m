%% Data Analysis Course 2021 - Exercise 3.3

% Clearing
clear;
close all;
clc;


% Initializing
mu = 15;
n = 1000;
M = 1000;
% confidence = 95 mus alpha = 5% which is the default for ttest


% a) n = 5 b) n = 100
counter = 0;
for i = 1:M
    % Generating data
    samples = exprnd(mu,n,1);
    % Confidence Interval
    [h,~,CI(:),~] = ttest(samples,mu);
    % mu inside interval?
    if(mu>=CI(1) && mu<=CI(2))
        counter = counter + 1;
    end
end
percent = counter/M


    
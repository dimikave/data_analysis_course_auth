%% Data Analysis Course 2021 - Exercise 4.1

% Clearing
clear;
close all;
clc;

% A
h1 = 100;
h2 = [60 54 58 60 56];
e_sample = sqrt(h2/h1)
e_mu = mean(e_sample);
a = 0.05;
ts = tinv([a/2  1-a/2],length(e_sample)-1);       
SEM = std(e_sample)/sqrt(length(e_sample));
CI = e_mu + ts*SEM;
e_real = 0.76;
% [~,~,CI,~] = ttest(e_sample,e_real)        % Orthothtas
% [~,~,CI,~] = ttest(e_sample)        % Orthothtas
e_mu
e_std = std(e_sample)
e_real - e_std% orthothta akriveias
% CI = e_mu + std(e_sample)
CI2 = e_mu + ts*std(e_sample)       % Random uncertainty

% B

M = 1000;
n = 5;
mu = 58;
sigma = 2;
% samples = zeros(n,1);
% eMean = zeros(M,1);
% eStd = zeros(M,1);

% for i = 1:M
%     samples = normrnd(mu, sigma, n, 1);
%     meanSamples = mean(samples);
%     stdSmples = std(samples);
%     e = sqrt(samples/h1);
%     eMean(i) = mean(e);
%     eStd(i) = std(e);
% end

samples = normrnd(mu, sigma, n, M);
meanSamples = mean(samples);
stdSmples = std(samples);
e = sqrt(samples/h1);
eMean = mean(e);
eStd = std(e);

% Histogram
figure(1);
histogram(eMean);
hold on
plot([e_real e_real],ylim,'r')
plot([mean(eMean) mean(eMean)],ylim,'k')
legend('e real','mean of simulations for e')

% C
h1 = [80 100 90 120 95];
h2 = [48 60 50 75 56];

h1Std = std(h1);
h2Std = std(h2);
fprintf('Uncertainty for h1: %f +- %f\n',mean(h1),std(h1))
fprintf('Uncertainty for h2: %f +- %f\n',mean(h2),std(h2))

e = sqrt(h2./h1);
eStd2 = std(e);
fprintf('Uncertainty for e: %f +- %f\n',mean(e),std(e))
fprintf('Uncertainty for e at alpha = 0.05 confidence: %f +- %f\n',mean(e),tinv(1-a/2,length(e)-1)*std(e))

% [h,p,CI,~] = ttest(e,e_real)
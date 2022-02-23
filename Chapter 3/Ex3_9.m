%% Data Analysis Course 2021 - Exercise 3.9

% Clearing
clear;
close all;
clc;

M = 100;
n = 10;
m = 12;
flag = 0;
B = 1000;

% M random samples of size n from the standard normal distribution
% M random samples of size m from the standard normal distribution
X = normrnd(0,1,M,n);
Y = normrnd(0,1,M,m);
if flag == 1
    Y = X.^2;
elseif flag == 2
    Y = normrnd(0.2,1,M,m);
end

alpha = 0.05;
ts = tinv([0.025  0.975],n+m-2);
lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim];
limits = floor(limits);

% CI
CIParam = zeros(M,2);
CIBoot = zeros(M,2);
for i = 1:M
    [~,~,CIParam(i,:),~] = ttest2(X(i,:),Y(i,:));
    bootsX = bootstrp(B,@mean,X(i,:));
    bootsY = bootstrp(B,@mean,Y(i,:));
    dif = bootsX - bootsY;
    dif = sort(dif);
    CIBoot(i,:) = dif(limits);
end

% Graphic comparison of the two confidence intervals
figure;
histogram(CIParam(:,1));
hold on
histogram(CIBoot(:,1));
title('Lower Boundries of confidence intervals of mean difference')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off

figure;
histogram(CIParam(:,2));
hold on
histogram(CIBoot(:,2));
title('Upper Boundries of confidence intervals of mean difference')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off

% parDiff = find(CIParam(:,1)<0 & CIParam(:,2)>0);
% bootDiff = find(CIBoot(:,1)<0 & CIBoot(:,2)>0);
% fprintf('Probability of mean(x),mean(y) being different (parametric ci) = %1.3f \n',length(parDiff)/M); 
% fprintf('Probability of mean(x),mean(y) being different (percentile bootstrap ci) = %1.3f \n',length(bootDiff)/M); 

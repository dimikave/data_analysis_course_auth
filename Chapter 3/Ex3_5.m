%% Data Analysis Course 2021 - Exercise 3.5

% Clearing
clear;
close all;
clc;

% Import the data & Initiallizing
eruption = importdata("eruption.dat"); % Matrix with 3 col
stdCI = zeros(3,2);
meanCI = zeros(3,2);
h = zeros(3,1);
p = zeros(3,1);

std_data = [10 1 10];
mean_data = [75 2.5 75];
for i = 1:3
    data = eruption(:,i);
    [~,~,stdCI(i,:),~] = vartest(data,std_data(i)^2);
    [~,~,meanCI(i,:),~] = ttest(data,mean_data(i));
    [h(i),p(i)] = chi2gof(data)
    figure();
    histfit(data,20);
    legend
%     pause
end
% H p timh dhlwnei thn pithanothta na kanoume lathos otan aporriptoume thn
% mhdenikh upothesh.


stdCI = sqrt(stdCI)
meanCI

%% Sentence accepted?
data = eruption;

indices1 = eruption(:,2) < 2.5;
indices2 = ~indices1;

X1 = data(indices1,1:2);
X2 = data(indices2,1:2);

k = 1;

[h1,p1,stdci1,~] = ttest(X1(:,k),65)
[h2,p2,stdci2,~] = ttest(X2(:,k),91)

err = 10;
[h1v,p1v,stdci1v,~] = vartest(X1(:,k),err^2);
[h2v,p2v,stdci2v,~] = vartest(X2(:,k),err^2);
stdC1 = sqrt(stdci1);
stdC2 = sqrt(stdci2);
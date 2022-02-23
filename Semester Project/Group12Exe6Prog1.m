%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 6: Description
% We take the 2 countries from Exercise 5 that have PR that is most related
% to Greece's PR, and check if there is significant difference between
% their correlations. Bootstrap test

%% Clearing everything
clear;
clc;
close all;

%% Importing data from excel file
load('Exe3.mat')
% allData = readtable('ECDC-7Days-Testing.xlsx');
% CountryNames = readtable('EuropeanCountries.xlsx');
% countries = CountryNames.Country;

%% Getting PRs
prBel21 = Group12Exe5Func1('Belgium',allData);
prAus21 = Group12Exe5Func1('Austria',allData);
prGre21 = Group12Exe5Func1('Greece',allData);

% prBel21n = normalize(prBel21);
% prAus21n = normalize(prAus21);
% prGre21n = normalize(prGre21);
% 
% plot(prBel21n);
% hold on
% plot(prAus21n);
% plot(prGre21n);
% legend('Belgium','Austria','Greece')
%% Bootstrap test for corrcoeff of 2 countries
pr1 = [prGre21,prBel21];
pr2 = [prGre21,prAus21];
pr = [pr1;pr2];
B = 1000; %number of bootstraps

alpha = 0.05;
ts = tinv([0.025  0.975],2*length(prGre21)-2);
lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim];
limits = floor(limits);

% 
bootsPR1 = bootstrp(B,@corrcoef,pr1);
bootsPR1 = bootsPR1(:,2);
bootsPR2 = bootstrp(B,@corrcoef,pr2);
bootsPR2 = bootsPR2(:,2);

dif = bootsPR1 - bootsPR2;
dif = sort(dif);
CIBoot = dif(limits)';
disp('Confidence Interval:')
fprintf('\n')
disp(CIBoot)

%% Comments
% We see that there is no significant difference between the two 
% correlations, since 0 is in the CI.
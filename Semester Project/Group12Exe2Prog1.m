%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 2: Description
% Do the European Positivity Rate distributions of 2 different outburst
% periods differ signifficantly? Kolmogovov - Smirnov Test.

%% Clearing everything
clear;
clc;
close all;

%% Importing data from excel file
% We used our function Group12Exe1Func1.m to get
% the positivity rate data of each country. We selected only the
% national data. Period 1 is going to be last 6 weeks of 2021 and
% period 2 is going to be the last 6 weeks of 2020.
%
% Note: Data for last 6 weeks for France, Hungary,and Latvia was missing so
% we decided to consider these weeks as the mean of the days
% right before and right after the missing values and manually corrected
% the .xlsx file.

load('Exe3.mat')
% Exe3.mat was created for faster code run and has the following data:
% allData = readtable('ECDC-7Days-Testing.xlsx');
% CountryNames = readtable('EuropeanCountries.xlsx');
% countries = CountryNames.Country;
%% %%%%%%%%% Period 0 - 2021
period = 0;
pr_2021 = zeros(25,1);
tWeeks = (1:1:length(countries))';
for i = 1:length(countries)
    [pr_2021(i),pr] = Group12Exe1Func1(countries{i},allData,period);
end


%% %%%%%%%%% Period 1 - 2021
period = 1;
% tWeeks = (1:1:length(countries))';
pr_2020 = zeros(25,1);
for i = 1:length(countries)
    [pr_2020(i),pr] = Group12Exe1Func1(countries{i},allData,period);
end

%%  Kolmogorov - Smirnov Test / Working with bootstraps
pr = [pr_2020;pr_2021];
[h,p] = kstest2(pr_2020,pr_2021)

B = 1000;
[ks_h,bootsam] = bootstrp(1000,@kstest2,pr_2020,pr_2021);

ks_h;
% Percentage of rejection
fprintf('Percentage of rejection of the hypothesis that \nthe PRs come from the same distribution: %f \n',...
    length(find(ks_h))*100/length(ks_h));

%% Comments
% To check if the distributions differ significantly, we use the ks test.
% When using bootstraps from the common pool/sample, with kstest2, we can
% see that there is a significant percentage of rejections of the null
% hypothesis, thus the PRs could be statistically different in these 2
% periods.
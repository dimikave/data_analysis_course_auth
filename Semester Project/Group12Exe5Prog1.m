%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 5: Description
% With which country's PR does Greece's PR is correlated the last 3 months?
% Parametric and permutation tests for the correlation coefficient.

%% Clearing everything
clear;
clc;
close all;

%% Importing data from excel file
load('Exe3.mat')
% allData = readtable('ECDC-7Days-Testing.xlsx');
% CountryNames = readtable('EuropeanCountries.xlsx');
% countries = CountryNames.Country;

%% Plots for countries at period 2021 W38-W50
prBel21 = Group12Exe5Func1('Belgium',allData);
prAus21 = Group12Exe5Func1('Austria',allData);
prBul21 = Group12Exe5Func1('Bulgaria',allData);
prCro21 = Group12Exe5Func1('Croatia',allData);
prCyp21 = Group12Exe5Func1('Cyprus',allData);
prGre21 = Group12Exe5Func1('Greece',allData);


figure
plot(prBel21)
hold on
plot(prAus21)
plot(prBul21)
plot(prCro21)
plot(prCyp21)
plot(prGre21)
ylabel('PR')
xlabel('Weeks')
grid on
legend('Belgium','Austria','Bulgaria','Croatia','Cyprus','Greece')
title('PR for the last 3 months of 2021')

% Normalizing all data - for better understanding of correlation
prBel21n = normalize(prBel21);
prGre21n = normalize(prGre21);
prAus21n = normalize(prAus21);
prCro21n = normalize(prCro21);
prCyp21n = normalize(prCyp21);
prBul21n = normalize(prBul21);

figure
plot(prBel21n)
hold on
plot(prAus21n)
plot(prBul21n)
plot(prCro21n)
plot(prCyp21n)
plot(prGre21n,'--')
ylabel('PR')
xlabel('Weeks')
grid on
legend('Belgium','Austria','Bulgaria','Croatia','Cyprus','Greece')
title('Normalized PR for the last 3 months of 2021')
%% Paerson Correlation Coefficient - alpha = 0.05
alpha = 0.05;
[paramHypothesisTesting_BelGr,permHypothesisTesting_BelGr] = ...
    Group12Exe5Func2(prBel21,prGre21,alpha);

[paramHypothesisTesting_AusGr,permHypothesisTesting_AusGr] = ...
    Group12Exe5Func2(prAus21,prGre21,alpha);

[paramHypothesisTesting_BulGr,permHypothesisTesting_BulGr] = ...
    Group12Exe5Func2(prBul21,prGre21,alpha);

[paramHypothesisTesting_CroGr,permHypothesisTesting_CroGr] = ...
    Group12Exe5Func2(prCro21,prGre21,alpha);

[paramHypothesisTesting_CypGr,permHypothesisTesting_CypGr] = ...
    Group12Exe5Func2(prCyp21,prGre21,alpha);

param005 = [paramHypothesisTesting_BelGr; paramHypothesisTesting_AusGr;...
    paramHypothesisTesting_BulGr ; paramHypothesisTesting_CroGr;...
    paramHypothesisTesting_CypGr];

perm005 = [permHypothesisTesting_BelGr; permHypothesisTesting_AusGr;...
    permHypothesisTesting_BulGr; permHypothesisTesting_CroGr;...
    permHypothesisTesting_CypGr];

%% Paerson Correlation Coefficient - alpha = 0.01
alpha = 0.01;
[paramHypothesisTesting_BelGr,permHypothesisTesting_BelGr] = ...
    Group12Exe5Func2(prBel21,prGre21,alpha);

[paramHypothesisTesting_AusGr,permHypothesisTesting_AusGr] = ...
    Group12Exe5Func2(prAus21,prGre21,alpha);

[paramHypothesisTesting_BulGr,permHypothesisTesting_BulGr] = ...
    Group12Exe5Func2(prBul21,prGre21,alpha);

[paramHypothesisTesting_CroGr,permHypothesisTesting_CroGr] = ...
    Group12Exe5Func2(prCro21,prGre21,alpha);

[paramHypothesisTesting_CypGr,permHypothesisTesting_CypGr] = ...
    Group12Exe5Func2(prCyp21,prGre21,alpha);

param001 = [paramHypothesisTesting_BelGr; paramHypothesisTesting_AusGr;...
    paramHypothesisTesting_BulGr ; paramHypothesisTesting_CroGr;...
    paramHypothesisTesting_CypGr];

perm001 = [permHypothesisTesting_BelGr; permHypothesisTesting_AusGr;...
    permHypothesisTesting_BulGr; permHypothesisTesting_CroGr;...
    permHypothesisTesting_CypGr];
%% Display Results
R1 = corrcoef(prBel21,prGre21);
R2 = corrcoef(prAus21,prGre21);
R3 = corrcoef(prBul21,prGre21);
R4 = corrcoef(prCro21,prGre21);
R5 = corrcoef(prCyp21,prGre21);
r = [R1(1,2); R2(1,2); R3(1,2); R4(1,2); R5(1,2)];

fprintf('Comparison of results: With which country s PR does Greece s PR is most correlated in the last 3 months?\n')
variableNames = {'CorrCoeff','Parametric_a_005','Permutation_a_005','Parametric_a_001','Permutation_a_001'};
rowNames = {'Belgium','Austria','Bulgaria','Croatia','Cyprus'};
arr = [r param005 perm005 param001 perm001];
table = array2table(arr,'Rownames',rowNames,'VariableNames',variableNames);
disp(table)

%% Comments
% We can see that there is correlation on the PRs between some of the
% countries, but not significantly strong (r>0.9). However, the order of
% significance is:
%                   1) Belgium  - Greece : r =  0.8367
%                   2) Austria  - Greece : r =  0.8138
%                   3) Croatia  - Greece : r =  0.7467
%                   4) Cyprus   - Greece : r =  0.4007
%                   5) Bulgaria - Greece : r = -0.1678
%

% Thus, Greece's PR is mostly correlated with Belgium's PR at the period of
% interest.


figure
plot(prGre21n)
hold on
plot(prBel21n)
grid on
xlabel('Weeks')
ylabel('PRs')
legend('Greece','Belgium')
title('Normalized PR to show similarity')
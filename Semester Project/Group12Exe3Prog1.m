%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 3: Description
% When does Greece's weekly PR is statisticaly different than the European
% one?

%% Clearing everything
clear;
clc;
close all;

%% Importing data from excel file
load('Exe3.mat')
% Exe3.mat was created for faster code run and has the following data:
% allData = readtable('ECDC-7Days-Testing.xlsx');
% CountryNames = readtable('EuropeanCountries.xlsx');
% countries = CountryNames.Country;
Belgium = allData(91:184,:);

%% Finding Belgium Peaks
findpeaks(Belgium.positivity_rate)
title('Belgium Weekly Positivity Rate')
xlabel('Weeks')
ylabel('PR')
[pks,lcs] = findpeaks(Belgium.positivity_rate);% We find the week on which
                                              % Belgium pr peaks
week = lcs(end);
% week = 92

%% Checking for statistical difference between Greek and European PRs
%Initializing
PosRateGr = zeros(12,1);
prEur = zeros(12,1);
diafora = zeros(12,1);
B_CI = zeros(12,2);
j = 1;
% CI/difference calculation
for i = week-11:week
    [B_CI(j,:),diafora(j),PosRateGr(j),prEur(j)] = ...
        Group12Exe3Func1(Greece,i,allData);
    j = j+1;
end

tWeeks = (week-11:1:week)';
% Plotting differences
figure
plot(tWeeks,PosRateGr)
hold on
plot(tWeeks,prEur)
grid on
xlabel('Weeks')
ylabel('PR')
title('Positivity Rate / Greece vs Europe')
legend('Greek PR','Europe PR')

%% Display results
variableNames = {'European_PR','Greek_PR','Statistical_Difference'};
prArray = [prEur PosRateGr diafora];
table = array2table(prArray,'VariableNames',variableNames);
disp(table)

%% Comments
% As we can see both from the plot and from the vector of
% differences (diafora), the two PRs differ at the first 2 weeks, then they
% have statistical difference for the next 5 weeks,and for the rest 5 weeks
% they differ significantly ( Greek PR is getting lower while Europe's PR 
% is getting higher)
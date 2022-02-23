%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 4: Description
% Are there significant differences at the PR's in Europe at the last 2
% months with the corresponding last 2 months of 2020? Bootstrap and
% Parametric tests.
%% Clearing everything
clear;
clc;
close all;

%% Importing data from excel file

% Note: Data for last 8 weeks for France, Hungary, Cyprus and Latvia was missing so
% we decided to consider these weeks as the mean of the days
% right before and right after the missing values and manually corrected
% the .xlsx file.

% allData = readtable('ECDC-7Days-Testing.xlsx');
% CountryNames = readtable('EuropeanCountries.xlsx');
% countries = CountryNames.Country;
load('Exe3.mat')
%% Pr for countries of interest - 2020
period = 1;
prBel20 = Group12Exe4Func1('Belgium',allData,period);
prAus20 = Group12Exe4Func1('Austria',allData,period);
prBul20 = Group12Exe4Func1('Bulgaria',allData,period);
prCro20 = Group12Exe4Func1('Croatia',allData,period);
prCyp20 = Group12Exe4Func1('Cyprus',allData,period);

% Plot the data
figure
plot(prBel20)
hold on
plot(prAus20)
plot(prBul20)
plot(prCro20)
plot(prCyp20)
ylabel('PR')
xlabel('Weeks')
legend('Belgium','Austria','Bulgaria','Croatia','Cyprus')
title('PR for the last two months of 2020')

%% Pr for countries of interest - 2021
period = 0;
prBel21 = Group12Exe4Func1('Belgium',allData,period);
prAus21 = Group12Exe4Func1('Austria',allData,period);
prBul21 = Group12Exe4Func1('Bulgaria',allData,period);
prCro21 = Group12Exe4Func1('Croatia',allData,period);
prCyp21 = Group12Exe4Func1('Cyprus',allData,period);

% Plot the data
figure
plot(prBel21)
hold on
plot(prAus21)
plot(prBul21)
plot(prCro21)
plot(prCyp21)
ylabel('PR')
xlabel('Weeks')
legend('Belgium','Austria','Bulgaria','Croatia','Cyprus')
title('PR for the last two months of 2021')

%% Plots 2020 vs 2021
figure
subplot(5,1,1)
plot(prBel20)
hold on
plot(prBel21)
ylabel('PR')
xlabel('Weeks')
legend('Belgium 2020','Belgium 2021')
title('PR for the last two months of 2020 vs last two months of 2020 - Belgium')

subplot(5,1,2)
plot(prAus20)
hold on
plot(prAus21)
ylabel('PR')
xlabel('Weeks')
legend('Austria 2020','Austria 2021')
title('PR for the last two months of 2020 vs last two months of 2020 - Austria')

subplot(5,1,3)
plot(prBul20)
hold on
plot(prBul21)
ylabel('PR')
xlabel('Weeks')
legend('Bulgaria 2020','Bulgaria 2021')
title('PR for the last two months of 2020 vs last two months of 2020 - Bulgaria')

subplot(5,1,4)
plot(prCro20)
hold on
plot(prCro21)
ylabel('PR')
xlabel('Weeks')
legend('Croatia 2020','Croatia 2021')
title('PR for the last two months of 2020 vs last two months of 2020 - Croatia')

subplot(5,1,5)
plot(prCyp20)
hold on
plot(prCyp21)
ylabel('PR')
xlabel('Weeks')
legend('Cyprus 2020','Cyprus 2021')
title('PR for the last two months of 2020 vs last two months of 2020 - Cyprus')

%% T-tests 
[h_Bel,p_Bel,CIBel] = ttest2(prBel20,prBel21)
[h_Aus,p_Aus,CIAus] = ttest2(prAus20,prAus21)
[h_Bul,p_Bul,CIBul] = ttest2(prBul20,prBul21)
[h_Cro,p_Cro,CICro] = ttest2(prCro20,prCro21)
[h_Cyp,p_Cyp,CICyp] = ttest2(prCyp20,prCyp21)


%% Bootstrap tests
B = 1000;
alpha = 0.05;
lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim];
limits = floor(limits);

CIBootBel = zeros(1,2);
bootsX = bootstrp(B,@mean,prBel20);
bootsY = bootstrp(B,@mean,prBel21);
dif = bootsX - bootsY;
dif = sort(dif);
CIBootBel(1,:) = dif(limits);

CIBootAus = zeros(1,2);
bootsX = bootstrp(B,@mean,prAus20);
bootsY = bootstrp(B,@mean,prAus21);
dif = bootsX - bootsY;
dif = sort(dif);
CIBootAus(1,:) = dif(limits);

CIBootBul = zeros(1,2);
bootsX = bootstrp(B,@mean,prBul20);
bootsY = bootstrp(B,@mean,prBul21);
dif = bootsX - bootsY;
dif = sort(dif);
CIBootBul(1,:) = dif(limits);

CIBootCro = zeros(1,2);
bootsX = bootstrp(B,@mean,prCro20);
bootsY = bootstrp(B,@mean,prCro21);
dif = bootsX - bootsY;
dif = sort(dif);
CIBootCro(1,:) = dif(limits);

CIBootCyp = zeros(1,2);
bootsX = bootstrp(B,@mean,prCyp20);
bootsY = bootstrp(B,@mean,prCyp21);
dif = bootsX - bootsY;
dif = sort(dif);
CIBootCyp(1,:) = dif(limits);

%% Display Results
variableNames = {'Parametric_CI_Low','Parametric_CI_Up',...
    'Bootstrap_CI_Low','Bootstrap_CI_Up'};
rowNames = {'Belgium','Austria','Bulgaria','Croatia','Cyprus'};
CIs = [CIBel' CIBootBel; CIAus' CIBootAus; CIBul' CIBootBul; CICro'...
    CIBootCro; CICyp' CIBootCyp];
table = array2table(CIs,'Rownames',rowNames,'VariableNames',variableNames);
disp(table)
%% Comments
% As we can see, for 4/5 countries, the positivity rate differs statisticly
% from 2020 to 2021 (it is lower in 2021). We can see that from the
% parametric ttest as well as from the bootstrap confidence intervals.
% However, the country of inerest A : Belgium, even if it seems to have
% differences on the plot, the ttest and bootstrap test indicate that the
% two samples can be from the same distribution, and thus not differ much
% statistically, since 0 is in both the bootstrap CI as well as the
% Parametri CI.
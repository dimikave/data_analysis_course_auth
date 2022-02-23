%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 1: Description
% Is there a common distribution that approaches the distribution of the
% European Positivity Rate at 2 specific periods?

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

% Note 2: We keep only the national data, not the subnational.

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
% plot(pr_2021)

% %% Normalizing
% norPosRate2021 = normalize(pr_2021,'norm',1);

%% Normal Distribution Check
sc1 = figure(1);
tam=get(0,'ScreenSize');
set(sc1,'position',[tam(1) tam(2) tam(3) tam(4)]); % position and size figure in the screen
subplot(1,2,1)
histfit(pr_2021,25,'normal')
title('Histogram of PR 2021 - Normal Distribution Fit')


% pdPosRate = fitdist(pr_2021,'Normal');
% vPosRate = pdf(pdPosRate,tWeeks);
% figure
% bar(tWeeks,norPosRate2021)
% grid on
% title('Bargraph of normalized positivity rate - checking for Normal distribution fit')
% xlabel('Countries')
% ylabel('PR')
% hold on
% plot(vPosRate)

%% Exponential Distribution Check
sc2 = figure(2);
tam=get(0,'ScreenSize');
set(sc2,'position',[tam(1) tam(2) tam(3) tam(4)]); % position and size figure in the screen
subplot(1,2,1)
histfit(pr_2021,25,'exponential')
title('Histogram of PR 2021 - Exponential Distribution Fit')
% pdPosRate = fitdist(pr_2021,'Exponential');
% vPosRate = pdf(pdPosRate,tWeeks);
% figure
% bar(tWeeks,norPosRate2021)
% grid on
% title('Bargraph of normalized positivity rate - checking for Normal distribution fit')
% xlabel('Countries')
% ylabel('PR')
% hold on
% plot(vPosRate)

%% Weibull Distribution Check
sc3 = figure(3);
tam=get(0,'ScreenSize');
set(sc3,'position',[tam(1) tam(2) tam(3) tam(4)]); % position and size figure in the screen
subplot(1,2,1)
histfit(pr_2021,25,'weibull')
title('Histogram of PR 2021 - Weibull Distribution Fit')

%% Gamma Distribution Check
sc4 = figure(4);
tam=get(0,'ScreenSize');
set(sc4,'position',[tam(1) tam(2) tam(3) tam(4)]); % position and size figure in the screen
subplot(1,2,1)
histfit(pr_2021,25,'gamma')
title('Histogram of PR 2021 - Gamma Distribution Fit')
%% Inverse Gaussian Distribution Check
sc5 = figure(5);
tam=get(0,'ScreenSize');
set(sc5,'position',[tam(1) tam(2) tam(3) tam(4)]); % position and size figure in the screen
subplot(1,2,1)
histfit(pr_2021,25,'inverse gaussian')
title('Histogram of PR 2021 - Inverse Gaussian Distribution Fit')
%% %%%%%%%%% Period 1 - 2020
period = 1;
% tWeeks = (1:1:length(countries))';
pr_2020 = zeros(25,1);
for i = 1:length(countries)
    [pr_2020(i),pr] = Group12Exe1Func1(countries{i},allData,period);
end

%% Normal Distribution Check
figure(1)
subplot(1,2,2)
histfit(pr_2020,25,'normal')
title('Histogram of PR 2020 - Normal Distribution Fit')
% pdPosRate = fitdist(pr_2021,'Normal');
% vPosRate = pdf(pdPosRate,tWeeks);
% figure
% bar(tWeeks,norPosRate2021)
% grid on
% title('Bargraph of normalized positivity rate - checking for Normal distribution fit')
% xlabel('Countries')
% ylabel('PR')
% hold on
% plot(vPosRate)

%% Exponential Distribution Check
figure(2)
subplot(1,2,2)
histfit(pr_2020,25,'exponential')
title('Histogram of PR 2020 - Exponential Distribution Fit')

% pdPosRate = fitdist(pr_2021,'Exponential');
% vPosRate = pdf(pdPosRate,tWeeks);
% figure
% bar(tWeeks,norPosRate2021)
% grid on
% title('Bargraph of normalized positivity rate - checking for Normal distribution fit')
% xlabel('Countries')
% ylabel('PR')
% hold on
% plot(vPosRate)

%% Weibull Distribution Check
figure(3)
subplot(1,2,2)
histfit(pr_2020,25,'weibull')
title('Histogram of PR 2020 - Weibull Distribution Fit')

%% Gamma Distribution Check
figure(4)
subplot(1,2,2)
histfit(pr_2020,25,'gamma')
title('Histogram of PR 2020 - Gamma Distribution Fit')

%% Inverse Gaussian Distribution Check
figure(5)
subplot(1,2,2)
histfit(pr_2020,25,'inverse gaussian')
title('Histogram of PR 2020 - Inverse Gaussian Distribution Fit')

%% Just a presentation of data
variableNames = {'European_PR_Last_6_weeks_of_2020',...
    'European_PR_Last_6_weeks_of_2021'};
rowNames = countries;
prArray = [pr_2020 pr_2021];
table = array2table(prArray,'Rownames',rowNames,'VariableNames',variableNames);
disp(table)
%% Comments
% No distribution seems to fit. Since PR not only depends on the new cases, 
% but also
% on the tests performed, the intuition behind a distribution of the PR's
% histogram is not clear and we can't safely say that a distribution that
% fits is reasonable because of the new cases outburst on these periods. We
% could say that from all distributions tested, the best one for period 1
% is probably the expononential distribution, but this is not verified by
% some metric (it is just visual conclusion).
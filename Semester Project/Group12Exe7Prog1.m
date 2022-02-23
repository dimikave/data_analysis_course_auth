%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 7: Description
% Can we predict deaths from COVID based on the PRs of some previous week?
% At which lag tau?

%% Clearing everything
clear;
clc;
close all;

%% Importing data from excel file

% allData = readtable('ECDC-7Days-Testing.xlsx');
% CountryNames = readtable('EuropeanCountries.xlsx');
% countries = CountryNames.Country;
% Greece = readtable('FullEodyData.xlsx');
load('Exe3.mat')
BD = readtable('BelgiumDeaths.xlsx');

% Extracting Weekly Deaths per 1000000 for Belgium
BDeaths = BD.weekly_count;
BDeaths = BDeaths(11:end-1);
% Extracting Weekly PRs for Belgium
a = allData.level == string('national');
b = allData.country == string('Belgium');
c = bitand(a,b);
BPr = allData.positivity_rate(c==1);
BPr = BPr(3:end);
BDeaths = ceil(1000000*BDeaths/BD.population(1));
tWeeks = (11:1:103)';

BPr_nor = normalize(BPr);
BDeaths_nor = normalize(BDeaths);
figure
plot(tWeeks,BPr_nor)
hold on
grid on
plot(tWeeks,BDeaths_nor)
title('Normalized Belgium Weekly Positivity Rates and Deaths vs time')
xlabel('Time (Weeks)')
legend('Positivity Rate','Deaths')

% We can already see from the plot that the optimal delay is going to be a
% small number since the two plots are very similar one shifted by a little
% from the other.
%% Period 0 : 2020-W29 -- 2020-W44 (16 weeks)
period = 0;
Y1 = BDeaths(44-10-15:44-10);
figure
weeks = 44-10-15:44-10;
plot(weeks,Y1)
xlabel('Week')
ylabel('Deaths')
title('Belgium Deaths on period 0')

minRMSE = 1e6;
argMin = -1;

figure
for t = 0:5
    X1 = BPr(44-10-15-t:44-10-t);
    regressionModel = fitlm(X1,Y1);
    subplot(2,6,t+1)
    scatter(X1,Y1)
    hold on
    lsline
    title('Fitting for lag = '+string(t))
    % Diagnostic plot of standardised error
    ei_standard = regressionModel.Residuals.Raw/regressionModel.RMSE;
    subplot(2,6,t+7)
    scatter(Y1,ei_standard);
    hold on;
    plot(xlim,[1.96 1.96]);
    hold on;
    plot(xlim,[0 0]);
    hold on;
    plot(xlim,[-1.96 -1.96]);
    title(string('Belgium  Diagnostic Plot: t = '+ string(t)));
    xlabel('Y')
    ylabel('Standard Error');

    
    % Find optimal model based RMSE
    if(regressionModel.RMSE < minRMSE)
        minRMSE = regressionModel.RMSE;
        argMin = t;
        maxR2 = regressionModel.Rsquared.Ordinary;
    end
end
t = argMin;
X1 = BPr(44-10-15-t:44-10-t);
regressionModel = fitlm(X1,Y1);
b = regressionModel.Coefficients.Estimate;
Xnew = BPr(44-10-t+1:44-10-t+7);
% yGT = BDeaths(44-10-t+1:44-10-t+7);
% ypred = predict(regressionModel,Xnew);
yGT = Y1;
ypred = predict(regressionModel,X1);
% [ypred yGT]
t_p1 = t;
fprintf('Best model in period 0 is for lag (tau) = %i with Rsquared = %f \n',t_p1,maxR2)


%% Period 1 : 
% period = 0;
Y1 = BDeaths(75-10-15:75-10);
figure
weeks = 75-10-15:75-10;
plot(weeks,Y1)
xlabel('Week')
ylabel('Deaths')
title('Belgium Deaths on period 1')

minRMSE = 1e6;
argMin = -1;

figure
for t = 0:5
    X1 = BPr(75-10-15-t:75-10-t);
    regressionModel = fitlm(X1,Y1);
    subplot(2,6,t+1)
    scatter(X1,Y1)
    hold on
    lsline
    title('Fitting for lag = '+string(t))
    % Diagnostic plot of standardised error
    ei_standard = regressionModel.Residuals.Raw/regressionModel.RMSE;
    subplot(2,6,t+7)
    scatter(Y1,ei_standard);
    hold on;
    plot(xlim,[1.96 1.96]);
    hold on;
    plot(xlim,[0 0]);
    hold on;
    plot(xlim,[-1.96 -1.96]);
    title(string('Belgium  Diagnostic Plot: t = '+ string(t)));
    xlabel('Y')
    ylabel('Standard Error');

    
    % Find optimal model
    if(regressionModel.RMSE < minRMSE)
        minRMSE = regressionModel.RMSE;
        argMin = t;
        maxR2 = regressionModel.Rsquared.Ordinary;
    end
end
t = argMin;
X1 = BPr(75-10-15-t:75-10-t);
regressionModel = fitlm(X1,Y1);
b = regressionModel.Coefficients.Estimate;
Xnew = BPr(75-10-t+1:75-10-t+7);
% yGT = BDeaths(44-10-t+1:44-10-t+7);
% ypred = predict(regressionModel,Xnew);
yGT = Y1;
ypred = predict(regressionModel,X1);
% [ypred yGT]
t_p2 = t;
fprintf('Best model on period 1 is for lag (tau) = %i, with Rsquared = %f \n',t_p2,maxR2)

%% Comments:
% We can see that the plot and the numerical results we get from the
% optimal lag are in harmony, meaning that we get what we expected. Results
% between the 2 different periods differ a little bit, but in a reasonable
% manner. Moreover, this little lag we get (2 and 0) is pretty reasonable
% meaning that 2 weeks lag between cases and deaths is a number aligned 
% with the medical studies on COVID.
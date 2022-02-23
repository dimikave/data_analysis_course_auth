%% Data Analysis Project Winter Semester 2021-2022
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

%% Exercise 8: Description
% Can we do trustworthy prediction on Greece's deaths based on PR's many
% days before? (Multiple linear regression model)

%% Clearing everything
clear;
clc;
close all;

%% Note: If you want to see the plots -> plots = 1, otherwise, plots = 0
plots = 1;

%% Importing data from excel file
load('Exe3.mat')
% allData = readtable('ECDC-7Days-Testing.xlsx');
% CountryNames = readtable('EuropeanCountries.xlsx');
% countries = CountryNames.Country;

% Extracting valid data - Greece's PR
Greece.Rapid_Tests(isnan(Greece.Rapid_Tests))=0;
GrPR = Greece.NewCases./(Greece.PCR_Tests + Greece.Rapid_Tests)*100;
GrPR = GrPR(1:end-7);

% Greece's Deaths
GrDeaths = Greece.New_Deaths(1:end-7);
% Filling NaN with zeros
GrDeaths(isnan(GrDeaths))=0;

% Normalizing
GrD_n = normalize(GrDeaths);
GrPR_n = normalize(GrPR);

% Plot
figure
plot(GrPR_n)
hold on
grid on
plot(GrD_n)
title('Normalized Belgium Weekly Positivity Rates and Deaths vs time')
xlabel('Time (Days)')
legend('Positivity Rate','Deaths')

%% Function handles
Rsq = @(ypred,y) 1-sum((ypred-y).^2)/sum((y-mean(y)).^2);
adjRsq = @(ypred,y,n,k) ( 1 - (n-1)/(n-1-k)*sum((ypred-y).^2)/sum((y-mean(y)).^2) );

%% 12 Weeks - Period 1:

day1 = 200;             % Period 1
Y = GrDeaths(day1:day1+84);
j = 1;
countFull = 0;             % Counter for full model
countRed = 0;               % Counter for reduced model
for t = 0:30
    if (plots == 1)
        figure
    end
    if t==0 
        X = GrPR(day1:day1+84);
        mdl = fitlm(X,Y);
    else
        X = zeros(size(Y,1),t+2);
        X(:,1) = ones(size(Y,1),1);
        for tau = 2:t+2
            X(:,tau) = GrPR(day1-tau+2:day1+84-tau+2);
            % Feature scaling
        end
    end
    
    
    % Regression
    b = regress(Y,X);
    Ypred = X*b;
    
    k = t+1;
    % Save R2 and adjR2
    R2Array(j,1) = Rsq(Ypred,Y);
    if t>0
        AdjR2Array(j,1) = adjRsq(Ypred,Y,length(Y),k);
    else
        AdjR2Array(j,1)= mdl.Rsquared.Adjusted;
    end
    % Diagnostic plot of standardised error
    error = Y - Ypred;
    se = sqrt( 1/(length(X)-k-1) * (sum(error.^2)));
    ei_standard = error./se;
    subplot(2,1,1)
    scatter(Y,ei_standard);
    hold on;
    plot(xlim,[1.96 1.96]);
    plot(xlim,[0 0]);
    plot(xlim,[-1.96 -1.96]);
    title(string('Diagnostic Plot: Full Linear Model with '+string(t+1)+' DOF'));
    text(6,-1.25,string('R^2='+string(R2Array(j,1))),'FontSize',12);
    text(6,-1.75,string('Adj R^2='+string(AdjR2Array(j,1))),'FontSize',12);
    xlabel('Y')
    ylabel('Standard Error');
    
    % Step wise regression
    if t>0
        X1 = X(:,2:end);
        [b,~,~,model,stats] = stepwisefit(X1,Y,'Display','off');
        b0 = stats.intercept;
        b = [b0; b(model)];
        stepwiseNumberOfVariables(j) = length(b) - 1;

        Ypred = [ones(length(X),1) X(:,model)]*b;

         % Save R2 and adjR2
        R2Array(j,2) = (1-stats.SSresid/stats.SStotal);
        AdjR2Array(j,2) = adjRsq(Ypred,Y,length(Y),stepwiseNumberOfVariables(j));

        error = Y - Ypred;
        se = sqrt( 1/(length(X)-stepwiseNumberOfVariables(j)-1) * (sum(error.^2)));
        ei_standard = error./se;
        subplot(2,1,2)
        scatter(Y,ei_standard);
        hold on;
        plot(xlim,[1.96 1.96]);
        plot(xlim,[0 0]);
        plot(xlim,[-1.96 -1.96]);
        title(string('Diagnostic Plot: Full Linear Model with '+string(t+1)+' DOF - Dim Reduction'));
        text(6,-1,string('R^2='+string(R2Array(j,2))),'FontSize',12);
        text(6,-1.5,string('Adj R^2='+string(AdjR2Array(j,2))),'FontSize',12);
        xlabel('Y')
        ylabel('Standard Error');
        
        if AdjR2Array(j,1)>AdjR2Array(j,2)
            countFull = countFull + 1;
        else
            countRed = countRed + 1;
        end
        j = j+1;
    end
end
[r(1,:),ind(1,:)] = max(R2Array);
[a(1,:),i(1,:)] = max(AdjR2Array);
if (plots == 0)
    close all
end
%% 12 Weeks - Period 2
day1 = 400;             % Period 2
Y = GrDeaths(day1:day1+84);
j = 1;
countFull = 0;             % Counter for full model
countRed = 0;               % Counter for reduced model
for t = 0:30
    if (plots == 1)
        figure
    end
    if t==0
        X = GrPR(day1:day1+84);
        mdl = fitlm(X,Y);
    else
        X = zeros(size(Y,1),t+2);
        X(:,1) = ones(size(Y,1),1);
        for tau = 2:t+2
            X(:,tau) = GrPR(day1-tau+2:day1+84-tau+2);
            % Feature scaling
        end
    end
    
    
    % Regression
    b = regress(Y,X);
    Ypred = X*b;
    YpredFull = Ypred;
    
    k = t+1;
    % Save R2 and adjR2
    R2Array(j,1) = Rsq(Ypred,Y);
    if t>0
        AdjR2Array(j,1) = adjRsq(Ypred,Y,length(Y),k);
    else
        AdjR2Array(j,1)= mdl.Rsquared.Adjusted;
    end
    % Diagnostic plot of standardised error
    error = Y - Ypred;
    se = sqrt( 1/(length(X)-k-1) * (sum(error.^2)));
    ei_standard = error./se;
    subplot(2,1,1)
    scatter(Y,ei_standard);
    hold on;
    plot(xlim,[1.96 1.96]);
    plot(xlim,[0 0]);
    plot(xlim,[-1.96 -1.96]);
    title(string('Diagnostic Plot: Full Linear Model with '+string(t+1)+' DOF'));
    text(6,-1.25,string('R^2='+string(R2Array(j,1))),'FontSize',12);
    text(6,-1.75,string('Adj R^2='+string(AdjR2Array(j,1))),'FontSize',12);
    xlabel('Y')
    ylabel('Standard Error');
    
    % Step wise regression
    if t>0
        X1 = X(:,2:end);
        [b,~,~,model,stats] = stepwisefit(X1,Y,'Display','off');
        b0 = stats.intercept;
        b = [b0; b(model)];
        stepwiseNumberOfVariables(j) = length(b) - 1;

        Ypred = [ones(length(X),1) X(:,model)]*b;
        YpredStep = Ypred;

         % Save R2 and adjR2
        R2Array(j,2) = (1-stats.SSresid/stats.SStotal);
        AdjR2Array(j,2) = adjRsq(Ypred,Y,length(Y),stepwiseNumberOfVariables(j));

        error = Y - Ypred;
        se = sqrt( 1/(length(X)-stepwiseNumberOfVariables(j)-1) * (sum(error.^2)));
        ei_standard = error./se;
        subplot(2,1,2)
        scatter(Y,ei_standard);
        hold on;
        plot(xlim,[1.96 1.96]);
        plot(xlim,[0 0]);
        plot(xlim,[-1.96 -1.96]);
        title(string('Diagnostic Plot: Full Linear Model with '+string(t+1)+' DOF - Dim Reduction'));
        text(6,-1,string('R^2='+string(R2Array(j,2))),'FontSize',12);
        text(6,-1.5,string('Adj R^2='+string(AdjR2Array(j,2))),'FontSize',12);
        xlabel('Y')
        ylabel('Standard Error');
        
        if AdjR2Array(j,1)>AdjR2Array(j,2)
            countFull = countFull + 1;
        else
            countRed = countRed + 1;
        end
        j = j+1;
    end
end
[r(2,:),ind(2,:)] = max(R2Array);
[a(2,:),i(2,:)] = max(AdjR2Array);
if (plots==0)
    close all
end
%% Display results
fprintf('Comparison of best results: \n')
variableNames = {'R_Squared_Ordinary','lag_Ordinary_Rsq','Adjusted_R_Squared_Ordinary','lag__Ordinary_Adj','R_Squared_StepWise','lag_StepWise_Rsq','Adjusted_R_Squared_StepWise','lag_StepWise_Adj'};
rowNames = {'Period_1','Period_2'};
arr = [r(1,1) ind(1,1) a(1,1) i(1,1) r(1,2) ind(1,2) a(1,2) i(1,2);...
    r(2,1) ind(2,1) a(2,1) i(2,1) r(2,2) ind(2,2) a(2,2) i(2,2)];
table = array2table(arr','Rownames',variableNames,'VariableNames',rowNames);
disp(table)
%% Comments:
% The multiple regression model seems to work better than the simple
% regression model. As we can see, the full models work better than the
% reduced models in general, and the first period's models seem to fit the
% data better. However, the reduced models are also
% good and thus, for our decision we must consider the trade-off
% between performance and complexity.
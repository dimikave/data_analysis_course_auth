%% Data Analysis Course 2021 - Exercise 5.4

% Clearing
clear;
close all;
clc;

lightair = importdata("lightair.dat");
X = lightair(:,1);
Y = lightair(:,2);
r = corrcoef(X,Y);

% A
% Scatter plot
figure(1)
scatter(X, Y);
hold on;
title("Scatter plot")
xlabel("Air density")
ylabel("Speed of light")


% B
% Compute regression model
regressionModel = fitlm(X,Y);
b = regressionModel.Coefficients.Estimate;

% Plot reggression
% lsline
Xones = [ones(length(X),1) X];
regression = Xones*b;
plot(X,regression,'-')
hold on;

BCI = coefCI(regressionModel);              % same as bint from 

% C
% Plot confidence intervals
[~,ypredCI] = predict(regressionModel, X, 'Prediction', 'curve');
[~,yobservCI] = predict(regressionModel, X, 'Prediction', 'observation');
plot(X,ypredCI,'--')
hold on;
plot(X,yobservCI,'-.')
hold on;

% Predictions for x0 = 1.29
x0 = 1.29;
[ypred,ypredCI] = predict(regressionModel, x0, 'Prediction', 'curve');
[~,yobservCI] = predict(regressionModel, x0, 'Prediction', 'observation');
plot(x0 , ypred,'x');
plot(x0, ypredCI,'*');
plot(x0, yobservCI,'p');


% D
% Real regression
breal = zeros(2,1);
breal(1) = 299792.458;
breal(2) = -299792.458*0.00029/1.29;
regression = Xones*breal - 299000;
plot(X,regression,'LineWidth',2,'LineStyle','-','Color','r')
breal(1) = breal(1) - 299000;

%% Data Analysis Course 2021 - Exercise 6.6

% Clearing
clear;
close all;
clc;

%% Initializing
% R2 and adjusted R2
Rsq = @(ypred,y) 1-sum((ypred-y).^2)/sum((y-mean(y)).^2);
adjRsq = @(ypred,y,n,k) ( 1 - (n-1)/(n-1-k)*sum((ypred-y).^2)/sum((y-mean(y)).^2) );

% Import data
data = importdata('physical.txt');
data = data.data;

X = data(:,2:end);
y = data(:,1);
n = length(X);

rmseArray = zeros(5,1);
R2Array = zeros(5,1);
adjR2Array = zeros(5,1);

% Ordinary least squares
olsModel = fitlm(X,y);
rmseArray(1) = olsModel.RMSE;
R2Array(1) = olsModel.Rsquared.Ordinary;
adjR2Array(1) = olsModel.Rsquared.Adjusted;
bOLS = olsModel.Coefficients.Estimate;
y_pred = [ones(length(X),1) X]*bOLS;

% Plots
plots(y, y_pred, rmseArray(1), 'OLS')

% PCR
covMatrix = cov(normalize(X,'center'));
[eigenVectors,eigenValues] = eig(covMatrix);
eigenValues = diag(eigenValues);
eigenValues = eigenValues(end:-1:1);

% Scree plot
figure;
plot(1:length(eigenValues),eigenValues,'-o')
title('Scree plot')
ylabel('eigenvalues')

% Calculate number of features
td = 90;
eigenValuesSum = sum(eigenValues);
sumEigenValues = 0;
i = 0;
while(sumEigenValues < td)
    i = i + 1;
    sumEigenValues = sumEigenValues + 100*eigenValues(i)/eigenValuesSum;
end

% X = normalize(X);
[~,PCAScores,~] = pca(X);
input = [ ones(length(PCAScores),1) PCAScores(:,1:end)];
%input = [ ones(length(X),1) X];
bPCR = regress(y, input);
y_pred = input*bPCR;

residuals = y - y_pred;
rmseArray(2) = sqrt( 1/(length(PCAScores)-length(bPCR)) * (sum(residuals.^2)));
R2Array(2) = Rsq(y_pred,y);
adjR2Array(2) = adjRsq(y_pred,y,length(y),length(bPCR)-1);

% Plots
plots(y, y_pred, rmseArray(2), 'PCR')

% PLS
[~,~,Xscores,~,bPLS,PCTVAR] = plsregress(X,y,5);
y_pred = [ones(n,1) X]*bPLS;

residuals = y - y_pred;
rmseArray(3) = sqrt( 1/(length(X)-length(bPLS)) * (sum(residuals.^2)));
R2Array(3) = Rsq(y_pred,y);
adjR2Array(3) = adjRsq(y_pred,y,length(y),length(bPLS)-1);

% PLCs components variance
figure;
plot(1:5,100*PCTVAR(1,:),'-bo');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in y');
title('PLS Components')

% Plots
plots(y, y_pred, rmseArray(3), 'PLS')

% Ridge regression
bRidge = ridge(y,X,1,0);
y_pred = [ones(length(X),1) X]*bRidge;

residuals = y - y_pred;
rmseArray(4) = sqrt( 1/(length(X)-length(bRidge)) * (sum(residuals.^2)));
R2Array(4) = Rsq(y_pred,y);
adjR2Array(4) = adjRsq(y_pred,y,length(y),length(bRidge)-1);

% Plots
plots(y, y_pred, rmseArray(4), 'Ridge')

% LASSO
bLASSO = lasso(X,y,'lambda',1);
%lassoPlot(bLASSO)

y_pred = X*bLASSO;

residuals = y - y_pred;
rmseArray(5) = sqrt( 1/(length(X)-length(bRidge)) * (sum(residuals.^2)));
R2Array(5) = Rsq(y_pred,y);
adjR2Array(5) = adjRsq(y_pred,y,length(y),length(bRidge)-1);

% Plots
plots(y, y_pred, rmseArray(5), 'LASSO')


% Table of Results
bLASSO = [0; bLASSO];
bAll = [bOLS, bPCR, bPLS, bRidge, bLASSO];

table = array2table(bAll,'VariableNames',{'OLS','PCR','PLS','Ridge','LASSO'});
disp(table);

function plots(y, y_pred, rmse, name)
% Scatterplot
figure;
scatter(y,y_pred);
hold on;
plot(xlim,ylim);
xlabel('y');
ylabel('y_pred');
title(name);

% Diagnostic Plot
figure;
residuals = y - y_pred;
ei_standard = residuals./rmse;
scatter(y,ei_standard);
hold on;
plot(xlim,[2 2]);
hold on;
plot(xlim,[0 0]);
hold on;
plot(xlim,[-2 -2]);
title(name);
xlabel('Y')
ylabel('Standard Error');
end
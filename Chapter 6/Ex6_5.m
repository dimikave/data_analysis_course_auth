%% Data Analysis Course 2021 - Exercise 6.5

% Clearing
clear;
close all;
clc;

%% Initializing

% Import data
data = importdata('physical.txt')
data = data.data;

% Function handles:
% R2 and adjusted R2
Rsq = @(ypred,y) 1-sum((ypred-y).^2)/sum((y-mean(y)).^2);
adjRsq = @(ypred,y,n,k) ( 1 - (n-1)/(n-1-k)*sum((ypred-y).^2)/sum((y-mean(y)).^2) );

% Generate data
n = 1000;
p = 5;
X = zeros(n,p);
%mu = [1, 5, 25, 125, 625];
mu = [1, 2, 3, 4, 5];
b = [0; 2; 0; -3; 0];

for i = 1:p
    samples = exprnd(mu(i),n,1);
    X(:,i) = samples;
end

noiseStd = 25;
e = normrnd(0,noiseStd,n,1);
y = X*b + e;

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

fet = olsModel.Residuals.Raw/olsModel.RMSE;

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
xlabel('Number of pca components')

% Calculate number of features
td = 90;
eigenValuesSum = sum(eigenValues);
sumEigenValues = 0;
i = 0;
while(sumEigenValues < td)
    i = i + 1;
    sumEigenValues = sumEigenValues + 100*eigenValues(i)/eigenValuesSum;
end

i = 5;
ynorm = normalize(y,'center');
xnorm = normalize(X,'center');
[PC,PCAScores,~] = pca(xnorm);
%input = [ ones(length(PCAScores),1) PCAScores(:,1:end)];
input =  PCAScores(:,1:i);
bPCR = regress(ynorm, input);
bPCR = PC(:,1:i)*bPCR;
%y_pred = input*bPCR;

d = 5;
[U,S,V] = svd(xnorm,'econ');
lambdaV = zeros(p,1);
lambdaV(1:5) = 1;
bPCR2 = V * diag(lambdaV) * inv(S) * U' * ynorm;

xMean = mean(X);
b0 = mean(y) - xMean*bPCR(:);
bPCR = [b0; bPCR];
bPCR2 = [b0; bPCR2];

residuals = ynorm - y_pred;
rmseArray(2) = sqrt( 1/(length(PCAScores)-length(bPCR)) * (sum(residuals.^2)));
R2Array(2) = Rsq(y_pred,ynorm);
adjR2Array(2) = adjRsq(y_pred,y,length(y),length(bPCR)-1);

% Plots
plots(y, y_pred, rmseArray(2), 'PCR')

% PLS
nComponents = 5;
[~,~,Xscores,~,bPLS,PCTVAR] = plsregress(X,y,nComponents);
y_pred = [ones(n,1) X]*bPLS;

residuals = y - y_pred;
rmseArray(3) = sqrt( 1/(length(X)-(nComponents+1)) * (sum(residuals.^2)));
R2Array(3) = Rsq(y_pred,y);
adjR2Array(3) = adjRsq(y_pred,y,length(y),nComponents);

% PLCs components variance
figure;
plot(1:nComponents,100*PCTVAR(1,:),'-bo');
xlabel('Number of PLS components');
ylabel('Variance Explained in y');
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
Xnorm = normalize(X,'center');
yNorm = normalize(y,'center');
bLASSO = lasso(Xnorm,yNorm,'lambda',1);
%figure;
%lassoPlot(bLASSO,info)

xMean = mean(X);
b0 = mean(y) - xMean*bLASSO(:);
bLASSO = [b0; bLASSO];

y_pred = [ones(length(X),1) X]*bLASSO;

residuals = y - y_pred;
rmseArray(5) = sqrt( 1/(length(X)-length(bLASSO)) * (sum(residuals.^2)));
R2Array(5) = Rsq(y_pred,y);
adjR2Array(5) = adjRsq(y_pred,y,length(y),length(bLASSO)-1);

% Plots
plots(y, y_pred, rmseArray(5), 'LASSO')


b = [0; b];

bAll = [b, bOLS, bPCR, bPLS, bRidge, bLASSO];
muCell = arrayfun(@num2str, mu, 'UniformOutput', 0);
rowNames = {'Intercept' muCell{:}};

table = array2table(bAll,'RowNames',rowNames,'VariableNames',{'Starting_b','OLS','PCR','PLS','Ridge','LASSO'});
disp(table);

function plots(y, y_pred, rmse, name)
% Scatterplot
figure;
scatter(y,y_pred);
a = min(min(y), min(y_pred));
b = max(max(y), max(y_pred));
hold on;
plot([a b],[a b]);
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
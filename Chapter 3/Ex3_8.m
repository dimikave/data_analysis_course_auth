%% Data Analysis Course 2021 - Exercise 3.8

% Clearing
clear;
close all;
clc;

M = 100;
n = 10;
B = 1000;
X = normrnd(0,1,[M n]);
CIParam = zeros(M,2);

% A
% Bootstrap CI
CIBoot = bootci(B,{@std,X'},'type','percentile')';

% Parametric CI
for i = 1:M
    [~,~,CIParam(i,:),~] = vartest(X(i,:),0);
end
CIParam = CIParam.^(1/2);

% Histograms
figure(1);
histogram(CIBoot(:,1), M);
hold on;
histogram(CIParam(:,1), M);
legend('Bootstrap','Parametric');
title('Confidence Interval lower bound');

figure(2);
histogram(CIBoot(:,2), M);
hold on;
histogram(CIParam(:,2), M);
legend('Bootstrap','Parametric');
title('Confidence Interval upper bound');

% B
% Bootstrap CI
Y = X.^2;
CIBoot = bootci(B,{@std,Y'},'type','percentile')';

% Parametric CI
for i = 1:M
    [~,~,CIParam(i,:),~] = vartest(Y(i,:),0);
end
CIParam = CIParam.^(1/2);

% Histograms
figure(3);
histogram(CIBoot(:,1), M);
hold on;
histogram(CIParam(:,1), M);
legend('Bootstrap','Parametric');
title('Confidence Interval lower bound');

figure(4);
histogram(CIBoot(:,2), M);
hold on;
histogram(CIParam(:,2), M);
legend('Bootstrap','Parametric');
title('Confidence Interval upper bound');
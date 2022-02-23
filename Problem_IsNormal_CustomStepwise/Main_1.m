%% Data Analysis Exam 2021-2022
% Kavelidis Frantzis Dimitrios,     AEM:9351

%% Clearing
clear
close all
clc

%% Initializing
alpha = 0.05;
N = 100;
% n = 20;
n = 100;
B = 100;
h_param = zeros(N,1);
h_boot = zeros(N,1);

%% a) X ~ N(0,4)
X = normrnd(0,4,n,N);
fprintf(' ------------------------ n = %i -------------------------\n',n)
fprintf('A : X ~ N(0,4)\n')
% Goodness of fit test - Parametric
for i = 1:N
    h_param(i) = chi2gof(X(:,i));
end

% Edw reject kanoume an einai 1
perc_of_rejection_param = 100*length(find(h_param == 1))/N;
fprintf('Percentage of rejection with parametric test: %f  \n',perc_of_rejection_param)
% Skewness and Kurtosis test
for i = 1:N
    h_boot(i) = Is_Normal(X(:,i),alpha,B);
end

% Edw vazw 0 afou reject kanoume an einai false
perc_of_rejection_boot = 100*length(find(h_boot == 0))/N;
fprintf('Percentage of rejection with bootstrap test: %f \n',perc_of_rejection_boot)

%% b) X ~ N(0,4)
Y = normrnd(0,4,n,N);
X = Y.^2;

fprintf('B : Y ~ N(0,4) & X = Y^2 \n')
% Goodness of fit test - Parametric
for i = 1:N
    h_param(i) = chi2gof(X(:,i));
end

% Edw reject kanoume an einai 1
perc_of_rejection_param = 100*length(find(h_param == 1))/N;
fprintf('Percentage of rejection with parametric test: %f  \n',perc_of_rejection_param)
% Skewness and Kurtosis test
for i = 1:N
    h_boot(i) = Is_Normal(X(:,i),alpha,B);
end

% Edw vazw 0 afou reject kanoume an einai false
perc_of_rejection_boot = 100*length(find(h_boot == 0))/N;
fprintf('Percentage of rejection with bootstrap test: %f \n',perc_of_rejection_boot)


%% a) X ~ N(0,4)
Y = normrnd(0,4,n,N);
X = Y.^3;

fprintf('C : Y ~ N(0,4) , X = Y^3 \n')
% Goodness of fit test - Parametric
for i = 1:N
    h_param(i) = chi2gof(X(:,i));
end

% Edw reject kanoume an einai 1
perc_of_rejection_param = 100*length(find(h_param == 1))/N;
fprintf('Percentage of rejection with parametric test: %f  \n',perc_of_rejection_param)
% Skewness and Kurtosis test
for i = 1:N
    h_boot(i) = Is_Normal(X(:,i),alpha,B);
end

% Edw vazw 0 afou reject kanoume an einai false
perc_of_rejection_boot = 100*length(find(h_boot == 0))/N;
fprintf('Percentage of rejection with bootstrap test: %f \n',perc_of_rejection_boot)

%% Sxolia
% Trexontas to test gia n = 20 deigmata, vlepoume oti to chi2gof den
% aporriptei sxedon pote akoma kai otan exoume metasxhmatismo tetragwnou h
% kuvou, kathws ta deigmata einai polu liga. Apo thn allh to bootstrap test
% me kurtosis kai skewness fainetai na antapokrinetai polu perissotero kai
% na exei perissoterh logikh stis aporripseis kata ton metasxhmatismo.
% Otan ta deigmata einai arketa (n = 100), tote vlepoume oti kai h chi2gof
% exei logikh stis aporripseis pou kanei.

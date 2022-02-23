
%% Clearing
clear
close all
clc
warning off
%% Initializing
data = importdata('physical.txt');
headers = data.colheaders;
data = data.data;

X = data(:,2:end);
Y = data(:,1);

%% Stepwise polynomial
model = step_poly(X,Y,3);

%% Results
disp('According to our custom stepwise-polyfit,')
disp('the most important bioindices are:')
fprintf('\n')
disp(array2table(headers(model)))

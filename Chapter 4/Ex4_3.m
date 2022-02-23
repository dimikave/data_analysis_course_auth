%% Data Analysis Course 2021 - Exercise 4.3

% Clearing
clear;
close all;
clc;


mV = 77.78;
sV = 0.71;

mI = 1.21;
sI = 0.71;

mf = 0.283;
sf = 0.017;

% A - according to 4.2- 4.3 because of the independant variables
sP = sqrt((mI*cos(mf))^2*sV^2+ (mV*cos(mf))^2*sI^2 + (mV*mI*(-sin(mf)))^2*sf^2)

% B
M = 1000;
power = zeros(M,1);
sPower = zeros(M,1);
for i = 1:M
    V = normrnd(mV,sV);
    I = normrnd(mI,sI);
    f = normrnd(mf,sf);
    power(i) = V*I*cos(f);
    sPower(i) = sqrt( I*cos(f)*sV + V*cos(f)*sI - V*I*sin(f)*sf );
end
sigmaP = sqrt(
% Histogram
figure;
hist(power)

% C
powerC = zeros(M,1);
sPowerC = zeros(M,1);
covVf = 0.5;
for i = 1:M
    I = normrnd(mI,sI);
    sigma = [sV^2 covVf*sV*sf;covVf*sV*sf sf^2];
    VF = mvnrnd([mV mf],sigma,1);
    V = VF(1);
    f = VF(2);
    
    powerC(i) = V*I*cos(f);
    sPowerC(i) = sqrt( I*cos(f)*sV + V*cos(f)*sI - V*I*sin(f)*sf );
end
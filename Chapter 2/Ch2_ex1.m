%% Data Analysis Course 2021 - Exercise 2.1

clear;
close all;
clc;

nReps = [10 100 1000 10000 1000000];  % Number of repetitions on each experiment
nExp = length(nReps);   % Number of experiments
headRatio = zeros(nExp,1); 
trailRatio = zeros(nExp,1);

% Start flipping the coin
for i = 1 : nExp 
    Heads = 0;
    Trails = 0;
    %this loop is for every coin flip simulation
    for j= 1 : nReps(i)
        FlipCoin = unidrnd(2); % 1 for heads , 2 for trails
        if(FlipCoin == 1)
            Heads = Heads+1; 
        elseif(FlipCoin == 2)
            Trails = Trails + 1;
        end     
    end
    disp('Heads Ratio'); headRatio(i)=  (Heads /nReps(i))
    disp('Trails Ratio'); trailRatio(i)= (Trails /nReps(i))
    pause
end 

% Plots of ratio approaching 0.5
figure;
subplot(2,1,1)
plot(headRatio)
title('Head Ratio')

subplot(2,1,2)
plot(trailRatio)
title('Trails Ratio')
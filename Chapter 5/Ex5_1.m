%% Data Analysis Course 2021 - Exercise 5.1

% Clearing
clear;
close all;
clc;

M = 1000;
n = 20;
sx = 1;
sy = 1;
rho = [0 0.5];
mu = [0 0];

sigma = zeros(2,2,2);
sigma(:,:,1) = [sx^2 0; 0 sy^2];
sigma(:,:,2) = [sx^2 rho(2)*sx*sy; rho(2)*sx*sy sy^2];

rCI = zeros(M,2,2);
rhoInCI = zeros(1,2);
nullHypothesisTesting = zeros(2,1);

squareTransform = 0;% OTAN Den akolouthei kanonikh katanomh, amfisvhtoume

rMatrix = zeros(M,2);

for i = 1:M
    samples = zeros(n,2,2);
    for j = 1:2
        % Generate Samples
        samples(:,:,j) = mvnrnd(mu,sigma(:,:,j),n);
        if( squareTransform )
            samples = samples.^2;
        end
        
        % Calculate CI
        [r,p,RL,RU] = corrcoef(samples(:,:,j));
        rCI(i,:,j) = [RL(1,2),RU(1,2)];
        rMatrix(i,j) = r(1,2);
        
        
        % Check if real correlation coefficient is inside the CI
        if( rho(j) > rCI(i,1,j) && rho(j) < rCI(i,2,j) )
            rhoInCI(j) = rhoInCI(j) + 1;
        end
        
        % Hypothesis Testing
        if( p(1,2) < 0.05 )
            nullHypothesisTesting(j) = nullHypothesisTesting(j) + 1;
        end    
        
    end
end
rhoInCI = rhoInCI./M
nullHypothesisTesting = nullHypothesisTesting./M

% Histograms
figure(1)
histogram(rCI(:,1,1));
hold on;
histogram(rCI(:,2,1));
title('Sample 1: correlation coefficient confidence Interval - rho = 0')
legend('Lower bound','Upper bound')

figure(2)
histogram(rCI(:,1,2))
hold on;
histogram(rCI(:,2,2))
title('Sample 2: correlation coefficient Interval - rho = 0.5')
legend('Lower bound","Upper bound')

disp('ro in Confidence interval:');
disp(rhoInCI);
disp('Null hypothesis rejected');
disp(nullHypothesisTesting);

figure(3)
histogram(rMatrix(:,1));

figure(4)
histogram(rMatrix(:,2));
%% Data Analysis Course 2021 - Exercise 5.3

% Clearing
clear;
close all;
clc;

rain = importdata("rainThes59_97.dat");
temp = importdata("tempThes59_97.dat");
n = 39;
L = 100;

paramHypothesisTesting = zeros(12,1);
permHypothesisTesting = zeros(12,1);

for i = 1:12
    % Parametrical
    [~,p] = corrcoef(temp(:,i),rain(:,i));
    if( p(1,2) < 0.05 )
        paramHypothesisTesting(i) = 1;
    end
    
    % Permutation
    r = corrcoef(temp(:,i),rain(:,i));
    t0 = r(1,2)*sqrt( (n-2)/(1-r(1,2)^2) );
    t = zeros(L,1);
    
    for j = 1:L
        % Caclulate samples permutation
        tempPerm = temp(:,i);
        tempPerm = tempPerm(randperm(n));
        
        % Calculate t
        r = corrcoef(tempPerm,rain(:,i));
        t(j) = r(1,2)*sqrt( (n-2)/(1-r(1,2)^2) );
        
    end
    t = sort(t);
    
    % Calculate CI
    alpha = 5;
    percentiles = [alpha/2 (100-alpha)/2];
    
    CI = prctile(t,percentiles);
    
    if( t0 < CI(1) || t0 > CI(2) )
        permHypothesisTesting(i) = 1;
    end
end
CI
permHypothesisTesting
paramHypothesisTesting
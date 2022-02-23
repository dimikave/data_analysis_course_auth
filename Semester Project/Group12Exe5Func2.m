%% Data Analysis Project Winter Semester 2020-2021
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

function [h_param,h_perm] = Group12Exe5Func2(prX,prY,alpha)
    n = length(prY);
    % Parametric test
    [R,P] = corrcoef(prX,prY);
    h_param = 0;
    if( P(1,2) < alpha )
        h_param = 1;
    end
    % Random Permutation test
    L = 1000;
    h_perm = 0;
    r = corrcoef(prX,prY);
    t0 = r(1,2)*sqrt( (n-2)/(1-r(1,2)^2) );
    t = zeros(L,1);
    for j = 1:L
        % Caclulate samples permutation
        prXPerm = prX;
        prXPerm = prXPerm(randperm(n));
        
        % Calculate t statistic
        r = corrcoef(prXPerm,prY);
        t(j) = r(1,2)*sqrt( (n-2)/(1-r(1,2)^2) );  
    end
    % Getting percentiles
    t = sort(t);
    alpha = 5;
    percentiles = [alpha/2 (100-alpha)/2];
    CI = prctile(t,percentiles);
    % Checking if it belongs to the CI
    if( t0 < CI(1) || t0 > CI(2) )
        h_perm = 1;
    end
end
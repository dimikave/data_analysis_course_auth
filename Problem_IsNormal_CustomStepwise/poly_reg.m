%% Data Analysis Exam 2021-2022
% Kavelidis Frantzis Dimitrios,     AEM:9351

function [ypred,R2,h] = poly_reg(X,Y,k)
    % Polynomial Regression
    b = polyfit(X,Y,k);
    ypred = polyval(b,X);
    
    % Parametric test and R2
    [R2,P] = corrcoef(Y,ypred);
    R2 = R2(1,2);
    
    % Result of test
    if P(1,2)<0.05;
        h = 1;              % Susxetismena
    else
        h = 0;              % Asusxetista
    end
end
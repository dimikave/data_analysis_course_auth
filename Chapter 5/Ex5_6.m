%% Data Analysis Course 2021 - Exercise 5.6

% Clearing
clear;
close all;
clc;

close all;
clc;
clear;

data = [1 2 98.2;2 3 91.7;3 8 81.3;4 16 64.0; 5 32 36.4;6 48 32.6;7 64 17.1;8 80 11.3];

X = data(:,2);
Y = data(:,3);

% A
% Data Scatterplot
figure(100)
scatter(X,Y)

% Functions
% 1 Power
power = @(b,x)( b(1)*x.^(b(2)) );
% 2 Logarithmic
logarithmic = @(b,x)( b(1)+b(2)*log(x));
% 3 Inverse
inverse = @(b,x)( b(1) + b(2)./x);
% 4 Exponential
exponential = @(b,x)( b(1)*exp(b(2)*x) );

functions = {power ; logarithmic; inverse; exponential};
functionNames = ["Power" ; "Logarithmic"; "Inverse"; "exponential"];
mse = zeros(length(functions),1);

for i = 1:length(functions)
    % Calculate non linear regression model
    beta0 = [10 ; -0.1];
    model = fitnlm(X,Y,functions{i},beta0);
    mse(i) = model.MSE;
    
    beta = table2array(model.Coefficients);
    beta = beta(:,1);
    pred = functions{i}(beta,X);
    
    % Plot data and regression
    figure(i)
    scatter(X,Y)
    hold on;
    plot(X,pred)
    title(strcat(functionNames(i)," regression"));
    
    % B
    x0 = 25;
    prediction = functions{i}(beta,x0);
    hold on;
    plot(x0,prediction,'x','MarkerEdgeColor','k','MarkerSize',5);

    
    % Diagnostic plot of standardised error
    ei_standard = (Y - pred)/sqrt(mse(i));
    figure(i*10)
    scatter(Y,ei_standard);
    hold on;
    plot(Y,repmat(2,1,length(Y)));
    hold on;
    plot(Y,repmat(0,1,length(Y)));
    hold on;
    plot(Y,repmat(-2,1,length(Y)));
    title(strcat(functionNames(i)," regression standardised error"));
    
end
%% Data Analysis Course 2021 - Exercise 6.4

% Clearing
clear;
close all;
clc;

%% Initializing

% Import data
chirpSignal = load('chirp.mat');
gongSignal  = load('gong.mat');

chirp = chirpSignal.y(1:10000);
gong = gongSignal.y(1:10000);

sound(chirp)
pause
sound(gong)

prewhitening = true;
mixingDimension3 = true;
% prewhitening = false;
% mixingDimension3 = false;

% A
% Sources plots
figure(1)
plot(1:length(chirp),chirp);
xlabel('t')
ylabel('chirp(t)')
title('Chirp signal')

figure(2)
plot(1:length(gong),gong);
xlabel('t')
ylabel('gong(t)')
title('Gong signal')

figure(3)
scatter(chirp,gong,'Marker','.')
xlabel('chirp(t)')
ylabel('gong(t)')
title('Scatterplot of source signals')

%% Choosing A
if(mixingDimension3)
    A = [1 -2 -3; 3 -4 -5];
else
    A = [1 -2; 3 -4];
end

X = [chirp gong]*A;

% Pre-whitening
if(prewhitening)
    X = prewhiten(X);
end

pause
sound(X(:,1))
pause
sound(X(:,2))

% ICA
ICA = rica(X,2);
W = ICA.TransformWeights;
S = X*W;

% ICA Sources plots
figure(4)
plot(1:length(S),S(:,1));
xlabel('t')
ylabel('s1(t)')
title('ICA source 1')

figure(5)
plot(1:length(S),S(:,2));
xlabel('t');
ylabel('s2(t)');
title('ICA source 2');

figure(6)
scatter(S(:,1),S(:,2),'Marker','.')
xlabel('s1(t)')
ylabel('s2(t)')
title('Scatterplot of observed signals')

pause
sound(S(:,1))
pause
sound(S(:,2))
% https://www.mathworks.com/help/stats/extract-mixed-signals.html
function Z = prewhiten(X)
% X = N-by-P matrix for N observations and P predictors
% Z = N-by-P prewhitened matrix

    % 1. Size of X.
    [N,P] = size(X);
    assert(N >= P);

    % 2. SVD of covariance of X. We could also use svd(X) to proceed but N
    % can be large and so we sacrifice some accuracy for speed.
    [U,Sig] = svd(cov(X));
    Sig     = diag(Sig);
    Sig     = Sig(:)';

    % 3. Figure out which values of Sig are non-zero.
    tol = eps(class(X));
    idx = (Sig > max(Sig)*tol);
    assert(~all(idx == 0));

    % 4. Get the non-zero elements of Sig and corresponding columns of U.
    Sig = Sig(idx);
    U   = U(:,idx);

    % 5. Compute prewhitened data.
    mu = mean(X,1);
    Z = bsxfun(@minus,X,mu);
    Z = bsxfun(@times,Z*U,1./sqrt(Sig));
end

% function Z = prewhiten(X)
% [U,S,V] = svd(X,'econ');
% Z = inv(S)*U*X;
% end
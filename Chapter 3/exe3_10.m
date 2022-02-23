clear
clc
X = normrnd(0,1,10,100);
% X = X.^2;
MO = mean(X);
[~,p,~] = ttest(X); %,0.5);
X = X - MO; %+ 0.5;
B = bootstrp(1000,@mean,X);
B = [B; MO];
B = sort(B,1);
rank = mod(find(B==MO)-1, 1001)'+1;
pB = min([rank; 1001-rank],[],1)/500;
a = 0.05;
sum(p<a)
sum(pB<a)
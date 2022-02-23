clear
clc
X = normrnd(0,1,10,100);
Y = normrnd(0,1,12,100);
% X = X.^2;
% Y = Y.^2;
[h,~,ci] = ttest2(X,Y);
meansX = bootstrp(1000,@mean,X);
meansY = bootstrp(1000,@mean,Y);
meansDiff = meansX-meansY;
meansDiff = sort(meansDiff,1);
ciB = [meansDiff(25,:); meansDiff(975,:)];
hB = ~(ciB(1,:)<=0 & 0<=ciB(2,:));
sum(h)
sum(hB)
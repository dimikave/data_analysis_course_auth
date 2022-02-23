clear
clc
X = normrnd(0,1,10,100);
Y = normrnd(0,1,12,100);
% X = X.^2;
% Y = Y.^2;
h = ttest2(X,Y,'Vartype','unequal');
MO = mean([X; Y]);
X = X - mean(X);
Y = Y - mean(Y);
XY = [X; Y] + MO;

diffRand = bootstrp(1000,@diff,XY);
MO = diff(XY);
hRand = process(diffRand, MO);
sum(h)
sum(hRand)

function h = process(B, MO)
    B = [B; MO];
    B = sort(B,1);
    rank = mod(find(B==MO)-1, 1001)'+1;
    h = ~(rank>25 & rank<975);
end

function ret = diff(sampl)
    ret = mean(sampl(1:10,:)) - mean(sampl(11:22,:));
end
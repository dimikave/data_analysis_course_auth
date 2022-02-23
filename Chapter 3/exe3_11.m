clear
clc
X = normrnd(0,1,10,100);
Y = normrnd(0,1,12,100);
% X = X.^2;
% Y = Y.^2;
h = ttest2(X,Y);
XY = [X; Y];

diffRand = bootstrp(1000,@diff,XY);
diffPerm = diffRand;
for boot=1:1000
    sampl = zeros(22,100);
    for i=1:100
        sampl(:,i) = XY(randperm(22),i);
    end
    diffPerm(boot,:) = diff(sampl);
end
MO = diff(XY);
hRand = process(diffRand, MO);
hPerm = process(diffPerm, MO);
sum(h)
sum(hRand)
sum(hPerm)

function h = process(B, MO)
    B = [B; MO];
    B = sort(B,1);
    rank = mod(find(B==MO)-1, 1001)'+1;
    h = ~(rank>25 & rank<975);
end

function ret = diff(sampl)
    ret = mean(sampl(1:10,:)) - mean(sampl(11:22,:));
end
%% Data Analysis Project Winter Semester 2020-2021
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

function pr = Group12Exe4Func1(countr,allData,period)
    % Using bitwise operations we choose to import only the data we want
    a = allData.level == string('national');
    b = allData.country == string(countr);
    c = bitand(a,b);
    if (period == 1)
        d1 = allData.year_week == string('2020-W45');
        d2 = allData.year_week == string('2020-W46');
        d12 = bitor(d1,d2);
        d3 = allData.year_week == string('2020-W47');
        d4 = allData.year_week == string('2020-W48');
        d34 = bitor(d3,d4);
        d1234 = bitor(d12,d34);
        d5 = allData.year_week == string('2020-W49');
        d6 = allData.year_week == string('2020-W50');
        d56 = bitor(d5,d6);
        d123456 = bitor(d1234,d56);
        d7 = allData.year_week == string('2020-W42');
        d8 = allData.year_week == string('2020-W43');
        d78 = bitor(d7,d8);
        d9 = allData.year_week == string('2020-W44');
        d789 = bitor(d78,d9);
        d = bitor(d123456,d789);
        c = bitand(c,d);
        pr = allData.positivity_rate(c==1);
    elseif (period == 0)
        d1 = allData.year_week == string('2021-W45');
        d2 = allData.year_week == string('2021-W46');
        d12 = bitor(d1,d2);
        d3 = allData.year_week == string('2021-W47');
        d4 = allData.year_week == string('2021-W48');
        d34 = bitor(d3,d4);
        d1234 = bitor(d12,d34);
        d5 = allData.year_week == string('2021-W49');
        d6 = allData.year_week == string('2021-W50');
        d56 = bitor(d5,d6);
        d123456 = bitor(d1234,d56);
        d7 = allData.year_week == string('2021-W42');
        d8 = allData.year_week == string('2021-W43');
        d78 = bitor(d7,d8);
        d9 = allData.year_week == string('2021-W44');
        d789 = bitor(d78,d9);
        d = bitor(d123456,d789);
        c = bitand(c,d);
        pr = allData.positivity_rate(c==1);
    end
end

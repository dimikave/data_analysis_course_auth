%% Data Analysis Project Winter Semester 2020-2021
% Group 12
% Dimitriadis Dimitrios(AEM 9562), Kavelidis Frantzis Dimitrios(AEM 9351)
% 
% Country : mod(9351,25) + 1 = 2 -> Belgium 
% Country of interest:  Belgium

function [B_CI,diafora,PosRate,prEur] = Group12Exe3Func1(country,week,allData)
    
    % Finding Greek Positivity Rate at a specific week:
    % Daily New Cases - vector with all new cases of the week
    nc = country.NewCases(week*7-12*7-3:(week+1)*7-12*7-3-1);
    % Finding Week cases
    weekCases = sum(nc);
    % Finding weekly tests - In the excel file they are accumulative.
    PCRt = country.PCR_Tests((week+1)*7-12*7-3-1)-...
        country.PCR_Tests(week*7-12*7-3);
    Rapidt = country.Rapid_Tests((week+1)*7-12*7-3-1)-...
        country.Rapid_Tests(week*7-12*7-3);
    % Rapid tests start after a short period with only PCR tests
    if isnan(Rapidt)
        Rapidt = 0;
        PosRate = weekCases/(PCRt+Rapidt)*100;  % We assume the tests
                                       % were performed to distinct people
    else
        PosRate = weekCases/(PCRt+Rapidt)*100;
    end
%     
    PCRgr = zeros(7,1);
    Rapidgr = zeros(7,1);
    % Finding tests per day
    for i=1:7
        PCRgr(i) = country.PCR_Tests((week+1)*7-12*7-3-1-(7-i))-...
            country.PCR_Tests((week+1)*7-12*7-3-1-(7-i+1));
        Rapidgr(i) = country.Rapid_Tests((week+1)*7-12*7-3-1-(7-i))-...
            country.Rapid_Tests((week+1)*7-12*7-3-1-(7-i+1));
    end
    % Getting a vector with daily PR
    prGr = nc./(PCRgr+Rapidgr)*100;
    
    % Bootstrap CI for mean PosRate
    B_CI = bootci(1000,@mean,prGr)';
    
    % Finding Europe's Positivity Rate at a specific week
    if week>52
        s = '2021-W'+string(week-52);
    else
        s = '2020-W'+string(week);
    end
    a = allData.year_week == s;
    prs = nonzeros(allData.positivity_rate(a==1));
    prEur = sum(prs)/25;
    
    % Calculating differences
    if prEur>B_CI(2)
        diafora = prEur-B_CI(2);
    elseif prEur<B_CI(1)
        diafora = prEur-B_CI(1);
    else
        diafora = 0;
end
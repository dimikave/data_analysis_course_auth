

function h_boot = Is_Normal(X,alpha,B)
%       
    sk = false;
    ku = false;
    h_bootflag = false;
    
    % Finding Boostrap Confidence Intervals based on the different
    % functions (skewness and kurtosis)
    CIBootSk = bootci(B,{@skewness,X'},'type','percentile','Alpha',alpha)';
    CIBootKu = bootci(B,{@kurtosis,X'},'type','percentile','Alpha',alpha)';
    
    % Checking if 0 is in CI of skewness
    if CIBootSk(1) < 0 && CIBootSk(2) > 0
        sk = true;
    end
    % Checking if 3 is in CI of kurtosis
    if CIBootKu(1) < 3 && CIBootKu(2) > 3
        ku = true;
    end
    % Checking for both of them
    h_bootflag = sk&&ku;
    if h_bootflag == 0
        h_boot = 0;
    else
        h_boot = 1;
    end
end

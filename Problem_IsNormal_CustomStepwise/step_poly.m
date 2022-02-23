%% Data Analysis Exam 2021-2022
% Kavelidis Frantzis Dimitrios,     AEM:9351

function model = step_poly(X,Y,k)

    % Initializing 
    K = size(X,2);
    maxR2 = 0;
    ind = 0;
    h_best = 0;
    model = false(K,1);
    flag = 1;
    in_step = [];
    
    while(flag)
        % Step 1: Fitting with polynomial regression - Finding the best
        % variable
        for i = 1:K
            % Keeping a memory of the columns already used
            if isempty(find(in_step == ind))
                [ypred,R2,h] = poly_reg(X(:,i),Y,k);
                
                % Keeping the best variable
                if R2 > maxR2
                    maxR2 = R2;
                    ind = i;
                    h_best = h;
                    y_pred_best = ypred;
                end
            end
        end
        % Step 2: Checking the significance & Choosing the random variable.
        if h_best == 1
            % Storing index of the best
            model(ind) = true;
            % Scatter Plot
            figure;
            scatter(X(:,i),Y)
            title('Scatter Plot')
            grid on
            xlabel('X_i')
            ylabel('Y')
            
            % An array to hold the indices that are already used to check
            % on next iteration, so we don't take the same index twice.
            in_step = [in_step; ind];
            
            % Residuals & New Y
            residuals = Y - y_pred_best;
            Y = residuals;
        else
            % Breaking  the loop
            flag = 0;
        end
        
        % Re-initializing temporary variables for the next iteration.
        h_best = 0;
        maxR2 = 0;
        ind = 0;

        % Step 3: Repeat with Y = residuals for a new choice.
    end
            
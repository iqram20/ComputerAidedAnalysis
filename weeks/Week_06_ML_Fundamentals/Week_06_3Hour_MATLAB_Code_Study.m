%% Week 6 - Machine Learning Fundamentals and Data Preparation
% ESC 113: Computer Aided Analysis for Engineering
% 3-Hour Self-Paced MATLAB Code Study
%
% Requires Statistics and Machine Learning Toolbox.
%
% Suggested pacing:
% Part A: understand rows, features, targets, tables, missing values
% Part B: train/test split, reproducibility, leakage, scaling
% Part C: baseline model, simple model, metrics, interpretation
%
% IMPORTANT
% Machine learning begins with understanding the engineering data.
% Do not train a model before you know what one row, each feature,
% and the target represent.

clear
clc
close all

%% PART A - UNDERSTAND THE DATA

%% 1. Create a small engineering dataset
% One row represents one operating condition of a machine.
% Features: temperature, pressure, vibration.
% Target: energy consumption.

Temperature_C = [45;48;52;55;59;62;65;68;72;75;78;82];
Pressure_kPa = [180;185;190;195;205;210;215;220;230;235;240;250];
Vibration_mm_s = [1.2;1.4;1.5;1.8;2.0;2.2;2.5;2.7;3.0;3.2;3.5;3.9];
Energy_kWh = [12.1;12.8;13.4;14.0;15.1;15.5;16.3;16.8;17.7;18.4;19.0;20.1];

T = table(Temperature_C,Pressure_kPa,Vibration_mm_s,Energy_kWh);

disp(T)

%% 2. Inspect the first rows
% head() is useful before any modeling because it shows variable names,
% units embedded in names, and example values.

disp(head(T))

%% 3. Inspect variable summaries
summary(T)

%% 4. Define features X and target y
% X contains predictor variables used to make a prediction.
% y contains the known answer the model should learn.

featureNames = {'Temperature_C','Pressure_kPa','Vibration_mm_s'};

X = T{:,featureNames};
y = T.Energy_kWh;

fprintf('X size = %d rows x %d features\n',size(X,1),size(X,2))
fprintf('y size = %d rows x %d column\n',size(y,1),size(y,2))

%% 5. Understand one row
rowNumber = 4;

fprintf('Row %d means:\n',rowNumber)
fprintf('Temperature = %.1f C\n',T.Temperature_C(rowNumber))
fprintf('Pressure = %.1f kPa\n',T.Pressure_kPa(rowNumber))
fprintf('Vibration = %.1f mm/s\n',T.Vibration_mm_s(rowNumber))
fprintf('Energy target = %.1f kWh\n',T.Energy_kWh(rowNumber))

%% 6. Visual inspection
figure
scatter(T.Temperature_C,T.Energy_kWh,60,'filled')
xlabel('Temperature (C)')
ylabel('Energy Consumption (kWh)')
title('Temperature vs Energy')
grid on

%% 7. Missing-value concept
% Create a copy so the original table remains unchanged.

Tmissing = T;
Tmissing.Vibration_mm_s(5) = NaN;

missingCounts = sum(ismissing(Tmissing),1);

disp(table(string(Tmissing.Properties.VariableNames)',missingCounts', ...
    'VariableNames',{'Variable','Missing_Count'}))

%% 8. Find rows containing missing values
missingRows = any(ismissing(Tmissing),2);

disp(Tmissing(missingRows,:))

% Do not automatically delete missing data without considering why it is
% missing. Missingness may have engineering meaning.

%% 9. Simple imputation example
% For demonstration, replace the missing vibration with the mean of
% the available vibration measurements.

vibrationMean = mean(Tmissing.Vibration_mm_s,'omitnan');

Tmissing.Vibration_mm_s = fillmissing( ...
    Tmissing.Vibration_mm_s,'constant',vibrationMean);

disp(Tmissing(4:6,:))

%% PART B - TRAIN/TEST WORKFLOW

%% 10. Reproducible random split
% rng(42) makes the random partition repeatable.

rng(42)

cv = cvpartition(length(y),'HoldOut',0.25);

trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
Xtest = X(testIdx,:);
ytrain = y(trainIdx);
ytest = y(testIdx);

fprintf('Training rows = %d\n',length(ytrain))
fprintf('Test rows = %d\n',length(ytest))

%% 11. Why keep a test set?
% Training data are used to fit the model.
% Test data are kept unseen until evaluation.
%
% If the model is evaluated on the same observations used for fitting,
% the reported performance may be overly optimistic.

%% 12. Training-only scaling
% Calculate preprocessing parameters using ONLY Xtrain.

mu = mean(Xtrain,1);
sigma = std(Xtrain,0,1);

% Avoid division by zero if a feature is constant.
sigma(sigma == 0) = 1;

XtrainScaled = (Xtrain-mu)./sigma;
XtestScaled = (Xtest-mu)./sigma;

%% 13. Inspect scaled training data
% After standardization, training features should have mean near 0
% and standard deviation near 1.

disp(mean(XtrainScaled,1))
disp(std(XtrainScaled,0,1))

%% 14. Data leakage example - DO NOT USE
% The following idea is shown only to explain what NOT to do.
%
% wrongMu = mean([Xtrain;Xtest],1);
%
% This would use information from the test set before final evaluation.
% That is called data leakage.

%% 15. Regression vs classification
% Regression target: continuous number.
% Example: Energy = 16.8 kWh.
%
% Classification target: category.
% Example: MachineStatus = "Warning".

MachineStatus = categorical([
    "Normal";"Normal";"Normal";"Normal";
    "Normal";"Warning";"Warning";"Warning";
    "Warning";"Critical";"Critical";"Critical"
]);

disp(table(T.Temperature_C,MachineStatus))

%% 16. Class balance concept
classCounts = countcats(MachineStatus);
classNames = categories(MachineStatus);

disp(table(string(classNames),classCounts, ...
    'VariableNames',{'Class','Count'}))

%% PART C - BASELINE AND SIMPLE MODEL

%% 17. Regression baseline
% A simple baseline predicts the TRAINING target mean for every test row.
% A useful model should generally improve on this simple reference.

baselineValue = mean(ytrain);
baselinePred = repmat(baselineValue,size(ytest));

baselineMAE = mean(abs(ytest-baselinePred));

fprintf('Baseline prediction = %.3f kWh\n',baselineValue)
fprintf('Baseline MAE = %.3f kWh\n',baselineMAE)

%% 18. Fit a linear regression model
% fitlm learns coefficients from the training features and targets.

model = fitlm(Xtrain,ytrain);

disp(model)

%% 19. Predict unseen test rows
ypred = predict(model,Xtest);

comparison = table(ytest,ypred,ytest-ypred, ...
    'VariableNames',{'Actual_kWh','Predicted_kWh','Residual_kWh'});

disp(comparison)

%% 20. Calculate MAE
MAE = mean(abs(ytest-ypred));

fprintf('Model MAE = %.3f kWh\n',MAE)

%% 21. Calculate RMSE
RMSE = sqrt(mean((ytest-ypred).^2));

fprintf('Model RMSE = %.3f kWh\n',RMSE)

%% 22. Compare model to baseline
fprintf('Baseline MAE = %.3f kWh\n',baselineMAE)
fprintf('Model MAE    = %.3f kWh\n',MAE)

if MAE < baselineMAE
    disp('The model improves on the mean-value baseline for this split.')
else
    disp('The model does not improve on the baseline for this split.')
end

%% 23. Actual vs predicted
figure
scatter(ytest,ypred,70,'filled')
hold on

plotLimits = [min([ytest;ypred]) max([ytest;ypred])];
plot(plotLimits,plotLimits,'--')

hold off
xlabel('Actual Energy (kWh)')
ylabel('Predicted Energy (kWh)')
title('Actual vs Predicted Energy')
grid on

%% 24. Residuals
residuals = ytest-ypred;

figure
stem(residuals,'filled')
xlabel('Test Observation')
ylabel('Residual (kWh)')
title('Prediction Residuals')
grid on

%% 25. Engineering interpretation
% A metric alone is not a complete result.
%
% Ask:
% - What are the units of the error?
% - Is the error small relative to normal operating values?
% - Are errors systematic?
% - Is the dataset representative of real operating conditions?
% - Was the test set kept independent?

%% 26. Common mistakes
% 1. Confusing features with target.
% 2. Training and testing on the same rows.
% 3. Scaling before the split.
% 4. Using test data to calculate preprocessing parameters.
% 5. Reporting MAE without units.
% 6. Assuming a model is useful only because it runs without an error.

%% 27. Mini challenge
% Add a fourth feature named FlowRate_L_min.
% Rebuild X, repeat the split, fit the model, and compare MAE.

disp('Week 6 self-paced study complete.')

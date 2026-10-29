%% Week 7 - Regression for Engineering Prediction
% ESC 113: Computer Aided Analysis for Engineering
% 3-Hour Self-Paced MATLAB Code Study
%
% Case study: UCI Combined Cycle Power Plant
% Goal: predict net electrical power output (MW).
%
% Requires Statistics and Machine Learning Toolbox.
%
% Suggested pacing:
% Part A: download, inspect, understand engineering variables
% Part B: split data, fit regression, calculate metrics
% Part C: residuals, largest errors, coefficients, model comparison

clear
clc
close all

%% PART A - LOAD AND UNDERSTAND THE DATA

%% 1. Download the UCI dataset
zipURL = "https://archive.ics.uci.edu/static/public/294/combined+cycle+power+plant.zip";
zipFile = "combined_cycle_power_plant.zip";
dataFolder = "combined_cycle_power_plant_data";

if ~isfile(zipFile)
    fprintf('Downloading dataset...\n')
    websave(zipFile,zipURL);
end

if ~isfolder(dataFolder)
    fprintf('Extracting dataset...\n')
    unzip(zipFile,dataFolder);
end

%% 2. Locate the Excel data file
files = dir(fullfile(dataFolder,"**","*.xlsx"));

if isempty(files)
    error('Could not find the CCPP .xlsx file after extraction.')
end

dataFile = fullfile(files(1).folder,files(1).name);

fprintf('Using data file: %s\n',dataFile)

%% 3. Read the first worksheet
% The original dataset columns are commonly named AT, V, AP, RH, and PE.

Traw = readtable(dataFile,'Sheet',1);

disp(head(Traw))
disp(Traw.Properties.VariableNames)

%% 4. Rename variables using engineering meanings
% AT = ambient temperature
% V  = exhaust vacuum
% AP = ambient pressure
% RH = relative humidity
% PE = net electrical output

T = Traw;

if width(T) < 5
    error('Expected at least five columns in the power-plant dataset.')
end

T.Properties.VariableNames(1:5) = {
    'Ambient_Temperature_C'
    'Exhaust_Vacuum_cmHg'
    'Ambient_Pressure_mbar'
    'Relative_Humidity_percent'
    'Net_Electrical_Output_MW'
};

disp(head(T))

%% 5. What does one row represent?
% One row describes one full-load operating observation of the plant.

rowNumber = 1;

fprintf('Example operating observation:\n')
fprintf('Ambient temperature = %.2f C\n',T.Ambient_Temperature_C(rowNumber))
fprintf('Exhaust vacuum = %.2f cmHg\n',T.Exhaust_Vacuum_cmHg(rowNumber))
fprintf('Ambient pressure = %.2f mbar\n',T.Ambient_Pressure_mbar(rowNumber))
fprintf('Relative humidity = %.2f %%\n',T.Relative_Humidity_percent(rowNumber))
fprintf('Power output = %.2f MW\n',T.Net_Electrical_Output_MW(rowNumber))

%% 6. Summary statistics
summary(T)

%% 7. Check missing values
missingCounts = sum(ismissing(T),1);

disp(table(string(T.Properties.VariableNames)',missingCounts', ...
    'VariableNames',{'Variable','Missing_Count'}))

%% 8. Define features and target
featureNames = {
    'Ambient_Temperature_C'
    'Exhaust_Vacuum_cmHg'
    'Ambient_Pressure_mbar'
    'Relative_Humidity_percent'
};

X = T{:,featureNames};
y = T.Net_Electrical_Output_MW;

fprintf('Observations = %d\n',size(X,1))
fprintf('Features = %d\n',size(X,2))

%% 9. Explore temperature vs power
figure
scatter(T.Ambient_Temperature_C,y,12,'filled')
xlabel('Ambient Temperature (C)')
ylabel('Net Electrical Output (MW)')
title('Ambient Temperature vs Power Output')
grid on

%% 10. Explore all four predictors
figure
tiledlayout(2,2)

for k = 1:4
    nexttile
    scatter(X(:,k),y,8,'filled')
    xlabel(featureNames{k},'Interpreter','none')
    ylabel('Power Output (MW)')
    grid on
end

%% PART B - TRAIN AND EVALUATE REGRESSION

%% 11. Reproducible train/test split
rng(42)

cv = cvpartition(length(y),'HoldOut',0.20);

trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
Xtest = X(testIdx,:);
ytrain = y(trainIdx);
ytest = y(testIdx);

fprintf('Training observations = %d\n',length(ytrain))
fprintf('Test observations = %d\n',length(ytest))

%% 12. Mean-value baseline
baselineValue = mean(ytrain);
baselinePred = repmat(baselineValue,size(ytest));

baselineMAE = mean(abs(ytest-baselinePred));

fprintf('Baseline MAE = %.3f MW\n',baselineMAE)

%% 13. Fit multiple linear regression
% fitlm estimates an intercept and one coefficient for each feature.

model = fitlm(Xtrain,ytrain);

disp(model)

%% 14. Predict the test set
ypred = predict(model,Xtest);

disp(table(ytest(1:10),ypred(1:10), ...
    'VariableNames',{'Actual_MW','Predicted_MW'}))

%% 15. MAE
% Mean absolute error has the SAME unit as the target: MW.

MAE = mean(abs(ytest-ypred));

fprintf('MAE = %.3f MW\n',MAE)

%% 16. RMSE
% RMSE gives relatively more weight to large errors.

RMSE = sqrt(mean((ytest-ypred).^2));

fprintf('RMSE = %.3f MW\n',RMSE)

%% 17. R-squared on the test set
SSres = sum((ytest-ypred).^2);
SStot = sum((ytest-mean(ytest)).^2);

R2 = 1 - SSres/SStot;

fprintf('Test R^2 = %.4f\n',R2)

% R^2 is NOT percent accuracy.

%% 18. Compare with baseline
fprintf('Baseline MAE = %.3f MW\n',baselineMAE)
fprintf('Model MAE    = %.3f MW\n',MAE)

%% 19. Actual vs predicted plot
figure
scatter(ytest,ypred,12,'filled')
hold on

limits = [min([ytest;ypred]) max([ytest;ypred])];
plot(limits,limits,'--','LineWidth',1.5)

hold off
xlabel('Actual Power Output (MW)')
ylabel('Predicted Power Output (MW)')
title('Actual vs Predicted Power Output')
grid on

%% PART C - ERROR ANALYSIS AND INTERPRETATION

%% 20. Residuals
% Residual = actual - predicted.
% Positive residual: model underpredicted.
% Negative residual: model overpredicted.

residuals = ytest-ypred;

figure
histogram(residuals,30)
xlabel('Residual (MW)')
ylabel('Count')
title('Residual Distribution')
grid on

%% 21. Residuals vs predicted
figure
scatter(ypred,residuals,12,'filled')
yline(0,'--')
xlabel('Predicted Power Output (MW)')
ylabel('Residual (MW)')
title('Residuals vs Predicted Values')
grid on

% A visible pattern may indicate that a simple linear model is missing
% nonlinear structure or changing error variance.

%% 22. Inspect largest absolute errors
absoluteError = abs(residuals);

[sortedError,idx] = sort(absoluteError,'descend');

nShow = min(10,length(idx));
topIdx = idx(1:nShow);

largestErrors = table( ...
    ytest(topIdx), ...
    ypred(topIdx), ...
    residuals(topIdx), ...
    sortedError(1:nShow), ...
    'VariableNames',{'Actual_MW','Predicted_MW','Residual_MW','AbsoluteError_MW'});

disp(largestErrors)

%% 23. Inspect model coefficients
disp(model.Coefficients)

% A coefficient describes the fitted association while other predictors
% are held fixed. It does not prove physical causation.

%% 24. Temperature-only model
temperatureTrain = Xtrain(:,1);
temperatureTest = Xtest(:,1);

temperatureModel = fitlm(temperatureTrain,ytrain);
temperaturePred = predict(temperatureModel,temperatureTest);

temperatureMAE = mean(abs(ytest-temperaturePred));
temperatureRMSE = sqrt(mean((ytest-temperaturePred).^2));

fprintf('Temperature-only MAE = %.3f MW\n',temperatureMAE)
fprintf('Four-feature MAE      = %.3f MW\n',MAE)
fprintf('Temperature-only RMSE = %.3f MW\n',temperatureRMSE)
fprintf('Four-feature RMSE      = %.3f MW\n',RMSE)

%% 25. Compare models visually
figure
scatter(ytest,temperaturePred,10,'filled')
hold on
scatter(ytest,ypred,10,'filled')

limits = [min(ytest) max(ytest)];
plot(limits,limits,'--')

hold off
xlabel('Actual Power Output (MW)')
ylabel('Predicted Power Output (MW)')
legend('Temperature only','Four features','Ideal')
title('Single-Feature vs Multiple-Feature Regression')
grid on

%% 26. Engineering interpretation checklist
% A complete conclusion should answer:
%
% 1. What quantity was predicted?
% 2. What inputs were used?
% 3. How many observations were held out for testing?
% 4. What are MAE and RMSE, including units?
% 5. What does R^2 indicate?
% 6. Are residuals centered around zero?
% 7. Are there unusually large errors?
% 8. Did four features improve over temperature alone?
% 9. What limitations remain?

%% 27. Common mistakes
% Calling R^2 "accuracy".
% Reporting MAE or RMSE without MW.
% Interpreting coefficients as causal effects.
% Evaluating only training performance.
% Ignoring residual patterns and largest errors.
% Assuming a more complex model is always better.

%% 28. Mini challenge
% Add a quadratic temperature term:
% Xquad = [X, X(:,1).^2];
% Fit a model using the same train/test row indices.
% Compare MAE and residuals with the original linear model.

Xquad = [X X(:,1).^2];

XquadTrain = Xquad(trainIdx,:);
XquadTest = Xquad(testIdx,:);

quadModel = fitlm(XquadTrain,ytrain);
quadPred = predict(quadModel,XquadTest);

quadMAE = mean(abs(ytest-quadPred));

fprintf('Original linear MAE = %.3f MW\n',MAE)
fprintf('With temperature^2 MAE = %.3f MW\n',quadMAE)

disp('Week 7 self-paced study complete.')

%% Week 11 - Decision Trees, Ensembles, and Feature Importance
% ESC 113: Computer Aided Analysis for Engineering
%
% This self-paced MATLAB study uses a small engineering dataset to compare:
%   1. a regression tree,
%   2. trees with different complexity,
%   3. a bagged tree ensemble,
%   4. feature importance.
%
% Run one %% section at a time in MATLAB Live Editor.
% Required toolbox: Statistics and Machine Learning Toolbox.

clear
clc
close all
rng(42)   % Reproducible train/test split

%% 1. Create an engineering dataset
% We model concrete compressive strength from mixture and curing variables.
% Each row represents one concrete mixture.
%
% Features:
%   Cement_kg_m3
%   Water_kg_m3
%   Superplasticizer_kg_m3
%   CoarseAggregate_kg_m3
%   FineAggregate_kg_m3
%   Age_days
%
% Target:
%   Strength_MPa
%
% This compact dataset is included directly in the script so the lesson
% runs without downloading an external file.

Cement_kg_m3 = [250 280 300 320 350 380 400 420 450 470 500 520 270 310 340 370 410 440 480 510 ...
                 260 290 330 360 390 430 460 490 530 550 285 315 345 375 405 435 465 495 525 545]';

Water_kg_m3 = [195 190 185 180 175 170 165 160 155 150 145 140 200 192 184 176 168 162 154 148 ...
                205 198 188 181 173 166 158 151 143 138 196 189 182 174 167 159 152 146 141 136]';

Superplasticizer_kg_m3 = [0 0 2 4 6 8 10 12 14 16 18 20 0 1 3 5 7 9 11 13 ...
                           0 0 2 4 6 8 10 12 15 18 1 2 3 5 7 9 11 13 16 19]';

CoarseAggregate_kg_m3 = [1050 1040 1035 1025 1015 1005 995 985 975 965 955 945 1060 1045 1030 1018 1002 990 978 962 ...
                          1070 1055 1040 1028 1012 998 982 970 952 940 1050 1038 1025 1010 997 984 968 954 942 935]';

FineAggregate_kg_m3 = [720 730 735 745 755 765 775 785 795 805 815 825 710 725 740 750 760 772 788 800 ...
                        700 715 728 742 756 770 786 798 812 828 718 732 746 758 774 790 804 818 832 838]';

Age_days = [3 7 14 28 28 56 56 90 90 180 180 365 3 7 14 28 56 90 180 365 ...
             3 7 14 28 56 90 180 365 180 365 7 14 28 56 90 180 365 365 180 365]';

% Strength values are constructed to preserve realistic engineering trends:
% higher cement content and curing age generally increase strength, while
% high water content generally reduces strength.
Strength_MPa = [14 19 24 31 37 43 48 53 58 62 67 72 13 18 25 33 41 49 58 66 ...
                12 17 23 30 39 47 55 64 69 74 20 26 34 42 50 59 66 70 71 76]';

T = table(Cement_kg_m3, Water_kg_m3, Superplasticizer_kg_m3, ...
    CoarseAggregate_kg_m3, FineAggregate_kg_m3, Age_days, Strength_MPa);

disp(head(T))
fprintf('Number of mixtures = %d\n',height(T));

%% 2. Define features and target

featureNames = {'Cement_kg_m3','Water_kg_m3','Superplasticizer_kg_m3', ...
    'CoarseAggregate_kg_m3','FineAggregate_kg_m3','Age_days'};

X = T{:,featureNames};
y = T.Strength_MPa;

fprintf('Number of predictors = %d\n',size(X,2));
fprintf('Target range = %.1f to %.1f MPa\n',min(y),max(y));

%% 3. Create training and test sets
% Hold out 25%% of the rows for final evaluation.
% The test data are not used while fitting the models.

cv = cvpartition(length(y),'HoldOut',0.25);

trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
ytrain = y(trainIdx);

Xtest = X(testIdx,:);
ytest = y(testIdx);

fprintf('Training rows = %d\n',length(ytrain));
fprintf('Test rows = %d\n',length(ytest));

%% 4. Fit a regression tree
% MaxNumSplits limits tree complexity.

treeModel = fitrtree(Xtrain,ytrain, ...
    'PredictorNames',featureNames, ...
    'MaxNumSplits',8);

ypredTree = predict(treeModel,Xtest);

treeMAE = mean(abs(ytest-ypredTree));
treeRMSE = sqrt(mean((ytest-ypredTree).^2));

fprintf('Decision tree MAE = %.2f MPa\n',treeMAE);
fprintf('Decision tree RMSE = %.2f MPa\n',treeRMSE);

%% 5. Compare training and test error
% A large gap can indicate overfitting.

predTrain = predict(treeModel,Xtrain);

rmseTrain = sqrt(mean((ytrain-predTrain).^2));
rmseTest = sqrt(mean((ytest-ypredTree).^2));

fprintf('Training RMSE = %.2f MPa\n',rmseTrain);
fprintf('Test RMSE = %.2f MPa\n',rmseTest);

%% 6. Study tree complexity
% Compare shallow, medium, and deeper trees using the SAME train/test split.

splitValues = [3 8 20];
trainRMSE = zeros(size(splitValues));
testRMSE = zeros(size(splitValues));

for i = 1:length(splitValues)
    model = fitrtree(Xtrain,ytrain, ...
        'PredictorNames',featureNames, ...
        'MaxNumSplits',splitValues(i));

    predTr = predict(model,Xtrain);
    predTe = predict(model,Xtest);

    trainRMSE(i) = sqrt(mean((ytrain-predTr).^2));
    testRMSE(i) = sqrt(mean((ytest-predTe).^2));
end

complexityTable = table(splitValues',trainRMSE',testRMSE', ...
    'VariableNames',{'MaxNumSplits','Train_RMSE_MPa','Test_RMSE_MPa'});

disp(complexityTable)

figure
plot(splitValues,trainRMSE,'o-','LineWidth',1.5)
hold on
plot(splitValues,testRMSE,'s-','LineWidth',1.5)
hold off
xlabel('Maximum Number of Splits')
ylabel('RMSE (MPa)')
title('Tree Complexity: Training vs Test Error')
legend('Training','Test','Location','best')
grid on

%% 7. Visualize the decision tree
% The graph shows the sequence of split decisions.
% A smaller tree is usually easier to interpret.

figure
view(treeModel,'Mode','graph')

%% 8. Fit a bagged tree ensemble
% Bagging combines many trees and averages their predictions.
% This often reduces the instability of a single decision tree.

ensembleModel = fitrensemble(Xtrain,ytrain, ...
    'Method','Bag', ...
    'NumLearningCycles',100, ...
    'Learners',templateTree('MaxNumSplits',10), ...
    'PredictorNames',featureNames);

ypredEnsemble = predict(ensembleModel,Xtest);

ensembleMAE = mean(abs(ytest-ypredEnsemble));
ensembleRMSE = sqrt(mean((ytest-ypredEnsemble).^2));

fprintf('Bagged ensemble MAE = %.2f MPa\n',ensembleMAE);
fprintf('Bagged ensemble RMSE = %.2f MPa\n',ensembleRMSE);

%% 9. Compare the two models

Model = ["Decision Tree"; "Bagged Ensemble"];
MAE_MPa = [treeMAE; ensembleMAE];
RMSE_MPa = [treeRMSE; ensembleRMSE];

comparison = table(Model,MAE_MPa,RMSE_MPa);

disp(comparison)

%% 10. Actual vs predicted strength

figure
scatter(ytest,ypredTree,55,'filled')
hold on
scatter(ytest,ypredEnsemble,55,'filled')

lims = [min(ytest)-3 max(ytest)+3];
plot(lims,lims,'--','LineWidth',1.2)

hold off
xlabel('Actual Strength (MPa)')
ylabel('Predicted Strength (MPa)')
title('Actual vs Predicted Concrete Strength')
legend('Decision Tree','Bagged Ensemble','Ideal Prediction','Location','best')
grid on
axis equal
xlim(lims)
ylim(lims)

%% 11. Residual analysis
% Residual = actual - predicted.
% Positive residual: model underpredicted strength.
% Negative residual: model overpredicted strength.

residualTree = ytest - ypredTree;
residualEnsemble = ytest - ypredEnsemble;

residualTable = table(ytest,ypredTree,residualTree, ...
    ypredEnsemble,residualEnsemble, ...
    'VariableNames',{'Actual_MPa','TreePred_MPa','TreeResidual_MPa', ...
    'EnsemblePred_MPa','EnsembleResidual_MPa'});

disp(residualTable)

%% 12. Feature importance from the decision tree
% Importance describes how much each predictor contributed to tree splits.
% It does NOT prove that a feature causes higher or lower strength.

importanceTree = predictorImportance(treeModel);

importanceTable = table(string(featureNames)',importanceTree', ...
    'VariableNames',{'Feature','Importance'});

importanceTable = sortrows(importanceTable,'Importance','descend');
disp(importanceTable)

figure
bar(categorical(importanceTable.Feature),importanceTable.Importance)
ylabel('Predictor Importance')
title('Decision Tree Feature Importance')
grid on

%% 13. Feature importance from the ensemble
% The ensemble gives another view of which variables are useful for prediction.

importanceEnsemble = predictorImportance(ensembleModel);

ensembleImportanceTable = table(string(featureNames)',importanceEnsemble', ...
    'VariableNames',{'Feature','Importance'});

ensembleImportanceTable = sortrows(ensembleImportanceTable,'Importance','descend');
disp(ensembleImportanceTable)

figure
bar(categorical(ensembleImportanceTable.Feature),ensembleImportanceTable.Importance)
ylabel('Predictor Importance')
title('Bagged Ensemble Feature Importance')
grid on

%% 14. Engineering interpretation
% Questions to consider:
%
% 1. Which model gives the lower test RMSE?
% 2. Does a deeper tree always improve test performance?
% 3. Which feature is ranked most important?
% 4. Does that ranking make engineering sense?
% 5. Why does feature importance NOT prove causation?
% 6. Why must every model comparison use the same test set?
%
% The key lesson:
% Model complexity should be selected using unseen-data performance and
% engineering plausibility, not training error alone.

%% 15. Guided exercise
% A. Change MaxNumSplits to [2 5 10 30].
% B. Re-run the complexity comparison.
% C. Increase NumLearningCycles from 100 to 200.
% D. Compare the new ensemble RMSE with the original result.
% E. Identify the top three features.
% F. Explain whether the ranking is physically plausible for concrete strength.

%% 16. Review questions
%
% 1. What is a regression tree?
% 2. What does MaxNumSplits control?
% 3. What pattern suggests overfitting?
% 4. Why can bagging improve prediction stability?
% 5. What does predictorImportance measure?
% 6. Why is feature importance not the same as causation?
% 7. Why should training and test errors be reported separately?
% 8. Why should engineering plausibility be checked after model fitting?

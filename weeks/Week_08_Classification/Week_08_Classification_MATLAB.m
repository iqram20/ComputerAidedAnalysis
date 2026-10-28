%% Week 8 - Classification for Engineering Decisions (MATLAB)
% ESC 113: Computer Aided Analysis for Engineering
%
% MATLAB equivalent of the Week 8 Python classification lecture.
%
% Dataset:
% UCI Steel Plates Faults, Dataset ID 198
% https://archive.ics.uci.edu/dataset/198/steel+plates+faults
%
% Requires Statistics and Machine Learning Toolbox.
%
% One row = one detected steel-plate surface fault.
% First 27 columns = numerical fault descriptors.
% Last 7 columns  = one-hot class indicators.

clear
clc
close all

%% 1. Download the UCI dataset

zipURL = "https://archive.ics.uci.edu/static/public/198/steel+plates+faults.zip";
zipFile = "steel_plates_faults.zip";
dataFolder = "steel_plates_faults_data";

if ~isfile(zipFile)
    websave(zipFile, zipURL);
end

if ~isfolder(dataFolder)
    unzip(zipFile, dataFolder);
end

%% 2. Locate the numeric data file

files = dir(fullfile(dataFolder, "**", "*"));
fileNames = string({files.name});
filePaths = string(fullfile({files.folder}, {files.name}));

% The original UCI distribution normally contains Faults.NNA.
idx = contains(lower(fileNames), "faults.nna");

if ~any(idx)
    error("Could not locate Faults.NNA in the downloaded UCI files.");
end

dataFile = filePaths(find(idx,1));

fprintf("Using data file: %s\n", dataFile);

%% 3. Read the raw numeric matrix

M = readmatrix(dataFile, "FileType", "text");

% Remove completely empty rows/columns if any were created during import.
M = M(~all(isnan(M),2), :);
M = M(:, ~all(isnan(M),1));

fprintf("Rows: %d\n", size(M,1));
fprintf("Columns: %d\n", size(M,2));

% Expected: 1941 rows and 34 columns
% 27 feature columns + 7 target-indicator columns.

%% 4. Define clear feature names

featureNames = [
    "X_Minimum"
    "X_Maximum"
    "Y_Minimum"
    "Y_Maximum"
    "Pixels_Areas"
    "X_Perimeter"
    "Y_Perimeter"
    "Sum_of_Luminosity"
    "Minimum_of_Luminosity"
    "Maximum_of_Luminosity"
    "Length_of_Conveyer"
    "TypeOfSteel_A300"
    "TypeOfSteel_A400"
    "Steel_Plate_Thickness"
    "Edges_Index"
    "Empty_Index"
    "Square_Index"
    "Outside_X_Index"
    "Edges_X_Index"
    "Edges_Y_Index"
    "Outside_Global_Index"
    "LogOfAreas"
    "Log_X_Index"
    "Log_Y_Index"
    "Orientation_Index"
    "Luminosity_Index"
    "SigmoidOfAreas"
];

classNames = [
    "Pastry"
    "Z_Scratch"
    "K_Scatch"
    "Stains"
    "Dirtiness"
    "Bumps"
    "Other_Faults"
];

%% 5. Separate features and target indicators

X = M(:,1:27);
Yindicator = M(:,28:34);

% Convert one-hot indicator rows into one categorical class label.
[~, classIndex] = max(Yindicator, [], 2);
y = categorical(classNames(classIndex));

fprintf("Feature matrix size: %d x %d\n", size(X,1), size(X,2));
fprintf("Number of classes: %d\n", numel(categories(y)));

%% 6. Create a table with self-descriptive feature names

T = array2table(X, "VariableNames", cellstr(featureNames));
T.Fault_Class = y;

disp(head(T))

%% 7. Check missing values

missingPerFeature = sum(ismissing(T(:,1:27)),1);

missingTable = table(
    featureNames,
    missingPerFeature',
    "VariableNames", ["Feature","Missing_Count"]
);

disp(missingTable)

%% 8. Examine class balance

classSummary = countcats(y);
classCategories = categories(y);

classTable = table(
    string(classCategories),
    classSummary,
    "VariableNames", ["Fault_Class","Count"]
);

disp(classTable)

figure
bar(classSummary)
xticks(1:numel(classCategories))
xticklabels(classCategories)
xtickangle(45)
ylabel("Number of Fault Instances")
xlabel("Fault Class")
title("Steel Fault Class Distribution")
grid on

%% 9. Stratified train/test split

% cvpartition uses the class labels to preserve class proportions
% approximately across the training and test partitions.

cv = cvpartition(y, "HoldOut", 0.20);

trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
Xtest = X(testIdx,:);
ytrain = y(trainIdx);
ytest = y(testIdx);

fprintf("Training observations: %d\n", numel(ytrain));
fprintf("Test observations: %d\n", numel(ytest));

%% 10. Compare class proportions

trainCounts = countcats(ytrain);
testCounts = countcats(ytest);

splitTable = table(
    string(categories(ytrain)),
    trainCounts,
    trainCounts/sum(trainCounts),
    testCounts,
    testCounts/sum(testCounts),
    "VariableNames", [
        "Fault_Class"
        "Training_Count"
        "Training_Proportion"
        "Test_Count"
        "Test_Proportion"
    ]
);

disp(splitTable)

%% 11. Standardize features using TRAINING data only

mu = mean(Xtrain,1);
sigma = std(Xtrain,0,1);

% Avoid division by zero for any constant feature.
sigma(sigma == 0) = 1;

XtrainScaled = (Xtrain - mu) ./ sigma;
XtestScaled = (Xtest - mu) ./ sigma;

%% 12. Why scaling?
%
% Features have very different numerical ranges.
% Standardization transforms each feature approximately as:
%
% z = (x - training mean) / training standard deviation
%
% Important:
% The test set must use the TRAINING mean and standard deviation.
% Calculating scaling parameters from the full dataset would leak
% information from the test set.

%% 13. Create multiclass logistic-style classifier

% fitcecoc handles multiclass classification using binary learners.
% Here each binary learner is a linear logistic classifier.

learner = templateLinear( ...
    "Learner", "logistic", ...
    "Solver", "lbfgs");

model = fitcecoc( ...
    XtrainScaled, ...
    ytrain, ...
    "Learners", learner, ...
    "Coding", "onevsall", ...
    "ClassNames", categorical(classNames));

%% 14. Make predictions

[ypred, scores] = predict(model, XtestScaled);

comparison = table(
    ytest,
    ypred,
    "VariableNames", ["Actual_Class","Predicted_Class"]
);

disp(head(comparison,15))

%% 15. Accuracy

accuracy = mean(ypred == ytest);

fprintf("Accuracy = %.3f\n", accuracy);

%% 16. Confusion matrix

figure
confusionchart(ytest, ypred)
title("Steel Fault Classification - Confusion Matrix")

%% 17. Obtain numeric confusion matrix

order = categorical(classNames);

C = confusionmat(ytest, ypred, "Order", order);

disp("Confusion matrix:")
disp(C)

%% 18. Calculate per-class precision, recall, and F1

nClasses = numel(classNames);

precision = zeros(nClasses,1);
recall = zeros(nClasses,1);
f1 = zeros(nClasses,1);
support = zeros(nClasses,1);

for k = 1:nClasses

    TP = C(k,k);
    FN = sum(C(k,:)) - TP;
    FP = sum(C(:,k)) - TP;

    support(k) = sum(C(k,:));

    if TP + FP > 0
        precision(k) = TP / (TP + FP);
    else
        precision(k) = 0;
    end

    if TP + FN > 0
        recall(k) = TP / (TP + FN);
    else
        recall(k) = 0;
    end

    if precision(k) + recall(k) > 0
        f1(k) = 2 * precision(k) * recall(k) / ...
            (precision(k) + recall(k));
    else
        f1(k) = 0;
    end
end

metricsTable = table(
    classNames,
    support,
    precision,
    recall,
    f1,
    "VariableNames", [
        "Fault_Class"
        "Support"
        "Precision"
        "Recall"
        "F1"
    ]
);

disp(metricsTable)

%% 19. Macro-average metrics

macroPrecision = mean(precision);
macroRecall = mean(recall);
macroF1 = mean(f1);

fprintf("Accuracy        = %.3f\n", accuracy);
fprintf("Macro Precision = %.3f\n", macroPrecision);
fprintf("Macro Recall    = %.3f\n", macroRecall);
fprintf("Macro F1        = %.3f\n", macroF1);

%% 20. Weighted-average metrics

weights = support / sum(support);

weightedPrecision = sum(weights .* precision);
weightedRecall = sum(weights .* recall);
weightedF1 = sum(weights .* f1);

fprintf("Weighted Precision = %.3f\n", weightedPrecision);
fprintf("Weighted Recall    = %.3f\n", weightedRecall);
fprintf("Weighted F1        = %.3f\n", weightedF1);

%% 21. Identify the class with lowest recall

[minRecall, idxLowestRecall] = min(recall);

fprintf( ...
    "Lowest recall: %s = %.3f\n", ...
    classNames(idxLowestRecall), ...
    minRecall);

%% 22. Inspect misclassified samples

errorMask = ypred ~= ytest;

errorRows = T(testIdx,:);
errorRows.Actual_Class = ytest;
errorRows.Predicted_Class = ypred;

errorRows = errorRows(errorMask,:);

fprintf("Number of misclassified test samples: %d\n", height(errorRows));

disp(head(errorRows,10))

%% 23. Prediction scores

% fitcecoc returns class scores rather than perfectly calibrated
% multiclass probabilities by default.
%
% A larger score generally indicates stronger support for a class,
% but these values should NOT automatically be interpreted as
% perfectly calibrated probabilities.

scoreTable = array2table(
    scores,
    "VariableNames", matlab.lang.makeValidName(cellstr(classNames))
);

disp(head(scoreTable))

%% 24. Find low-margin / uncertain predictions

% One simple uncertainty indicator is the gap between the largest
% and second-largest class scores.

sortedScores = sort(scores, 2, "descend");

scoreMargin = sortedScores(:,1) - sortedScores(:,2);

uncertaintyTable = table(
    ytest,
    ypred,
    scoreMargin,
    "VariableNames", [
        "Actual_Class"
        "Predicted_Class"
        "Top_Score_Margin"
    ]
);

uncertaintyTable = sortrows(
    uncertaintyTable,
    "Top_Score_Margin",
    "ascend");

disp(head(uncertaintyTable,10))

%% 25. Common student question:
% What is a false negative in a multiclass problem?
%
% Choose one class, for example Z_Scratch.
%
% A false negative means:
% The true class is Z_Scratch,
% but the classifier predicted another fault class.
%
% The engineering consequence depends on the fault and inspection system.

%% 26. Guided Exercise 1
% Find:
% - most common fault class
% - least common fault class
% - class with lowest precision
% - class with lowest recall
% - class with lowest F1

%% 27. Guided Exercise 2
% Remove feature scaling and train the classifier again.
% Compare:
% - accuracy
% - macro F1
%
% Explain why scaling can affect optimization.

%% 28. Guided Exercise 3
% Change the holdout fraction from 20% to 30%.
% Retrain and compare performance.

%% 29. Guided Exercise 4
% Examine the confusion matrix.
% Identify two fault classes that are often confused.
% Suggest one possible reason.

%% 30. Guided Exercise 5
% Find the 10 smallest score margins.
% Determine how many are misclassified.
%
% Does low model confidence appear related to classification error?

%% 31. Review Questions
%
% 1. What is classification?
% 2. What is multiclass classification?
% 3. What does one row in this dataset represent?
% 4. Why is the original target stored in seven columns?
% 5. Why do we use a stratified split?
% 6. Why do we standardize features?
% 7. Why must scaling parameters come only from training data?
% 8. What is accuracy?
% 9. What is precision?
% 10. What is recall?
% 11. What is F1 score?
% 12. What is a false negative?
% 13. Why can accuracy be misleading?
% 14. What does support mean?
% 15. Why examine a confusion matrix?
% 16. Why must engineering error costs be considered?

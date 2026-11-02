%% Week 8 - Classification for Engineering Decisions (MATLAB)
% Treat each %% section like a notebook code cell.
% Read the explanation, run one section, inspect the output, then continue.
% In MATLAB Live Editor, each %% section can be run independently.
% ESC 113: Computer Aided Analysis for Engineering
%
% MATLAB Live Editor classification workflow for Week 8.
% Comments explain both WHAT each command does and WHY it is used.
% Work section-by-section; do not run ahead if an output is unclear.
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

clear                                           % remove variables from the workspace
clc                                             % clear the Command Window
close all                                       % close open figure windows

%% 1. Download the UCI dataset

zipURL = "https://archive.ics.uci.edu/static/public/198/steel+plates+faults.zip";
zipFile = "steel_plates_faults.zip";
dataFolder = "steel_plates_faults_data";

if ~isfile(zipFile)
    websave(zipFile, zipURL);                   % download the dataset ZIP file
end

if ~isfolder(dataFolder)
    unzip(zipFile, dataFolder);                 % extract the downloaded dataset
end

%% 2. Locate the numeric data file

files = dir(fullfile(dataFolder, "**", "*"));   % list files in the data folder
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

M = readmatrix(dataFile, "FileType", "text");   % read numeric data from the text file

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

% Columns 1:27 are the measured input features used by the model.
X = M(:,1:27);

% Columns 28:34 are seven class-indicator columns. One value is active per row.
Yindicator = M(:,28:34);

% Convert one-hot indicator rows into one categorical class label.
[~, classIndex] = max(Yindicator, [], 2);       % find the active target indicator in each row
y = categorical(classNames(classIndex));        % convert class names into categorical labels

fprintf("Feature matrix size: %d x %d\n", size(X,1), size(X,2));
fprintf("Number of classes: %d\n", numel(categories(y)));

%% 6. Create a table with self-descriptive feature names

T = array2table(X, "VariableNames", cellstr(featureNames));  % convert numeric data into a MATLAB table
% Add the target class as a named table column so rows are easier to inspect.
T.Fault_Class = y;

disp(head(T))                                   % display a variable or table

%% 7. Check missing values

missingPerFeature = sum(ismissing(T(:,1:27)),1);

missingTable = table(
    featureNames,
    missingPerFeature',
    "VariableNames", ["Feature","Missing_Count"]
);

disp(missingTable)                              % display a variable or table

%% 8. Examine class balance

classSummary = countcats(y);                    % count observations in each class
classCategories = categories(y);

classTable = table(
    string(classCategories),
    classSummary,
    "VariableNames", ["Fault_Class","Count"]
);

disp(classTable)                                % display a variable or table

figure                                          % open a new figure
bar(classSummary)                               % draw a bar chart
xticks(1:numel(classCategories))
xticklabels(classCategories)
xtickangle(45)
ylabel("Number of Fault Instances")             % label the y-axis
xlabel("Fault Class")                           % label the x-axis
title("Steel Fault Class Distribution")         % add a plot title
grid on                                         % show grid lines

%% 9. Stratified train/test split

% cvpartition uses the class labels to preserve class proportions
% approximately across the training and test partitions.

% Hold out 20% of the labeled observations for final testing.
% Passing categorical y helps MATLAB preserve class proportions approximately.
cv = cvpartition(y, "HoldOut", 0.20);           % create a stratified train/test partition

trainIdx = training(cv);                        % identify training rows
testIdx = test(cv);                             % identify test rows

% ":" means keep all 27 feature columns for the selected rows.
Xtrain = X(trainIdx,:);                       % features used to fit the model
Xtest = X(testIdx,:);                         % features kept unseen during fitting
ytrain = y(trainIdx);                         % known classes for training rows
ytest = y(testIdx);                           % known classes used only for evaluation

fprintf("Training observations: %d\n", numel(ytrain));
fprintf("Test observations: %d\n", numel(ytest));

%% 10. Compare class proportions

trainCounts = countcats(ytrain);                % count observations in each class
testCounts = countcats(ytest);                  % count observations in each class

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

disp(splitTable)                                % display a variable or table

%% 11. Standardize features using TRAINING data only

mu = mean(Xtrain,1);                            % calculate training-set feature means
sigma = std(Xtrain,0,1);                        % calculate training-set feature standard deviations

% Avoid division by zero for any constant feature.
sigma(sigma == 0) = 1;

XtrainScaled = (Xtrain - mu) ./ sigma;          % standardize the training features
XtestScaled = (Xtest - mu) ./ sigma;            % standardize test data using training statistics

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

% Define the type of binary learner that will be used inside the multiclass ECOC model.
learner = templateLinear( ...
    "Learner", "logistic", ...
    "Solver", "lbfgs");

% Fit the multiclass classifier using ONLY the scaled training data.
model = fitcecoc( ...
    XtrainScaled, ...
    ytrain, ...
    "Learners", learner, ...
    "Coding", "onevsall", ...
    "ClassNames", categorical(classNames));     % convert class names into categorical labels

%% 14. Make predictions

% Apply the trained model to observations that were not used for fitting.
% ypred = predicted class; scores = relative support for each possible class.
[ypred, scores] = predict(model, XtestScaled);

comparison = table(
    ytest,
    ypred,
    "VariableNames", ["Actual_Class","Predicted_Class"]
);

disp(head(comparison,15))                       % display a variable or table

%% 15. Accuracy

accuracy = mean(ypred == ytest);                % calculate overall classification accuracy

fprintf("Accuracy = %.3f\n", accuracy);

%% 16. Confusion matrix

figure                                          % open a new figure
confusionchart(ytest, ypred)                    % display the confusion matrix
title("Steel Fault Classification - Confusion Matrix")  % add a plot title

%% 17. Obtain numeric confusion matrix

order = categorical(classNames);                % convert class names into categorical labels

C = confusionmat(ytest, ypred, "Order", order);  % calculate the numeric confusion matrix

disp("Confusion matrix:")                       % display a variable or table
disp(C)                                         % display a variable or table

%% 18. Calculate per-class precision, recall, and F1

nClasses = numel(classNames);

precision = zeros(nClasses,1);
recall = zeros(nClasses,1);
f1 = zeros(nClasses,1);
support = zeros(nClasses,1);

% Repeat the calculation once for each fault class.
for k = 1:nClasses

    TP = C(k,k);                              % correctly predicted samples for class k
    FN = sum(C(k,:)) - TP;                   % true class k, predicted as another class
    FP = sum(C(:,k)) - TP;                   % predicted class k, true class was different

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

disp(metricsTable)                              % display a variable or table

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

% TRUE means the predicted class does not match the known class.
errorMask = ypred ~= ytest;

errorRows = T(testIdx,:);
errorRows.Actual_Class = ytest;
errorRows.Predicted_Class = ypred;

errorRows = errorRows(errorMask,:);

fprintf("Number of misclassified test samples: %d\n", height(errorRows));

disp(head(errorRows,10))                        % display a variable or table

%% 23. Prediction scores

% fitcecoc returns class scores rather than perfectly calibrated
% multiclass probabilities by default.
%
% A larger score generally indicates stronger support for a class,
% but these values should NOT automatically be interpreted as
% perfectly calibrated probabilities.

scoreTable = array2table(                       % convert numeric data into a MATLAB table
    scores,
    "VariableNames", matlab.lang.makeValidName(cellstr(classNames))
);

disp(head(scoreTable))                          % display a variable or table

%% 24. Find low-margin / uncertain predictions

% One simple uncertainty indicator is the gap between the largest
% and second-largest class scores.

sortedScores = sort(scores, 2, "descend");      % sort class scores from highest to lowest

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

uncertaintyTable = sortrows(                    % sort rows by the selected column
    uncertaintyTable,
    "Top_Score_Margin",
    "ascend");

disp(head(uncertaintyTable,10))                 % display a variable or table

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
%
% CLUE:
% Use classSummary for class counts.
% Use min(precision), min(recall), and min(f1).

%% 27. Guided Exercise 2
% Remove feature scaling and train the classifier again.
% Compare:
% - accuracy
% - macro F1
%
% CLUE:
% Train fitcecoc using Xtrain and Xtest instead of the scaled arrays.
%
% Explain why scaling can affect optimization.

%% 28. Guided Exercise 3
% Change the holdout fraction from 20% to 30%.
% Retrain and compare performance.
%
% CLUE:
% Change "HoldOut", 0.20 to "HoldOut", 0.30.

%% 29. Guided Exercise 4
% Examine the confusion matrix.
% Identify two fault classes that are often confused.
% Suggest one possible reason.
%
% CLUE:
% Look for a large off-diagonal value in C.

%% 30. Guided Exercise 5
% Find the 10 smallest score margins.
% Determine how many are misclassified.
%
% CLUE:
% sortrows(uncertaintyTable,"Top_Score_Margin","ascend")
% then compare Actual_Class and Predicted_Class.
%
% Does low model confidence appear related to classification error?

%% 31. Review Questions
%
% Try each question first. Use the clue only if needed.
%
% 1. What is classification?
%    CLUE: predicting categories.
%
% 2. What is multiclass classification?
%    CLUE: more than two classes.
%
% 3. What does one row in this dataset represent?
%    CLUE: one detected surface-fault instance.
%
% 4. Why is the original target stored in seven columns?
%    CLUE: one-hot / indicator representation.
%
% 5. Why do we use a stratified split?
%    CLUE: preserve class proportions.
%
% 6. Why do we standardize features?
%    CLUE: different numerical scales.
%
% 7. Why must scaling parameters come only from training data?
%    CLUE: avoid data leakage.
%
% 8. What is accuracy?
%    CLUE: correct predictions / total predictions.
%
% 9. What is precision?
%    CLUE: among predicted positives, how many are correct?
%
% 10. What is recall?
%     CLUE: among actual positives, how many are detected?
%
% 11. What is F1 score?
%     CLUE: combines precision and recall.
%
% 12. What is a false negative?
%     CLUE: a real fault that the model misses.
%
% 13. Why can accuracy be misleading?
%     CLUE: imbalanced classes.
%
% 14. What does support mean?
%     CLUE: number of true observations in a class.
%
% 15. Why examine a confusion matrix?
%     CLUE: see which classes are confused.
%
% 16. Why must engineering error costs be considered?
%     CLUE: different mistakes can have different real-world consequences.

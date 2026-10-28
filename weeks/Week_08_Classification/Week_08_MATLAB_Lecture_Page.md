# Week 8 — Classification for Engineering Decisions

**MATLAB implementation**

## How to Use This Lecture Page

Work through this page like a Colab notebook:

1. Read the explanation.
2. Run the small MATLAB code block.
3. Inspect the output.
4. Read the interpretation.
5. Continue to the next step.

The complete runnable script is linked at the end.

---

## Python and MATLAB in This Chapter

The classification concepts are the same in both programming environments. Students should understand the **engineering workflow first**, then see how Python and MATLAB implement the same steps.

### Python

Python is used through **Google Colab/Jupyter Notebook** with libraries such as:

- `pandas` for tabular data;
- `NumPy` for numerical arrays;
- `scikit-learn` for train/test splitting, scaling, classification, and evaluation;
- `Matplotlib` for plots.

In Python, the Week 8 workflow uses tools such as:

```python
train_test_split(...)
StandardScaler()
LogisticRegression(...)
confusion_matrix(...)
classification_report(...)
```

The Python lecture is organized as small notebook cells with text, code, output, and interpretation.

### MATLAB

MATLAB is used through **MATLAB Online/Desktop and the Live Editor**. The equivalent workflow uses functions from the Statistics and Machine Learning Toolbox.

Important Week 8 MATLAB functions include:

```matlab
cvpartition(...)
mean(...)
std(...)
templateLinear(...)
fitcecoc(...)
predict(...)
confusionchart(...)
confusionmat(...)
```

The MATLAB lecture is also organized as small notebook-style steps so students can read an explanation, run a short code section, inspect the result, and continue.

### Same Engineering Workflow

| Engineering step | Python | MATLAB |
|---|---|---|
| Store numerical data | NumPy / pandas | arrays / tables |
| Train/test split | `train_test_split` | `cvpartition` |
| Standardization | `StandardScaler` | training mean and standard deviation |
| Multiclass classifier | `LogisticRegression` | `templateLinear` + `fitcecoc` |
| Prediction | `model.predict(...)` | `predict(model,...)` |
| Confusion matrix | `confusion_matrix` | `confusionmat` |
| Confusion-matrix display | Matplotlib / display tools | `confusionchart` |
| Precision, recall, F1 | `classification_report` | calculated from confusion matrix |

The code syntax is different, but the reasoning is the same:

```text
engineering problem
        ↓
features and target
        ↓
train/test split
        ↓
preprocessing
        ↓
train classifier
        ↓
predict
        ↓
evaluate
        ↓
engineering interpretation
```

---

## Engineering Problem

The goal is to classify a detected steel-surface fault into one of seven classes:

```text
Pastry
Z_Scratch
K_Scatch
Stains
Dirtiness
Bumps
Other_Faults
```

Each observation contains **27 numerical input features** describing the detected fault.

The output is one class label.

---

## Step 1 — Download the Dataset

```matlab
zipURL = "https://archive.ics.uci.edu/static/public/198/steel+plates+faults.zip";
zipFile = "steel_plates_faults.zip";
```

Now download it if it is not already present.

```matlab
if ~isfile(zipFile)
    websave(zipFile,zipURL);
end
```

The file is downloaded only once.

---

## Step 2 — Extract the Files

```matlab
dataFolder = "steel_plates_faults_data";

if ~isfolder(dataFolder)
    unzip(zipFile,dataFolder);
end
```

---

## Step 3 — Locate the Data File

```matlab
files = dir(fullfile(dataFolder,"**","*"));
fileNames = string({files.name});
```

Find `Faults.NNA`.

```matlab
idx = contains(lower(fileNames),"faults.nna");
```

Create its complete path.

```matlab
filePaths = string(fullfile({files.folder},{files.name}));
dataFile = filePaths(find(idx,1));
```

---

## Step 4 — Read the Numeric Data

```matlab
M = readmatrix(dataFile,"FileType","text");
```

Check the size.

```matlab
size(M)
```

Expected structure:

```text
1941 rows
34 columns
```

The first 27 columns are features.

The final 7 columns are class indicators.

---

## Step 5 — Separate Features and Targets

```matlab
X = M(:,1:27);
Yindicator = M(:,28:34);
```

`X` contains the information used by the classifier.

`Yindicator` tells us the correct fault class.

---

## Step 6 — Define the Class Names

```matlab
classNames = [
    "Pastry"
    "Z_Scratch"
    "K_Scatch"
    "Stains"
    "Dirtiness"
    "Bumps"
    "Other_Faults"
];
```

---

## Step 7 — Convert Indicators to One Class Label

Each row has one active target indicator.

```matlab
[~,classIndex] = max(Yindicator,[],2);
```

Convert those indices into class labels.

```matlab
y = categorical(classNames(classIndex));
```

Now each observation has one categorical target.

---

## Step 8 — Check Class Balance

```matlab
classCounts = countcats(y);
classCategories = categories(y);
```

Display them.

```matlab
table(string(classCategories),classCounts)
```

Plot them.

```matlab
bar(classCounts)
xticklabels(classCategories)
xtickangle(45)
ylabel("Number of Fault Instances")
grid on
```

### Interpretation

A class with fewer observations gives the model fewer examples from which to learn.

This is why accuracy alone may not be enough.

---

## Step 9 — Create a Train/Test Split

```matlab
rng(42)
cv = cvpartition(y,"HoldOut",0.20);
```

Create the row indices.

```matlab
trainIdx = training(cv);
testIdx = test(cv);
```

Separate features.

```matlab
Xtrain = X(trainIdx,:);
Xtest = X(testIdx,:);
```

Separate labels.

```matlab
ytrain = y(trainIdx);
ytest = y(testIdx);
```

The model sees the training data during fitting.

The test data are reserved for evaluation.

---

## Step 10 — Calculate Training Scaling Parameters

```matlab
mu = mean(Xtrain,1);
sigma = std(Xtrain,0,1);
```

Protect against a zero standard deviation.

```matlab
sigma(sigma == 0) = 1;
```

---

## Step 11 — Scale the Data

```matlab
XtrainScaled = (Xtrain-mu)./sigma;
```

Use the **same training values** for the test set.

```matlab
XtestScaled = (Xtest-mu)./sigma;
```

### Why?

If test-set statistics are used to prepare the training data, information leaks from the test set into model development.

---

## Step 12 — Define the Logistic Learner

```matlab
learner = templateLinear( ...
    "Learner","logistic", ...
    "Solver","lbfgs");
```

This defines the type of binary classifier used inside the multiclass model.

---

## Step 13 — Train the Multiclass Classifier

```matlab
model = fitcecoc( ...
    XtrainScaled, ...
    ytrain, ...
    "Learners",learner, ...
    "Coding","onevsall");
```

The model trains one-vs-all decision functions for the seven classes.

---

## Step 14 — Predict the Test Set

```matlab
[ypred,scores] = predict(model,XtestScaled);
```

`ypred` contains the predicted classes.

`scores` contains class-support scores.

---

## Step 15 — Inspect a Few Predictions

```matlab
comparison = table(ytest,ypred);
```

Show the first rows.

```matlab
head(comparison,10)
```

This allows individual predictions to be inspected before relying only on summary metrics.

---

## Step 16 — Accuracy

```matlab
accuracy = mean(ypred == ytest);
```

Display it.

```matlab
fprintf("Accuracy = %.3f\n",accuracy)
```

Accuracy is:

```text
correct predictions
-------------------
all predictions
```

---

## Step 17 — Confusion Matrix

```matlab
confusionchart(ytest,ypred)
```

The diagonal represents correct predictions.

Off-diagonal cells show which fault classes are being confused.

---

## Step 18 — Numeric Confusion Matrix

```matlab
order = categorical(classNames);
C = confusionmat(ytest,ypred,"Order",order);
```

Inspect it.

```matlab
disp(C)
```

---

## Step 19 — One Class at a Time

For class `k`:

```matlab
TP = C(k,k);
```

False negatives:

```matlab
FN = sum(C(k,:)) - TP;
```

False positives:

```matlab
FP = sum(C(:,k)) - TP;
```

These values are then used for precision and recall.

---

## Step 20 — Precision

```matlab
precision_k = TP/(TP+FP);
```

Precision asks:

> Of the observations predicted as this class, how many were correct?

---

## Step 21 — Recall

```matlab
recall_k = TP/(TP+FN);
```

Recall asks:

> Of the observations that truly belong to this class, how many were detected?

---

## Step 22 — F1 Score

```matlab
f1_k = 2*precision_k*recall_k/(precision_k+recall_k);
```

F1 balances precision and recall.

---

## Step 23 — Inspect Misclassifications

```matlab
errorMask = ypred ~= ytest;
```

Count them.

```matlab
sum(errorMask)
```

Compare actual and predicted classes.

```matlab
table(ytest(errorMask),ypred(errorMask))
```

Looking at failures often reveals more than a single performance number.

---

## Step 24 — Prediction Confidence Idea

Sort each row of class scores.

```matlab
sortedScores = sort(scores,2,"descend");
```

Calculate the gap between the top two scores.

```matlab
scoreMargin = sortedScores(:,1)-sortedScores(:,2);
```

A small score margin means the model's top two class choices were close.

These scores should not automatically be interpreted as calibrated probabilities.

---

## Python and MATLAB Comparison

| Task | Python | MATLAB |
|---|---|---|
| Split | `train_test_split(..., stratify=y)` | `cvpartition(y,"HoldOut",...)` |
| Scale | `StandardScaler` | training mean/std calculation |
| Logistic classifier | `LogisticRegression` | `templateLinear` + `fitcecoc` |
| Predict | `.predict()` | `predict` |
| Confusion matrix | `confusion_matrix` | `confusionmat` |
| Display matrix | plotting library | `confusionchart` |

---

## Common Errors

### Scaling the full dataset before the split

This creates data leakage.

### Looking only at accuracy

Minority classes may perform poorly even when overall accuracy seems reasonable.

### Treating scores as perfect probabilities

The class scores returned by the model are not automatically calibrated probabilities.

### Ignoring the physical meaning of errors

In engineering, different misclassifications can have different consequences.

---

## Guided Practice

1. Identify the most and least common classes.
2. Find the class with the lowest recall.
3. Train the model without scaling and compare performance.
4. Change the holdout fraction from 20% to 30%.
5. Identify two classes that are frequently confused.
6. Inspect the ten lowest score margins and determine how many are errors.

---

## Complete Runnable MATLAB Code

[Week 8 Classification MATLAB Script](Week_08_Classification_MATLAB.m)

[MATLAB Usage Instructions](MATLAB_Usage_Instructions_BMCC.md)

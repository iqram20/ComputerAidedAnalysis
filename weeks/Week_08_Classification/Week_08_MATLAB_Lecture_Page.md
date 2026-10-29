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

## MATLAB in This Chapter

Week 8 is taught entirely in **MATLAB Live Editor**.

The main functions used in the classification workflow include:

```matlab
readmatrix(...)
array2table(...)
categorical(...)
countcats(...)
cvpartition(...)
mean(...)
std(...)
templateLinear(...)
fitcecoc(...)
predict(...)
confusionchart(...)
confusionmat(...)
```

The focus is on the engineering workflow rather than memorizing commands.

---


## Visual Map of the MATLAB Classification Workflow

~~~mermaid
flowchart LR
    A[Steel fault measurements] --> B[27 input features]
    B --> C[Class labels]
    C --> D[Train / test split]
    D --> E[Training-only scaling]
    E --> F[fitcecoc classifier]
    F --> G[predict on test set]
    G --> H[Confusion matrix + metrics]
    H --> I[Inspect errors]
    I --> J[Engineering interpretation]
~~~

Use this diagram as the map for the code sections below. Each MATLAB section performs one part of this flow.

---

## Train/Test Split and Leakage Prevention

~~~mermaid
flowchart TD
    A[Complete dataset] --> B[Training set]
    A --> C[Test set]

    B --> D[Compute mu and sigma]
    D --> E[Scale training set]
    D --> F[Use same mu and sigma on test set]

    E --> G[Train model]
    F --> H[Predict with trained model]
    G --> H

    C --> F
~~~

The test set does not contribute to the scaling parameters or model fitting.

---

## How Evaluation Connects to Engineering Decisions

~~~mermaid
flowchart LR
    A[True labels] --> C[Confusion matrix]
    B[Predicted labels] --> C

    C --> D[Precision]
    C --> E[Recall]
    C --> F[F1 score]
    C --> G[Accuracy]

    D --> H[Which errors matter?]
    E --> H
    F --> H
    G --> H

    H --> I[Engineering decision / model limitation]
~~~

A model can have acceptable overall accuracy while still missing an important fault class. This is why the confusion matrix and per-class metrics are essential.

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



---

## Before Running the Model — Understand the Dataset

One row represents one detected steel-plate surface fault.

The 27 input features describe location, size, brightness, geometry, orientation, steel type, plate thickness, and transformed size measurements.

The model output is one of seven categorical fault labels.

### Feature groups

Location:
X_Minimum, X_Maximum, Y_Minimum, Y_Maximum

Size/perimeter:
Pixels_Areas, X_Perimeter, Y_Perimeter

Luminosity:
Sum_of_Luminosity, Minimum_of_Luminosity, Maximum_of_Luminosity, Luminosity_Index

Production/steel:
Length_of_Conveyer, TypeOfSteel_A300, TypeOfSteel_A400, Steel_Plate_Thickness

Shape:
Edges_Index, Empty_Index, Square_Index, Outside_X_Index, Outside_Global_Index

Direction:
Edges_X_Index, Edges_Y_Index, Orientation_Index

Transformed size:
LogOfAreas, Log_X_Index, Log_Y_Index, SigmoidOfAreas

### Class meanings

| Class | Course description |
|---|---|
| Pastry | Named category in the UCI dataset |
| Z_Scratch | Scratch-type fault |
| K_Scatch | Second scratch-type category |
| Stains | Stain/discoloration-type fault |
| Dirtiness | Dirty/contamination-like fault |
| Bumps | Bump-like irregularity |
| Other_Faults | Other fault types |

The dataset does not provide a detailed metallurgical explanation for every label, so the course does not invent one.

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



---

## Interpreting the Final Model

A classification result should not be reported only as one accuracy number.

A useful engineering interpretation should include:

- overall accuracy;
- class distribution;
- confusion matrix;
- class with lowest recall;
- class with lowest F1;
- major confusion pairs;
- number of misclassified samples;
- uncertainty or score-margin behavior;
- possible engineering consequence of important errors.

### Metric summary

Accuracy:
correct predictions divided by all predictions.

Precision:
TP divided by TP + FP.

Recall:
TP divided by TP + FN.

F1:
harmonic mean of precision and recall.

Macro average:
all classes contribute equally.

Weighted average:
classes contribute according to support.

### Example interpretation style

Instead of writing:

    Accuracy = 0.82

write something like:

The classifier correctly identified approximately 82% of the held-out observations. However, performance differed across fault classes. The confusion matrix and per-class recall should therefore be examined before deciding whether the model is suitable for engineering inspection support.

## MATLAB Workflow Summary

| Task | MATLAB |
|---|---|
| Read data | `readmatrix` |
| Organize data | arrays / tables |
| Create categorical labels | `categorical` |
| Train/test split | `cvpartition` |
| Standardization | training mean and standard deviation |
| Logistic learner | `templateLinear` |
| Multiclass model | `fitcecoc` |
| Prediction | `predict` |
| Confusion matrix | `confusionmat`, `confusionchart` |

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

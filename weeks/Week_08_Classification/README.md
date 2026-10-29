# Week 8 — Classification for Engineering Decisions

## Primary Environment

**MATLAB Live Editor** is the primary and only active programming environment for this chapter.

## Engineering Case Study

**UCI Steel Plates Faults**  
Dataset ID: 198  
Observations: 1,941  
Input features: 27  
Target classes: 7

Dataset: https://archive.ics.uci.edu/dataset/198/steel+plates+faults

### Classes

- Pastry
- Z_Scratch
- K_Scatch
- Stains
- Dirtiness
- Bumps
- Other_Faults



## What One Row Represents

Each row represents one detected steel-plate surface fault.

The model receives 27 numerical measurements describing that fault and predicts one of seven fault classes.

The original target is stored using seven indicator columns. MATLAB converts these indicators into one categorical class label before training.

## Target Class Meaning

| Class | Description |
|---|---|
| Pastry | Named fault category in the original dataset |
| Z_Scratch | Scratch-type fault category |
| K_Scatch | Another scratch-type category; spelling follows the dataset |
| Stains | Stain or discoloration-type fault |
| Dirtiness | Dirty or contamination-like surface fault |
| Bumps | Bump-like surface irregularity |
| Other_Faults | Faults outside the six named categories |

The source dataset does not provide a detailed physical definition for every class, so these descriptions are intentionally conservative.

## Feature Groups

The 27 inputs can be understood in groups.

### Fault location
- X_Minimum
- X_Maximum
- Y_Minimum
- Y_Maximum

These describe where the detected fault appears.

### Fault size and perimeter
- Pixels_Areas
- X_Perimeter
- Y_Perimeter

These describe fault size and boundary extent.

### Brightness and luminosity
- Sum_of_Luminosity
- Minimum_of_Luminosity
- Maximum_of_Luminosity
- Luminosity_Index

These describe image intensity characteristics.

### Steel and production context
- Length_of_Conveyer
- TypeOfSteel_A300
- TypeOfSteel_A400
- Steel_Plate_Thickness

These provide information about the production environment and plate.

### Shape features
- Edges_Index
- Empty_Index
- Square_Index
- Outside_X_Index
- Outside_Global_Index

These summarize fault geometry.

### Direction and orientation
- Edges_X_Index
- Edges_Y_Index
- Orientation_Index

These describe directional characteristics of the fault.

### Transformed size features
- LogOfAreas
- Log_X_Index
- Log_Y_Index
- SigmoidOfAreas

These are transformed versions of fault size or area.

## Why 27 Features?

A fault type may depend on several measurements at once. Two faults may have similar size but different brightness, orientation, or shape. Classification combines these measurements instead of relying on one threshold.

## Why Stratification Matters

Some fault classes occur more often than others. A stratified holdout helps preserve the class proportions approximately in training and test sets.

MATLAB uses:

    cv = cvpartition(y,"HoldOut",0.20);

## Why Scaling Matters

The features use very different numerical ranges. Standardization uses the training-set mean and standard deviation:

    z = (x - training mean) / training standard deviation

The test set must use the same training statistics. Calculating scaling values from the complete dataset would cause data leakage.

## Model Used

The chapter uses a linear logistic learner inside a multiclass ECOC framework.

Main MATLAB functions:

- templateLinear
- fitcecoc
- predict

## Evaluation Metrics

### Accuracy

Accuracy = correct predictions / total predictions

Accuracy summarizes overall performance, but it may hide poor performance on a smaller class.

### Precision

Precision = TP / (TP + FP)

Question: when the model predicts this class, how often is it correct?

### Recall

Recall = TP / (TP + FN)

Question: of all true observations in this class, how many were detected?

### F1 Score

F1 = 2 × Precision × Recall / (Precision + Recall)

F1 balances precision and recall.

### Support

Support is the number of true observations belonging to a class.

### Macro Average

Each class contributes equally.

### Weighted Average

Each class contributes according to its number of observations.

## Confusion Matrix

The diagonal contains correct predictions. Off-diagonal cells show which fault classes are confused.

A confusion matrix is often more useful than accuracy alone because it shows the pattern of errors.

## Misclassification Analysis

Students should ask:

- Which classes are confused most often?
- Which class has the lowest recall?
- Are rare classes harder to detect?
- Are low-score-margin predictions more likely to be wrong?
- Could a false negative be more important than a false positive?

## Common Mistakes

1. Scaling before the train/test split.
2. Using test-set information during preprocessing.
3. Reporting accuracy only.
4. Ignoring class imbalance.
5. Treating model scores as exact probabilities.
6. Ignoring which classes are being confused.
7. Assuming statistical association proves physical causation.



## Visual Machine Learning Workflow

~~~mermaid
flowchart LR
    A[Engineering problem] --> B[Load labeled data]
    B --> C[Define features and target]
    C --> D[Inspect class balance]
    D --> E[Train / test split]
    E --> F[Training-only preprocessing]
    F --> G[Train classifier]
    G --> H[Predict unseen test data]
    H --> I[Evaluate performance]
    I --> J[Engineering interpretation]
~~~

This diagram shows the complete Week 8 workflow. Each MATLAB section in the lecture corresponds to one of these blocks.

## Regression or Classification?

~~~mermaid
flowchart TD
    A[Engineering prediction problem] --> B{Target type}
    B -->|Continuous numerical value| C[Regression]
    B -->|Category or class label| D[Classification]
    C --> E[Example: Power = 452.8 MW]
    D --> F[Example: Fault = Z_Scratch]
~~~

Week 8 is a classification problem because the output is a fault category.

## Train/Test Split and Preprocessing Flow

~~~mermaid
flowchart LR
    A[Complete labeled dataset] --> B[Training set]
    A --> C[Test set]

    B --> D[Calculate training mean / std]
    D --> E[Scale training data]
    E --> F[Train classifier]

    C --> G[Scale using training mean / std]

    F --> H[Trained model]
    G --> I[Test features]
    H --> J[Predict test labels]
    I --> J
    J --> K[Compare with true test labels]
~~~

The test set is kept independent from model fitting. Scaling parameters must come from the training set only.

## Classification Evaluation Flow

~~~mermaid
flowchart LR
    A[True test labels] --> C[Confusion matrix]
    B[Predicted labels] --> C

    C --> D[Accuracy]
    C --> E[Precision]
    C --> F[Recall]
    C --> G[F1 score]

    D --> H[Engineering interpretation]
    E --> H
    F --> H
    G --> H
~~~

The final goal is not only to calculate metrics, but to understand which faults are being missed or confused and what those errors mean in an engineering setting.

## MATLAB Live Editor Lecture

- [Primary MATLAB Lecture Page](Week_08_MATLAB_Lecture_Page.md)
- [Complete MATLAB Script](Week_08_Classification_MATLAB.m)
- [MATLAB Usage Instructions](MATLAB_Usage_Instructions_BMCC.md)

The MATLAB lecture uses small sequential sections: explanation → code → output → interpretation.

## MATLAB Classification Workflow

The chapter uses MATLAB for data loading, class preparation, stratified splitting, training-data standardization, multiclass classification, prediction, confusion-matrix analysis, precision, recall, F1, and error analysis.

## Main Topics

- classification vs regression
- binary vs multiclass classification
- class balance
- stratified splitting
- scaling
- multiclass classification
- accuracy
- confusion matrix
- precision
- recall
- F1
- macro/weighted metrics
- misclassification analysis
- uncertain predictions
- engineering consequences of errors

> MATLAB requirement: Statistics and Machine Learning Toolbox.

MATLAB Online: https://matlab.mathworks.com/

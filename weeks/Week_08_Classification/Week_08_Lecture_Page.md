# Week 8 — Classification for Engineering Decisions

**ESC 113: Computer Aided Analysis for Engineering**

## Primary Environment

**MATLAB Live Editor**

This chapter is taught entirely in MATLAB. The lecture should be worked through as a sequence of small Live Editor sections:

**concept → small MATLAB code section → output/figure → interpretation → next step**


## Machine Learning as a Flow

~~~mermaid
flowchart LR
    A[Engineering data] --> B[Machine-learning algorithm]
    B --> C[Learned model]
    C --> D[Prediction on new data]
~~~

The model does not receive the answer for a new observation. It uses patterns learned from labeled training data to make a prediction.

---

## Regression or Classification?

~~~mermaid
flowchart TD
    A[Engineering prediction problem] --> B{What type of target?}
    B -->|Continuous numerical value| C[Regression]
    B -->|Category or class label| D[Classification]
    C --> E[Power = 452.8 MW]
    C --> F[Strength = 42.1 MPa]
    D --> G[Machine = Faulty]
    D --> H[Defect = Z_Scratch]
~~~

Week 7 used regression. Week 8 uses classification because the target is a fault category.

---

## Overall Week 8 Classification Workflow

~~~mermaid
flowchart LR
    A[Engineering problem] --> B[Collect / load labeled data]
    B --> C[Define features and target]
    C --> D[Inspect class balance]
    D --> E[Train / test split]
    E --> F[Training-only preprocessing]
    F --> G[Train classifier]
    G --> H[Predict unseen test data]
    H --> I[Evaluate errors]
    I --> J[Engineering interpretation]
~~~

This is the complete workflow students should keep in mind while working through the MATLAB code.

---

## Why Several Measurements May Be Needed

~~~mermaid
flowchart LR
    A1[Fault location] --> M[Fault class]
    A2[Fault size] --> M
    A3[Brightness] --> M
    A4[Shape] --> M
    A5[Orientation] --> M
    A6[Steel type] --> M
    A7[Plate thickness] --> M

    M --> C1[Pastry]
    M --> C2[Z_Scratch]
    M --> C3[K_Scatch]
    M --> C4[Stains]
    M --> C5[Dirtiness]
    M --> C6[Bumps]
    M --> C7[Other_Faults]
~~~

The classifier combines many measurements because one feature alone may not distinguish all fault types.

---

## From Physical Fault to Model Prediction

~~~mermaid
flowchart LR
    A[Physical steel defect] --> B[Image / sensing system]
    B --> C[Measure geometry and appearance]
    C --> D[27 numerical features]
    D --> E[MATLAB classifier]
    E --> F[Predicted fault class]
~~~

The machine-learning model does not directly “see” the physical defect. It receives numerical features extracted from the detection process.

---

## Main Engineering Question

Can measured geometric and image-derived features be used to classify the type of surface fault on a steel plate?

## Engineering Case Study

**UCI Steel Plates Faults**

- Dataset ID: 198
- Observations: 1,941
- Input features: 27
- Target classes: 7
- One row: one detected steel-plate surface fault

Dataset:
https://archive.ics.uci.edu/dataset/198/steel+plates+faults

## Target Classes

- Pastry
- Z_Scratch
- K_Scatch
- Stains
- Dirtiness
- Bumps
- Other_Faults

## Machine-Learning Background

Classification is used when the target is a category rather than a continuous numerical value.

Examples:

| Engineering problem | Possible classes |
|---|---|
| Machine monitoring | Normal / Warning / Fault |
| Structural monitoring | Safe / Inspect / Critical |
| Manufacturing quality | Accept / Reject |
| Surface inspection | Scratch / Stain / Bump / Other |



## Detailed Feature Guide

The input features should be understood before the model is trained.

### Location

X_Minimum, X_Maximum, Y_Minimum, and Y_Maximum describe the detected fault position.

### Size and perimeter

Pixels_Areas, X_Perimeter, and Y_Perimeter describe fault area and boundary extent.

### Luminosity

Sum_of_Luminosity, Minimum_of_Luminosity, Maximum_of_Luminosity, and Luminosity_Index describe image brightness characteristics.

### Steel and production information

Length_of_Conveyer, TypeOfSteel_A300, TypeOfSteel_A400, and Steel_Plate_Thickness describe production or plate context.

### Shape

Edges_Index, Empty_Index, Square_Index, Outside_X_Index, and Outside_Global_Index summarize aspects of fault geometry.

### Direction

Edges_X_Index, Edges_Y_Index, and Orientation_Index describe directional characteristics.

### Transformed size variables

LogOfAreas, Log_X_Index, Log_Y_Index, and SigmoidOfAreas provide transformed size information.

## Why Class Balance Matters

If a class appears only a small number of times, the classifier has fewer examples from which to learn. This is why the class distribution should be inspected before training.

## Why the Test Set Must Stay Independent

The test set estimates performance on unseen observations.

Training, scaling, or tuning with test-set information makes the evaluation overly optimistic.

## Standardization

Training statistics are calculated first:

    mu = mean(Xtrain,1);
    sigma = std(Xtrain,0,1);

Then both sets use the same training statistics:

    XtrainScaled = (Xtrain-mu)./sigma;
    XtestScaled = (Xtest-mu)./sigma;

## Logistic Learner and ECOC

The binary learner is defined with templateLinear using logistic loss. fitcecoc then combines binary learners into a multiclass model.

This lets MATLAB solve a seven-class problem even though the underlying learner is binary.

## Accuracy Is Not Enough

Imagine a model performs well on common faults but misses most examples of a rare but important fault.

Overall accuracy could still look good.

Therefore students must also inspect:

- confusion matrix;
- per-class precision;
- per-class recall;
- per-class F1;
- support;
- macro average;
- weighted average.

## Engineering Meaning of False Negatives

For one selected class, a false negative means:

the true fault belongs to that class, but the classifier predicts another class.

In a real inspection system, the consequence depends on the severity of the missed fault.

## Engineering Meaning of False Positives

A false positive means:

the classifier predicts a selected fault class when the true fault belongs to another class.

This may cause unnecessary inspection or rework.

## Score Margin and Uncertainty

The difference between the largest and second-largest class score can be used as a simple uncertainty indicator.

Small margin:
the model had two similar class choices.

Large margin:
one class had substantially stronger support.

The score margin is useful for comparison, but the scores are not automatically calibrated probabilities.

## Engineering Interpretation Questions

After training, students should answer:

1. Which class has the highest recall?
2. Which class has the lowest recall?
3. Which pair of classes is confused most often?
4. Does class imbalance appear related to performance?
5. Which errors would be most concerning in an actual quality-control system?
6. Would the model be suitable for automatic rejection, or only for inspection support?

## Classification Workflow in MATLAB

```text
Engineering problem
        ↓
Load and inspect data
        ↓
Define features and target
        ↓
Check class balance
        ↓
Create train/test split
        ↓
Standardize using training data
        ↓
Train multiclass classifier
        ↓
Predict test observations
        ↓
Confusion matrix and metrics
        ↓
Inspect errors
        ↓
Engineering interpretation
```


## Train/Test Split Flow

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
    J --> K[Evaluate against true test labels]
~~~

The test set remains separate from model fitting. Its purpose is to estimate performance on unseen data.

---

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

Metrics are tools for understanding the error pattern. The final goal is engineering interpretation, not just reporting numbers.

---

## Main MATLAB Functions

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

## Evaluation Metrics

Students should understand:

- accuracy;
- confusion matrix;
- true positive;
- false positive;
- false negative;
- precision;
- recall;
- F1 score;
- macro average;
- weighted average;
- support;
- misclassification analysis;
- uncertainty based on class-score margins.

## MATLAB Live Editor Lecture

Use the detailed notebook-style MATLAB page:

- [Week 8 MATLAB Live Editor Lecture](Week_08_MATLAB_Lecture_Page.md)

The page is organized into small sequential MATLAB steps with text and interpretation between code blocks.

## Complete MATLAB Script

- [Week 8 Classification MATLAB Script](Week_08_Classification_MATLAB.m)

The complete script is the runnable reference version. Students should use the Live Editor lecture page first.

## MATLAB Usage

- [MATLAB Usage Instructions for BMCC Students](MATLAB_Usage_Instructions_BMCC.md)

## Required Toolbox

**Statistics and Machine Learning Toolbox**

MATLAB Online:
https://matlab.mathworks.com/

## Learning Outcomes

By the end of the chapter, students should be able to:

1. distinguish regression from classification;
2. explain what one steel-fault observation represents;
3. identify features and target classes;
4. convert class-indicator columns into categorical labels;
5. inspect class balance;
6. create a stratified train/test split;
7. standardize features without test-data leakage;
8. train a multiclass classifier in MATLAB;
9. interpret a confusion matrix;
10. calculate and explain precision, recall, and F1;
11. identify classes with poor recall;
12. inspect misclassified samples;
13. discuss the engineering consequences of classification errors.

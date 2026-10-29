# Week 8 — Classification for Engineering Decisions

**ESC 113: Computer Aided Analysis for Engineering**

## Primary Environment

**MATLAB Live Editor**

This chapter is taught entirely in MATLAB. The lecture should be worked through as a sequence of small Live Editor sections:

**concept → small MATLAB code section → output/figure → interpretation → next step**

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

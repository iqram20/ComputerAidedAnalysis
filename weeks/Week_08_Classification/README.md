# Week 8 — Classification for Engineering Decisions

## Primary Environment

**MATLAB Live Editor** is the primary environment for this chapter.

Week 8 is the **only active chapter that also retains a Python/Colab notebook**. The Python notebook is provided for comparison after students understand the MATLAB workflow.

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

## MATLAB Live Editor Lecture

- [Primary MATLAB Lecture Page](Week_08_MATLAB_Lecture_Page.md)
- [Complete MATLAB Script](Week_08_Classification_MATLAB.m)
- [MATLAB Usage Instructions](MATLAB_Usage_Instructions_BMCC.md)

The MATLAB lecture uses small sequential sections: explanation → code → output → interpretation.

## Python Comparison

- [Python/Colab Classification Notebook](Week_08_Classification.ipynb)

Python is included only to compare the equivalent classification workflow.

## Equivalent Workflow

| Step | MATLAB | Python comparison |
|---|---|---|
| Train/test split | `cvpartition` | `train_test_split` |
| Standardization | training mean/std | `StandardScaler` |
| Multiclass classifier | `templateLinear` + `fitcecoc` | `LogisticRegression` |
| Prediction | `predict` | `.predict()` |
| Confusion matrix | `confusionmat`, `confusionchart` | sklearn confusion matrix |
| Precision/recall/F1 | from confusion matrix | `classification_report` |

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

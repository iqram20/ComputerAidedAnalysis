# Week 8 — Classification for Engineering Decisions

## Main Engineering Case Study

This week uses the **UCI Steel Plates Faults dataset** to classify steel-plate surface defects from 27 numerical fault descriptors.

**Dataset:** UCI Steel Plates Faults  
**Dataset ID:** 198  
**Observations:** 1,941  
**Input features:** 27  
**Target classes:** 7

Dataset source:  
https://archive.ics.uci.edu/dataset/198/steel+plates+faults

## Target Classes

- Pastry
- Z_Scratch
- K_Scatch
- Stains
- Dirtiness
- Bumps
- Other_Faults

## Main Topics

- classification vs regression
- binary vs multiclass classification
- engineering meaning of class labels
- target indicator columns
- class balance and class imbalance
- train/test split
- stratification
- StandardScaler
- pipelines
- multiclass logistic regression
- class predictions
- predicted probabilities
- accuracy
- confusion matrix
- true positives / false positives / false negatives
- precision
- recall
- F1 score
- macro vs weighted averages
- misclassification analysis
- uncertain predictions
- engineering consequences of classification errors

## Learning Outcomes

Students should be able to:

1. distinguish regression from classification;
2. explain what one dataset observation represents;
3. convert indicator targets into class labels;
4. inspect class balance;
5. explain why stratification is useful;
6. explain why scaling is used;
7. train a multiclass logistic-regression classifier;
8. interpret a confusion matrix;
9. distinguish precision from recall;
10. explain F1 score;
11. interpret macro and weighted averages;
12. identify classes with poor recall;
13. inspect misclassified and uncertain samples;
14. connect false positives and false negatives to engineering consequences;
15. explain why accuracy alone can be misleading.

## Class Notebook

- [Week 8 — Detailed Classification Lecture Notebook](Week_08_Classification.ipynb)

The notebook is intentionally detailed and includes **dataset context, feature explanations, student-question sections, code explanations, metrics, engineering interpretations, common mistakes, guided practice, independent exercises, and a 20-question review quiz**.


## MATLAB Equivalent

- [Week 8 — MATLAB Classification Code](Week_08_Classification_MATLAB.m)

The MATLAB script mirrors the Python lecture workflow using the same UCI Steel Plates Faults dataset. It includes dataset download, target conversion, class-balance analysis, stratified train/test splitting, training-data standardization, multiclass linear logistic classification with ECOC, confusion matrix analysis, precision, recall, F1, macro/weighted metrics, misclassification review, and uncertainty analysis.

> **MATLAB requirement:** Statistics and Machine Learning Toolbox.


## Short Videos

Recommended short videos for students who want an additional explanation:

| Topic | Resource | Length |
|---|---|---:|
| Classification basics | [An Introduction to Classification — MathWorks](https://www.mathworks.com/videos/an-introduction-to-classification-68891.html) | 9:00 |
| Logistic regression | [StatQuest: Logistic Regression](https://www.youtube.com/watch?v=yIYKR4sgzI8) | ~8 min |
| Confusion matrix | [StatQuest: The Confusion Matrix](https://www.youtube.com/watch?v=Kdsp6soqA7o) | ~7 min |
| Precision, recall, F1 | [Logistic Regression Evaluation Metrics](https://www.youtube.com/watch?v=eQjtZ0qpOVg) | ~10 min |
| MATLAB classification | [Classify Data Using the Classification Learner App — MathWorks](https://www.mathworks.com/videos/classify-data-using-the-classification-learner-app-106171.html) | 4:34 |

### Recommended use

Students should first read the notebook section and run the example code. Watch the corresponding video only when additional explanation is helpful, then return to the notebook exercises.


## Lecture Page

- [Week 8 — Classification Lecture Page](Week_08_Lecture_Page.md)

Use this page directly while teaching. It contains the lecture sequence, explanations, code, questions to ask students, clues, engineering interpretation, MATLAB equivalents, short videos, and exit questions.

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

# Week 8 — Faculty Observation Teaching Guide

## Lesson Focus

**Classification for Engineering Decisions**

Main case study: UCI Steel Plates Faults dataset.

## Central Question

> How can we classify steel surface faults, and how do we decide whether the classifier is good enough for an engineering application?

## Learning Outcomes

By the end of the class, students should be able to:

1. distinguish classification from regression;
2. explain what the dataset and one observation represent;
3. prepare a multiclass classification problem;
4. explain stratification and feature scaling;
5. train a logistic-regression classifier;
6. interpret a confusion matrix;
7. distinguish accuracy, precision, recall, and F1;
8. connect model errors to engineering consequences.

## Recommended Teaching Flow

### Opening

Start with:

> “If a defect-detection model is 90% accurate, is it automatically good enough?”

Do not answer immediately. Use it as the question students revisit later.

### Connect to Prior Learning

Ask:

> “Last week we predicted power output in MW. Was that regression or classification?”

Then:

> “Today the target is a fault category. What changed?”

### Dataset Context

Before code, establish:

- one row = one detected steel surface fault;
- 27 numerical descriptors;
- seven fault classes;
- real engineering quality-control context.

Ask:

> “Why do you think the dataset contains geometry and luminosity information?”

### Class Balance

Before showing the bar chart, ask students to predict whether the classes will be evenly distributed.

After the chart:

> “If one fault is rare, can overall accuracy hide poor detection of that class?”

### Train/Test Split and Stratification

Use the analogy:

> Training data are practice problems; test data are the unseen exam.

Ask:

> “Why would testing on the same data used for training be unfair?”

### Scaling

Show that feature magnitudes differ.

Ask:

> “If one feature is around 0.2 and another is around 10,000, could that affect optimization?”

### Model Training

Explain only the essential workflow:

`scale → fit → predict`

Avoid spending too long on internal mathematical derivation.

### Confusion Matrix

Pause before interpretation.

Ask students to identify:

- a strong diagonal cell;
- a large off-diagonal cell;
- a fault class that seems difficult.

### Precision vs Recall

Use a manufacturing example.

**False positive:** reject a good plate.  
**False negative:** miss a real defect.

Ask:

> “Which is more serious?”

Use their responses to explain why the engineering context determines the important metric.

### Guided Practice

Students should calculate or identify:

- most common class;
- lowest recall;
- lowest F1;
- one commonly confused class pair;
- one real-world consequence of a false negative.

### Closing

Return to:

> “Is 90% accuracy automatically good enough?”

Expected response: **No.**

Students should mention class imbalance, per-class performance, recall, confusion matrix, or engineering consequences.

## Exit Ticket

1. Why can accuracy be misleading?
2. What is the difference between precision and recall?
3. Which metric would you prioritize for a safety-critical fault, and why?

## What an Observer Should See

- clear learning objectives;
- connection to prior learning;
- instructor questioning;
- student prediction before outputs;
- active interpretation rather than passive coding;
- engineering examples;
- checks for understanding;
- guided practice;
- alignment between objectives, activities, and exit ticket.

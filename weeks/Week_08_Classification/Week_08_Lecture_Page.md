
# Week 8 Lecture Page — Classification for Engineering Decisions

**ESC 113: Computer Aided Analysis for Engineering**

This page is designed to be used directly during lecture.

---

## 1. Main Engineering Question

> Can we classify the type of surface fault on a steel plate using measured geometric and image-based features?

Ask students:
- Is this regression or classification?
- What is the target?
- What does one row represent?
- Why can a wrong prediction matter in manufacturing?

Key idea: **classification predicts a category**.

Examples:
- Healthy / Faulty
- Safe / Unsafe
- Pass / Fail
- Normal / Warning / Critical
- Type of steel defect

---

## 2. Regression vs Classification

| Problem | Target | Type |
|---|---|---|
| Predict power output | 452.8 MW | Regression |
| Predict concrete strength | 42.1 MPa | Regression |
| Predict machine state | Healthy | Classification |
| Predict steel defect | Z_Scratch | Classification |

Ask students:

> If the classes are stored as 0, 1, and 2, is it automatically regression?

No. If the numbers represent categories, the task is still classification.

---

## 3. Binary vs Multiclass Classification

Binary classification has two classes.

Examples:
- Good / Bad
- Pass / Fail
- Fault / No Fault

Multiclass classification has more than two classes.

The Week 8 steel dataset has **seven classes**, so this is multiclass classification.

---

## 4. Dataset Description

**Dataset:** UCI Steel Plates Faults  
**Observations:** 1,941  
**Input features:** 27  
**Target classes:** 7  
**Application:** steel surface-fault classification

One row represents **one detected steel surface fault**.

Target classes:
- Pastry
- Z_Scratch
- K_Scatch
- Stains
- Dirtiness
- Bumps
- Other_Faults

Ask students:

> Is one row one complete steel plate?

No. One row represents one detected fault instance.

---

## 5. What Are the Features?

The 27 input variables describe the fault's:
- location;
- size;
- shape;
- perimeter;
- pixel area;
- luminosity;
- plate thickness;
- orientation;
- other image-derived characteristics.

Examples:

| Feature | Meaning |
|---|---|
| X_Minimum | Minimum horizontal fault position |
| X_Maximum | Maximum horizontal fault position |
| Y_Minimum | Minimum vertical fault position |
| Y_Maximum | Maximum vertical fault position |
| Pixels_Areas | Fault pixel area |
| X_Perimeter | Horizontal perimeter measure |
| Y_Perimeter | Vertical perimeter measure |
| Minimum_of_Luminosity | Minimum grayscale intensity |
| Maximum_of_Luminosity | Maximum grayscale intensity |
| Steel_Plate_Thickness | Plate thickness |
| Orientation_Index | Fault orientation descriptor |
| Luminosity_Index | Normalized luminosity descriptor |

Teaching point:

Not every machine-learning feature has a simple physical interpretation. In image-based engineering datasets, many variables are computed descriptors.

---

## 6. Load the Dataset

~~~python
from ucimlrepo import fetch_ucirepo     # Import function for UCI datasets

steel = fetch_ucirepo(id=198)           # Load Steel Plates Faults dataset

X = steel.data.features.copy()          # Store 27 input features

y_raw = steel.data.targets.copy()       # Store 7 target indicator columns

print(X.shape)                          # Show rows and feature columns

print(y_raw.shape)                      # Show rows and target columns
~~~

Explain:
- X = input features
- y_raw = original target representation
- shape = rows, columns

Expected:
- X ≈ (1941, 27)
- y_raw ≈ (1941, 7)

---

## 7. Why Are There Seven Target Columns?

The original target uses indicator or one-hot representation.

Example:

| Pastry | Z_Scratch | K_Scatch | Stains |
|---:|---:|---:|---:|
| 0 | 1 | 0 | 0 |

This row means the class is Z_Scratch.

Convert the seven target columns into one class label:

~~~python
y = y_raw.idxmax(axis=1)                # Find active class name in each row

print(y.head())                         # Show first few labels

print(y.value_counts())                 # Count samples in each class
~~~

Ask students:

> What does idxmax(axis=1) do?

It finds the column containing the largest value in each row.

---

## 8. Class Balance

~~~python
class_counts = y.value_counts()         # Count observations in each class

print(class_counts)                     # Display class counts
~~~

Plot:

~~~python
import matplotlib.pyplot as plt         # Import plotting library

class_counts.plot(kind="bar")           # Create class-count bar chart

plt.xlabel("Fault Class")               # Label x-axis

plt.ylabel("Number of Samples")         # Label y-axis

plt.title("Steel Fault Class Distribution")  # Add title

plt.show()                              # Display plot
~~~

Ask students before showing the figure:

> Do you expect all seven fault classes to occur equally often?

Key idea: **class imbalance**.

Some fault classes occur more frequently than others.

---

## 9. Why Accuracy Alone Can Mislead Us

Suppose:
- 900 samples are Normal
- 100 samples are Faulty

A model predicts Normal for every sample.

Accuracy:

900 / 1000 = 90%

But it detects:

0% of the faulty samples.

Ask students:

> Is 90% accuracy good here?

No.

This is why classification needs more than one metric.

---

## 10. Train/Test Split

~~~python
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X,                                  # Input features
    y,                                  # Class labels
    test_size=0.20,                     # Reserve 20% for testing
    random_state=42,                    # Make split reproducible
    stratify=y                          # Preserve class proportions
)
~~~

Explain:
- X_train = training features
- X_test = unseen test features
- y_train = training labels
- y_test = correct test labels

Ask students:

> Why should we not train and test on the same rows?

Because we want to measure performance on unseen data.

---

## 11. Why Use Stratification?

stratify=y keeps approximately the same class proportions in training and test sets.

Ask students:

> Why is this useful when some fault classes are rare?

Clue: without stratification, a rare class may be poorly represented in one split.

---

## 12. Why Scale Features?

Different features have different numerical ranges.

Example:
- one variable may range from 0.1 to 0.9;
- another may range from 100 to 10,000.

Standardization:

z = (x - mean) / standard deviation

This helps many algorithms optimize more reliably.

---

## 13. Create the Pipeline

~~~python
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression

clf = Pipeline([
    ("scale", StandardScaler()),                  # Standardize inputs
    ("model", LogisticRegression(max_iter=3000))  # Create classifier
])
~~~

Why use a Pipeline?

It ensures that:
1. scaling is learned only from training data;
2. the same scaling is applied to test data;
3. preprocessing and modeling stay together.

---

## 14. Train the Model

~~~python
clf.fit(X_train, y_train)               # Learn patterns from training data
~~~

What does fit() do?

The classifier learns relationships between the 27 input features and the known fault classes.

Important:

The test set is not used for training.

---

## 15. Make Predictions

~~~python
y_pred = clf.predict(X_test)            # Predict a class for each test row
~~~

Compare actual and predicted:

~~~python
import pandas as pd

comparison = pd.DataFrame({
    "Actual": y_test,                   # Correct class
    "Predicted": y_pred                 # Model prediction
})

print(comparison.head(10))
~~~

---

## 16. Accuracy

Accuracy = correct predictions / total predictions

~~~python
from sklearn.metrics import accuracy_score

accuracy = accuracy_score(y_test, y_pred)

print("Accuracy:", accuracy)
~~~

Ask students:

> If accuracy = 0.78, what does it mean?

About 78% of test observations were classified correctly.

But accuracy does not tell us **which fault classes were missed**.

---

## 17. Confusion Matrix

~~~python
from sklearn.metrics import ConfusionMatrixDisplay

ConfusionMatrixDisplay.from_predictions(
    y_test,                             # Actual classes
    y_pred,                             # Predicted classes
    xticks_rotation=45                  # Rotate labels
)

plt.title("Steel Fault Classification")

plt.show()
~~~

How to read it:
- rows = actual classes;
- columns = predicted classes;
- diagonal = correct predictions;
- off-diagonal = errors.

Ask students:
- Which class appears easiest to classify?
- Which two classes are commonly confused?

---

## 18. True Positive, False Positive, False Negative

Focus on one class, for example Z_Scratch.

True positive:
- actual = Z_Scratch;
- predicted = Z_Scratch.

False positive:
- actual = another class;
- predicted = Z_Scratch.

False negative:
- actual = Z_Scratch;
- predicted = another class.

Engineering meaning:

A false negative means a real fault exists, but the model misses it.

---

## 19. Precision

Precision asks:

> Of all samples predicted as this fault, how many really were this fault?

Precision = TP / (TP + FP)

High precision means fewer false alarms.

Example:
- predicted defective = 20;
- actually defective = 18.

Precision = 18 / 20 = 0.90

---

## 20. Recall

Recall asks:

> Of all actual samples of this fault, how many did the model find?

Recall = TP / (TP + FN)

High recall means fewer missed faults.

Example:
- actual defects = 20;
- model detects = 15.

Recall = 15 / 20 = 0.75

---

## 21. Precision vs Recall

Ask students:

Case A: Missing a dangerous defect may cause failure.

Which metric becomes especially important?

**Recall**

Case B: Every false alarm stops an expensive production line.

Which metric may become especially important?

**Precision**

Key idea:

There is no single best metric. Engineering consequences determine what matters.

---

## 22. F1 Score

F1 combines precision and recall.

F1 = 2 × Precision × Recall / (Precision + Recall)

Use F1 when both false positives and false negatives matter.

---

## 23. Classification Report

~~~python
from sklearn.metrics import classification_report

print(
    classification_report(
        y_test,                         # True classes
        y_pred,                         # Predicted classes
        zero_division=0                 # Avoid divide-by-zero warnings
    )
)
~~~

The report includes:
- precision;
- recall;
- F1;
- support.

---

## 24. What Is Support?

Support means the number of actual test observations belonging to a class.

Example:

| Class | Support |
|---|---:|
| Z_Scratch | 38 |
| Bumps | 81 |

A metric based on very few observations should be interpreted carefully.

---

## 25. Macro vs Weighted Average

Macro average:
- every class receives equal weight.

Weighted average:
- common classes receive more influence.

Ask students:

> Which one better reveals weak performance on rare classes?

**Macro average**

---

## 26. Inspect Misclassified Samples

~~~python
results = X_test.copy()                 # Copy test features

results["Actual"] = y_test              # Add correct labels

results["Predicted"] = y_pred           # Add model predictions

errors = results[
    results["Actual"] != results["Predicted"]  # Keep incorrect rows
]

print(errors.head())
~~~

Ask students:

> Why should engineers inspect individual errors instead of only averages?

Because average metrics can hide important failure cases.

---

## 27. Prediction Probabilities

~~~python
probabilities = clf.predict_proba(X_test)   # Estimate class probabilities

print(probabilities[:3])
~~~

Each row contains a score for each possible class.

Important:

A high predicted probability does not automatically mean the probability is perfectly calibrated.

---

## 28. Common Student Questions

### Why is Logistic Regression used for classification?

Despite its name, it is commonly used as a classifier because it estimates class probabilities.

### Why don't we scale y?

y contains categories, not continuous numerical measurements.

### Why isn't accuracy enough?

Because it can hide poor performance on rare classes.

### Easy way to remember precision vs recall

Precision:

> When I predict a fault, how often am I right?

Recall:

> Of all real faults, how many did I find?

### Can the model predict a class it never saw during training?

No.

---

## 29. Guided Exercise 1

Find the most common fault class.

Clue:

~~~python
y.value_counts()
~~~

---

## 30. Guided Exercise 2

Find the least common fault class.

Clue:

Look at the bottom of the output from y.value_counts().

---

## 31. Guided Exercise 3

Find the class with the lowest recall.

Clue:

Look at the recall column in the classification report.

Ask:

> What does low recall mean physically?

It means many real examples of that fault class are being missed.

---

## 32. Guided Exercise 4

Identify two classes frequently confused by the model.

Clue:

Look for a large off-diagonal confusion-matrix cell.

---

## 33. Guided Exercise 5

Create a table containing only incorrect predictions.

Clue:

~~~python
results["Actual"] != results["Predicted"]
~~~

---

## 34. Quick Concept Check

### Question 1

If a model detects nearly every true fault but produces many false alarms, which metric is likely high?

Clue: think about finding actual positives.

### Question 2

If nearly every predicted fault is correct but many real faults are missed, which metric is likely high?

Clue: think about reliability of positive predictions.

### Question 3

Why might macro F1 be useful here?

Clue: think about rare classes.

---

## 35. MATLAB Equivalent

~~~matlab
% Standardize training data
mu = mean(Xtrain,1);
sigma = std(Xtrain,0,1);

XtrainScaled = (Xtrain - mu) ./ sigma;
XtestScaled  = (Xtest - mu) ./ sigma;

% Create logistic learner
learner = templateLinear( ...
    "Learner","logistic");

% Train multiclass classifier
model = fitcecoc( ...
    XtrainScaled, ...
    ytrain, ...
    "Learners",learner);

% Predict classes
ypred = predict(model,XtestScaled);

% Accuracy
accuracy = mean(ypred == ytest);

% Confusion matrix
confusionchart(ytest,ypred)
~~~

Python ↔ MATLAB:

| Python | MATLAB |
|---|---|
| train_test_split() | cvpartition() |
| StandardScaler() | mean/std standardization |
| LogisticRegression() | templateLinear("Learner","logistic") |
| Pipeline | preprocessing + fitcecoc() |
| fit() | fitcecoc() |
| predict() | predict() |
| ConfusionMatrixDisplay | confusionchart() |

---

## 36. Short Videos

### Classification overview
MathWorks — An Introduction to Classification  
https://www.mathworks.com/videos/an-introduction-to-classification-68891.html

### Logistic Regression
StatQuest — Logistic Regression  
https://www.youtube.com/watch?v=yIYKR4sgzI8

### Confusion Matrix
StatQuest — The Confusion Matrix  
https://www.youtube.com/watch?v=Kdsp6soqA7o

### MATLAB Classification
MathWorks — Classification Learner App  
https://www.mathworks.com/videos/classify-data-using-the-classification-learner-app-106171.html

---

## 37. Exit Questions

1. Why can accuracy be misleading?  
   Clue: class imbalance.

2. What is the difference between precision and recall?  
   Clue: predicted positives vs actual positives.

3. What is a false negative?  
   Clue: a real fault exists but the model misses it.

4. Why use stratification?  
   Clue: preserve class proportions.

5. Why scale input features?  
   Clue: features have different numerical ranges.

---

## 38. Final Takeaway

The complete classification workflow is:

**Engineering problem → dataset → class labels → class balance → train/test split → scaling → train model → predict → confusion matrix → precision/recall/F1 → inspect errors → engineering interpretation**

The important question is not:

> What accuracy did we get?

The better engineering question is:

> **Which faults are we missing, what kinds of errors are we making, and are those errors acceptable for this application?**

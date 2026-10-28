
# Week 8 Lecture Page — Classification for Engineering Decisions

**ESC 113: Computer Aided Analysis for Engineering**

---


## Background — Why Surface Defect Classification Matters

Steel is used in automobiles, buildings, machinery, transportation systems, appliances, and many other engineered products.

During manufacturing, the steel surface can develop different kinds of defects such as:

- scratches;
- stains;
- dirt or contamination;
- bumps;
- cracks or irregular marks;
- other surface abnormalities.

These defects may affect:

- appearance;
- corrosion resistance;
- fatigue strength;
- product quality;
- downstream manufacturing;
- customer acceptance.

### Reference visual — examples of steel surface defects

A useful visual reference showing examples such as seams, roll cracks, overfill, scratches, and heat cracks is available from the U.S. Department of Energy:

[View steel surface-defect examples — U.S. DOE](https://www1.eere.energy.gov/manufacturing/industries_technologies/sensors_automation/pdfs/meetings/0605/chang_0605.pdf)

Another useful background reference:

[Review of steel surface defect detection using machine vision](https://onlinelibrary.wiley.com/doi/full/10.1049/ipr2.12647)

Large-scale steel production can involve thousands of parts and repeated surface inspections. Manual inspection may be slow, inconsistent, and difficult to scale, which motivates **automated inspection**.

---


## Reference Pictures — What Do Real Surface Defects Look Like?

### Example 1 — Scratched steel surface

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Dark_grey_stainless_steel_heavily_scratched_worn_seamless_metal_surface_texture.jpg?width=700" width="520">

*Reference image: heavily scratched stainless-steel surface. Source: Wikimedia Commons.*

[Open image source and license](https://commons.wikimedia.org/wiki/File:Dark_grey_stainless_steel_heavily_scratched_worn_seamless_metal_surface_texture.jpg)

### Key visual features

- scratches create visible directional patterns;
- surface appearance contains useful geometric information;
- a computer can describe these patterns numerically using features such as orientation, area, perimeter, and luminosity.

---

### Example 2 — Real steel defect: blowhole

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Foundry_defect_blowhole.jpg?width=700" width="520">

*Reference image: a blowhole casting defect exposed in a steel lathe face plate. Source: Wikimedia Commons, public domain.*

[Open image source and description](https://commons.wikimedia.org/wiki/File:Foundry_defect_blowhole.jpg)

Not every steel defect looks like a scratch.

Different manufacturing defects can have very different:

- shapes;
- textures;
- sizes;
- locations;
- brightness patterns.

This is one reason why classification based on multiple features can be useful.

---

### Example 3 — Normal steel surface reference

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Metal_steel_surface.jpg?width=700" width="520">

*Reference image: general steel surface texture. Source: Wikimedia Commons, public domain.*

[Open image source and license](https://commons.wikimedia.org/wiki/File:Metal_steel_surface.jpg)

> What visual differences do you notice between a relatively uniform steel surface and a scratched or defective surface?

Possible answers:

- texture;
- directionality;
- roughness;
- contrast;
- local dark or bright areas;
- irregular geometry.

These visual differences can become numerical **features** for a machine-learning classifier.

---

## Why Use Machine Learning Classification in Engineering?

Traditional engineering rules are very useful when the decision boundary is simple.

Example:

> If temperature > 100°C → Warning

But many real engineering problems depend on several measurements at the same time.

For a surface fault, the decision may depend on:

- size;
- location;
- shape;
- perimeter;
- luminosity;
- orientation;
- plate thickness;
- combinations of several variables.

It may be difficult to write one simple rule that separates seven different fault types.

Machine learning can learn patterns from previously labeled examples.

### Engineering idea

Instead of writing:

> “If X > this AND Y < that AND luminosity > something…”

we give the model many examples of known faults and let it learn a classification rule.

### Reference visual — automated manufacturing inspection

MathWorks provides examples of automated visual inspection and defect detection in manufacturing:

[Automated Visual Inspection with AI — MathWorks](https://www.mathworks.com/campaigns/offers/next/automated-visual-inspection-with-deep-learning.html)

[Manufacturing Analytics and Defect Detection — MathWorks](https://www.mathworks.com/discovery/manufacturing-analytics.html)

---

## From Physical Defect to Machine-Learning Decision

~~~mermaid
flowchart LR
    A[Steel surface] --> B[Sensor / camera measurement]
    B --> C[Extract measurable features]
    C --> D[Machine-learning classifier]
    D --> E[Predicted fault class]
    E --> F[Engineer / quality-control decision]
~~~

### Examples of measured features

A defect itself is physical.

The computer cannot directly understand the word “scratch.”

We first represent the defect using numbers such as:

- position;
- width;
- height;
- pixel area;
- perimeter;
- brightness;
- orientation.

These numerical measurements become the **features** used by the classifier.

---

## Classification Is Not the Final Engineering Decision

A machine-learning model predicts a class.

For example:

> Predicted class = Z_Scratch

But an engineer may still need to decide:

- Is the defect acceptable?
- Should the part be rejected?
- Should the production line stop?
- Should the part receive additional inspection?
- Is maintenance required?

~~~mermaid
flowchart LR
    A[Measured data] --> B[ML classification]
    B --> C[Predicted fault type]
    C --> D[Engineering standards + context]
    D --> E[Accept / inspect / reject / repair]
~~~

### Important distinction

**Classification:** What type of pattern does the model think this is?

**Engineering disposition:** What action should be taken?

These are not always the same question.

---

## Why Not Just Use Human Inspection?

Human inspection is still important, but automated classification can help when:

- production volume is very large;
- inspection must happen quickly;
- faults are subtle;
- consistent decisions are required;
- many measurements must be considered simultaneously;
- continuous monitoring is needed.

Machine learning does **not** eliminate the engineer.

It can provide a fast decision-support tool.

---

## Why Classification Instead of Regression Here?

Our target is not:

> “How many millimeters?”

or

> “How many MPa?”

Instead, our target is a category:

~~~text
Pastry
Z_Scratch
K_Scatch
Stains
Dirtiness
Bumps
Other_Faults
~~~

Therefore:

> **categorical target → classification**

---

## Visual Summary — Regression vs Classification

~~~mermaid
flowchart TD
    A[What do we want to predict?] --> B{Target type}
    B -->|Continuous number| C[Regression]
    B -->|Category / label| D[Classification]
    C --> E[Example: power output = 452.8 MW]
    D --> F[Example: fault type = Z_Scratch]
~~~

---

## Classification Workflow for This Lecture

~~~mermaid
flowchart LR
    A[Steel fault data] --> B[Inspect features and classes]
    B --> C[Train / test split]
    C --> D[Scale features]
    D --> E[Train classifier]
    E --> F[Predict test classes]
    F --> G[Confusion matrix]
    G --> H[Precision / Recall / F1]
    H --> I[Engineering interpretation]
~~~

This is the roadmap for the rest of the lecture.

---


## Reference Picture — Confusion Matrix

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Multi_Category_Confusion_Matrix.png?width=520" width="430">

*Reference image: multicategory confusion matrix showing true positives, false positives, false negatives, and true negatives. Source: Wikimedia Commons, CC0.*

[Open image source and license](https://commons.wikimedia.org/wiki/File:Multi_Category_Confusion_Matrix.png)

### How to interpret the image

- diagonal cells represent correct classifications;
- off-diagonal cells represent classification errors;
- false positives and false negatives depend on which class is being treated as the class of interest.

---

## Visual Guide — Confusion Matrix Idea

Before seeing the seven-class confusion matrix, understand the basic idea with a two-class example.

|  | Predicted Fault | Predicted Normal |
|---|---:|---:|
| **Actual Fault** | True Positive | False Negative |
| **Actual Normal** | False Positive | True Negative |

~~~mermaid
flowchart TD
    A[Actual Fault] --> B{Model prediction}
    B -->|Fault| C[True Positive: detected correctly]
    B -->|Normal| D[False Negative: real fault missed]
    E[Actual Normal] --> F{Model prediction}
    F -->|Fault| G[False Positive: false alarm]
    F -->|Normal| H[True Negative: correct normal decision]
~~~

### Engineering interpretation

For manufacturing:

- **False negative:** a real defect is missed.
- **False positive:** a good part is flagged as defective.

Both can be costly, but in different ways.

---


## Reference Picture — Accuracy, Precision, Recall, and Specificity

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Confusion_Matrix_Metrics.png?width=560" width="450">

*Reference image: confusion-matrix metrics including accuracy, precision, sensitivity/recall, and specificity. Source: Wikimedia Commons.*

[Open image source and license](https://commons.wikimedia.org/wiki/File:Confusion_Matrix_Metrics.png)

Use this picture as a visual summary after students learn the individual formulas.

---

## Visual Guide — Precision vs Recall

~~~mermaid
flowchart LR
    A[PRECISION] --> B[Look at everything predicted as Fault]
    B --> C[How many predictions were correct?]

    D[RECALL] --> E[Look at every real Fault]
    E --> F[How many did the model find?]
~~~

### Memory trick

**Precision**

> “When the model says FAULT, how often is it right?”

**Recall**

> “Of all the real FAULTS, how many did it find?”

---


## 1. Main Engineering Question

> Can we classify the type of surface fault on a steel plate using measured geometric and image-based features?

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

The seven fault classes do not necessarily occur equally often. This introduces the concept of **class imbalance**.

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


A 90% accuracy value can still hide complete failure on a minority fault class. This is why classification needs more than one metric.

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


Training and testing should use separate observations so performance is measured on unseen data.

---

## 11. Why Use Stratification?

stratify=y keeps approximately the same class proportions in training and test sets.


Stratification is especially useful when some classes are rare because it helps preserve class proportions across training and test sets.

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


If accuracy = 0.78, about 78% of test observations were classified correctly.

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

## 34. Quick Concept Review

### Scenario 1

If a model detects nearly every true fault but produces many false alarms, **recall** is likely high while precision may be lower.

### Scenario 2

If nearly every predicted fault is correct but many real faults are missed, **precision** is likely high while recall may be lower.

### Scenario 3

Macro F1 is useful when rare classes matter because it gives each class equal weight.

---


## MATLAB Usage Help

For step-by-step MATLAB instructions written for BMCC students, see:

[MATLAB Usage Instructions for BMCC Students](MATLAB_Usage_Instructions_BMCC.md)

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

## 37. Summary Questions

1. Why can accuracy be misleading in an imbalanced dataset?
2. What is the difference between precision and recall?
3. What is a false negative?
4. Why is stratification useful?
5. Why are input features scaled before logistic regression?

---

## 38. Final Takeaway

The complete classification workflow is:

**Engineering problem → dataset → class labels → class balance → train/test split → scaling → train model → predict → confusion matrix → precision/recall/F1 → inspect errors → engineering interpretation**

The important question is not:

> What accuracy did we get?

The better engineering question is:

> **Which faults are we missing, what kinds of errors are we making, and are those errors acceptable for this application?**

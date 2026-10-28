
# Week 8 Lecture Page — Classification for Engineering Decisions

**ESC 113: Computer Aided Analysis for Engineering**

---


## Python and MATLAB in This Chapter

The classification concepts are the same in both programming environments. Students should understand the **engineering workflow first**, then see how Python and MATLAB implement the same steps.

### Python

Python is used through **Google Colab/Jupyter Notebook** with libraries such as:

- `pandas` for tabular data;
- `NumPy` for numerical arrays;
- `scikit-learn` for train/test splitting, scaling, classification, and evaluation;
- `Matplotlib` for plots.

In Python, the Week 8 workflow uses tools such as:

```python
train_test_split(...)
StandardScaler()
LogisticRegression(...)
confusion_matrix(...)
classification_report(...)
```

The Python lecture is organized as small notebook cells with text, code, output, and interpretation.

### MATLAB

MATLAB is used through **MATLAB Online/Desktop and the Live Editor**. The equivalent workflow uses functions from the Statistics and Machine Learning Toolbox.

Important Week 8 MATLAB functions include:

```matlab
cvpartition(...)
mean(...)
std(...)
templateLinear(...)
fitcecoc(...)
predict(...)
confusionchart(...)
confusionmat(...)
```

The MATLAB lecture is also organized as small notebook-style steps so students can read an explanation, run a short code section, inspect the result, and continue.

### Same Engineering Workflow

| Engineering step | Python | MATLAB |
|---|---|---|
| Store numerical data | NumPy / pandas | arrays / tables |
| Train/test split | `train_test_split` | `cvpartition` |
| Standardization | `StandardScaler` | training mean and standard deviation |
| Multiclass classifier | `LogisticRegression` | `templateLinear` + `fitcecoc` |
| Prediction | `model.predict(...)` | `predict(model,...)` |
| Confusion matrix | `confusion_matrix` | `confusionmat` |
| Confusion-matrix display | Matplotlib / display tools | `confusionchart` |
| Precision, recall, F1 | `classification_report` | calculated from confusion matrix |

The code syntax is different, but the reasoning is the same:

```text
engineering problem
        ↓
features and target
        ↓
train/test split
        ↓
preprocessing
        ↓
train classifier
        ↓
predict
        ↓
evaluate
        ↓
engineering interpretation
```

---

## Machine Learning Background

### What Is Machine Learning?

Machine learning is a method that allows a computer to learn patterns from data and use those patterns to make predictions or decisions.

Instead of writing every decision rule manually, we provide:

- input data;
- known examples;
- a learning algorithm.

The algorithm learns a model that can then be applied to new data.

~~~mermaid
flowchart LR
    A[Engineering data] --> B[Machine-learning algorithm]
    B --> C[Learned model]
    C --> D[Prediction on new data]
~~~

### Machine Learning in Engineering

Machine learning is used in many engineering areas, including:

- predictive maintenance;
- manufacturing quality control;
- energy prediction;
- structural monitoring;
- biomedical signals;
- transportation systems;
- battery health;
- fault diagnosis;
- sensor analysis;
- process optimization.

The purpose is not to replace engineering principles. Machine learning is used to support engineering analysis when patterns are difficult to describe using simple rules alone.

---

## Supervised Learning

In **supervised learning**, the training data contain both:

- input features;
- known target values.

The model learns the relationship between the inputs and the target.

Examples:

| Inputs | Target |
|---|---|
| Temperature, pressure, humidity | Power output |
| Cement, water, age | Concrete strength |
| Vibration, temperature, current | Machine condition |
| Image-based fault features | Fault type |

Supervised learning is commonly divided into two major types:

1. **Regression**
2. **Classification**

---

## Regression

Regression is used when the target is a **continuous numerical value**.

Examples:

- power output in MW;
- concrete strength in MPa;
- temperature in °C;
- battery capacity;
- energy consumption;
- displacement or stress.

Example:

~~~text
Inputs:
Ambient Temperature
Pressure
Humidity

Target:
Electrical Power Output = 452.8 MW
~~~

In Week 7, regression was used to predict the electrical output of a combined-cycle power plant.

### Regression workflow

~~~mermaid
flowchart LR
    A[Input features] --> B[Regression model]
    B --> C[Continuous numerical prediction]
    C --> D[Example: 452.8 MW]
~~~

---

## Classification

Classification is used when the target is a **category or class label**.

Examples:

- Healthy / Faulty;
- Pass / Fail;
- Safe / Unsafe;
- Normal / Warning / Critical;
- defect type;
- equipment state.

Example:

~~~text
Inputs:
Vibration
Temperature
Current

Target:
Machine Condition = Faulty
~~~

### Classification workflow

~~~mermaid
flowchart LR
    A[Input features] --> B[Classification model]
    B --> C[Class prediction]
    C --> D[Example: Faulty]
~~~

---

## Regression vs Classification

| Question | Regression | Classification |
|---|---|---|
| What is predicted? | Numerical value | Category |
| Example target | 452.8 MW | Faulty |
| Output type | Continuous | Discrete class |
| Week in this course | Week 7 | Week 8 |

### Simple rule

> **Number → Regression**

> **Category → Classification**

---

## Connection Between Week 7 and Week 8

Week 7 and Week 8 use the same basic supervised-learning workflow:

~~~mermaid
flowchart LR
    A[Define engineering problem] --> B[Load data]
    B --> C[Select X and y]
    C --> D[Train / test split]
    D --> E[Train model]
    E --> F[Make predictions]
    F --> G[Evaluate performance]
    G --> H[Engineering interpretation]
~~~

The main difference is the type of target.

### Week 7

~~~text
Target = Net Electrical Output
Example = 452.8 MW
→ Regression
~~~

### Week 8

~~~text
Target = Fault Type
Example = Z_Scratch
→ Classification
~~~

This distinction is one of the most important ideas in introductory machine learning.

---

## Why Classification Is Important in Engineering

Many engineering problems are not asking for a numerical value.

Instead, the engineer needs to decide **which condition, state, category, or fault type is present**.

Examples include:

| Engineering problem | Possible classes |
|---|---|
| Machine condition monitoring | Healthy / Warning / Fault |
| Bearing diagnosis | Normal / Worn / Damaged |
| Structural monitoring | Safe / Inspect / Critical |
| Manufacturing quality control | Accept / Reject |
| Weld inspection | Good / Porosity / Crack / Incomplete fusion |
| Battery monitoring | Normal / Degraded / Failure risk |
| Electrical fault diagnosis | Normal / Short circuit / Open circuit / Ground fault |
| Traffic monitoring | Low / Moderate / Heavy congestion |
| Medical engineering | Normal / Abnormal signal |
| Surface inspection | Scratch / Stain / Bump / Other defect |

These are **classification problems** because the desired output is a category rather than a continuous numerical quantity.

---

## Why Engineers Use Machine Learning Classification

Simple engineering decisions can often be made using fixed rules.

For example:

```text
If temperature > 100°C → Warning
```

or:

```text
If pressure > safety limit → Shut down
```

These rules work well when the relationship between measurements and the decision is simple and well understood.

Real engineering systems can be much more complicated.

A machine condition may depend simultaneously on:

- temperature;
- pressure;
- vibration;
- current;
- rotational speed;
- acoustic measurements;
- operating load;
- environmental conditions.

A manufacturing defect may depend on:

- shape;
- size;
- location;
- brightness;
- orientation;
- edge characteristics;
- multiple interacting measurements.

Writing one fixed rule for every possible combination can become difficult.


## Complex Engineering Dependency — Why One Threshold May Not Be Enough


### Reference picture — condition monitoring on a motor

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Wi-care_sensor_on_reciprocating_motor.png?width=700" width="520">

*Wireless vibration sensor mounted on a reciprocating motor. Source: Wikimedia Commons, CC BY-SA 4.0.* citeturn668176search1

[Open image source and license](https://commons.wikimedia.org/wiki/File:Wi-care_sensor_on_reciprocating_motor.png)

This picture shows how a real engineering system can be instrumented with sensors. In practice, multiple measurements such as vibration, temperature, current, speed, load, and pressure can be combined to estimate the machine condition.


A real machine condition may depend on several measurements **at the same time**.

~~~mermaid
flowchart LR

    A1[Vibration level] --> M[Machine condition]
    A2[Bearing temperature] --> M
    A3[Motor current] --> M
    A4[Rotational speed] --> M
    A5[Mechanical load] --> M
    A6[Pressure] --> M
    A7[Acoustic signal] --> M
    A8[Operating time] --> M

    M --> C1[Healthy]
    M --> C2[Warning]
    M --> C3[Fault]

    A5 --> A1
    A4 --> A1
    A5 --> A3
    A4 --> A3
    A6 --> A2
    A8 --> A2
~~~

The relationships are not necessarily independent.

For example:

- increasing **mechanical load** can increase vibration;
- rotational speed can change both vibration and motor current;
- higher pressure can increase temperature;
- long operating time can change bearing temperature;
- the same vibration level may be normal at one speed but abnormal at another speed.

Therefore, a simple rule such as:

~~~text
IF vibration > threshold → Fault
~~~

may be insufficient.

A more realistic decision may depend on a combination such as:

~~~text
Vibration + Temperature + Current + Speed + Load + Pressure
                          ↓
                 Machine Condition
~~~

Machine-learning classification can learn these **multivariable relationships** from labeled operating data.

### Example

Consider two operating conditions:

| Measurement | Machine A | Machine B |
|---|---:|---:|
| Vibration | 6.0 mm/s | 6.0 mm/s |
| Temperature | 55°C | 92°C |
| Motor current | 12 A | 19 A |
| Load | 45% | 95% |
| Speed | 1200 rpm | 1800 rpm |
| Possible condition | Normal/Warning | Fault |

Both machines have the **same vibration value**, but the complete operating conditions are very different.

This illustrates why engineering classification often requires several features instead of a single threshold.

---

Machine learning classification learns patterns from **previously labeled examples**.

---

## Rule-Based Decision vs Machine-Learning Classification

### Rule-based approach

The engineer manually specifies the decision rule.

~~~text
IF vibration > threshold
AND temperature > threshold
THEN classify as Fault
~~~

This works well when the thresholds and relationships are known.

### Machine-learning approach

The model is given many examples containing:

~~~text
Measured features + known class
~~~

and learns a statistical decision rule from those examples.

~~~mermaid
flowchart LR
    A[Measured engineering data] --> B[Known class labels]
    A --> C[Machine-learning algorithm]
    B --> C
    C --> D[Learned classifier]
    D --> E[Class prediction for new data]
~~~

---

## When Classification Is Useful

Classification is particularly useful when:

- the output is naturally categorical;
- several measurements influence the decision;
- simple thresholds are not sufficient;
- patterns overlap;
- large amounts of labeled historical data are available;
- decisions must be made repeatedly or automatically;
- consistency is important.

Classification is commonly used for:

- fault diagnosis;
- predictive maintenance;
- quality inspection;
- anomaly categorization;
- equipment-state identification;
- sensor-state classification;
- image-based defect detection;
- signal classification.

---

## Classification vs Regression

The first question is always:

> **What type of output are we trying to predict?**

~~~mermaid
flowchart TD
    A[Engineering prediction problem] --> B{Target type}
    B -->|Continuous numerical value| C[Regression]
    B -->|Category or class label| D[Classification]
    C --> E[Power = 452.8 MW]
    C --> F[Strength = 42.1 MPa]
    D --> G[Machine = Faulty]
    D --> H[Defect = Scratch]
~~~

| Target | Example | Method |
|---|---|---|
| Continuous number | Temperature = 85.4°C | Regression |
| Continuous number | Power = 452.8 MW | Regression |
| Category | Healthy / Faulty | Classification |
| Category | Pass / Fail | Classification |
| Category | Fault type | Classification |

A target stored as numbers such as 0, 1, and 2 is still a classification target if those numbers represent categories.

---

## Binary and Multiclass Classification

### Binary classification

There are two possible classes.

Examples:

- Pass / Fail
- Healthy / Faulty
- Safe / Unsafe
- Normal / Abnormal

### Multiclass classification

There are more than two possible classes.

Examples:

- Normal / Warning / Critical
- Bearing Normal / Worn / Damaged
- Several different manufacturing defect types

Week 8 uses a **multiclass** engineering problem.

---

## Why Classification Errors Matter in Engineering

A classification model can make different types of mistakes.

For a simple Fault / Normal system:

| Reality | Prediction | Meaning |
|---|---|---|
| Fault | Fault | Correct fault detection |
| Normal | Normal | Correct normal classification |
| Normal | Fault | False alarm |
| Fault | Normal | Missed fault |

A **missed fault** may allow a defective component to continue operating.

A **false alarm** may unnecessarily stop production or trigger inspection.

The relative importance of these errors depends on the engineering application.

This is why classification cannot be evaluated using accuracy alone.

---

## Classification Is a Decision-Support Tool

A machine-learning classifier predicts a class.

It does not automatically make the final engineering decision.

~~~mermaid
flowchart LR
    A[Sensors / measurements] --> B[ML classifier]
    B --> C[Predicted condition]
    C --> D[Engineering limits + standards + context]
    D --> E[Final action]
~~~

Possible final actions include:

- continue operation;
- inspect;
- repair;
- reject;
- shut down;
- collect more data.

Engineering judgment remains essential.

---

## Engineering Classification Workflow

~~~mermaid
flowchart LR
    A[Engineering problem] --> B[Collect labeled data]
    B --> C[Define features and target]
    C --> D[Inspect class balance]
    D --> E[Train / test split]
    E --> F[Preprocess features]
    F --> G[Train classifier]
    G --> H[Predict unseen data]
    H --> I[Evaluate errors]
    I --> J[Engineering interpretation]
~~~

This general workflow will now be demonstrated using a manufacturing quality-control problem.

---

# Case Study — Steel Surface Fault Classification

Steel is widely used in:

- automobiles;
- buildings;
- machinery;
- transportation systems;
- appliances;
- industrial equipment.

During manufacturing, steel surfaces can develop defects such as:

- scratches;
- stains;
- bumps;
- contamination;
- irregular marks;
- other surface abnormalities.

Defects may affect:

- appearance;
- corrosion resistance;
- fatigue performance;
- downstream manufacturing;
- product acceptance;
- overall quality.

Large-scale production can involve thousands of parts and repeated inspections. Automated classification can support faster and more consistent quality control.

---

## Reference Pictures — Steel Surface Examples

### Scratched steel surface

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Dark_grey_stainless_steel_heavily_scratched_worn_seamless_metal_surface_texture.jpg?width=700" width="520">

*Reference image: heavily scratched stainless-steel surface. Source: Wikimedia Commons.*

[Image source and license](https://commons.wikimedia.org/wiki/File:Dark_grey_stainless_steel_heavily_scratched_worn_seamless_metal_surface_texture.jpg)

Directional scratch patterns can be represented numerically using features describing orientation, area, perimeter, and luminosity.

---

### Steel casting defect

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Foundry_defect_blowhole.jpg?width=700" width="520">

*Reference image: blowhole casting defect. Source: Wikimedia Commons, public domain.*

[Image source and description](https://commons.wikimedia.org/wiki/File:Foundry_defect_blowhole.jpg)

Different defects can have different shapes, textures, sizes, locations, and brightness patterns.

---

### General steel surface texture

<img src="https://commons.wikimedia.org/wiki/Special:Redirect/file/Metal_steel_surface.jpg?width=700" width="520">

*Reference image: steel surface texture. Source: Wikimedia Commons, public domain.*

[Image source and license](https://commons.wikimedia.org/wiki/File:Metal_steel_surface.jpg)

Differences in texture, roughness, contrast, geometry, and direction can be converted into numerical features for a classifier.

---

## From Physical Defect to Numerical Features

A computer does not directly understand words such as “scratch” or “stain.”

The physical defect must first be represented numerically.

~~~mermaid
flowchart LR
    A[Physical steel defect] --> B[Image / sensor]
    B --> C[Measure geometry and appearance]
    C --> D[Numerical features]
    D --> E[Classifier]
    E --> F[Predicted defect class]
~~~

Useful feature types include:

- position;
- width;
- height;
- area;
- perimeter;
- brightness;
- orientation;
- plate thickness.

These become the inputs to the classification model.

---

## Why This Case Study Uses Classification

The desired output is a fault category such as:

~~~text
Pastry
Z_Scratch
K_Scatch
Stains
Dirtiness
Bumps
Other_Faults
~~~


### Meaning of the Seven Fault Classes

| Class | Description |
|---|---|
| `Pastry` | A named steel-surface fault category in the dataset. UCI does not provide a detailed physical definition for this label. |
| `Z_Scratch` | A scratch-type surface defect classified as the Z-scratch category. |
| `K_Scatch` | Another scratch-type defect category. The dataset uses the spelling `K_Scatch`. |
| `Stains` | Surface regions with stain-like marks or discoloration. |
| `Dirtiness` | Surface regions showing contamination, dirt, or dirty-looking appearance. |
| `Bumps` | Raised or bump-like surface irregularities. |
| `Other_Faults` | Faults that do not belong to the six named categories above. |

These are the **target classes** that the machine-learning model is trying to predict.

For one steel-surface fault observation:

~~~text
Input  = 27 measured features
Output = one of the 7 fault classes
~~~

The goal of the classifier is therefore to learn how combinations of location, size, shape, brightness, orientation, and plate-related features are associated with these fault categories.



The output is categorical rather than continuous.

Therefore this is a **multiclass classification problem**.

---

## 1. Main Engineering Question

> Can we classify the type of surface fault on a steel plate using measured geometric and image-based features?

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


If numerical codes such as 0, 1, and 2 represent categories, the problem is still classification.

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


One row represents one detected fault instance, not an entire steel plate.

---

## 5. Understanding the 27 Input Features

The model receives **27 numerical input features** for each detected steel-surface fault.

These features describe:

- where the defect is located;
- how large it is;
- its shape;
- its perimeter and edges;
- how bright or dark it appears;
- the steel type and plate thickness;
- several image-derived indices.

> **Important:** The UCI repository provides the official feature names, but it does not provide detailed physical definitions or units for most variables. The explanations below are practical interpretations of the variable names so that the features are easier to understand.

### A. Defect Location

| Feature | Meaning |
|---|---|
| `X_Minimum` | Leftmost horizontal position of the detected defect |
| `X_Maximum` | Rightmost horizontal position of the detected defect |
| `Y_Minimum` | Lowest/start vertical position of the detected defect |
| `Y_Maximum` | Highest/end vertical position of the detected defect |

These four values describe the **bounding box** around the fault.

~~~text
Y_Maximum
    ┌───────────────┐
    │    DEFECT     │
    └───────────────┘
Y_Minimum

X_Minimum         X_Maximum
~~~

From these values, the defect width and height can be related to:

~~~text
Width  ≈ X_Maximum - X_Minimum
Height ≈ Y_Maximum - Y_Minimum
~~~

---

### B. Defect Size and Boundary

| Feature | Meaning |
|---|---|
| `Pixels_Areas` | Number of image pixels belonging to the defect; a measure of defect area |
| `X_Perimeter` | Horizontal contribution to the defect boundary |
| `Y_Perimeter` | Vertical contribution to the defect boundary |

A larger `Pixels_Areas` value generally corresponds to a larger detected region in the image.

The perimeter variables help describe whether a defect is:

- compact;
- long and narrow;
- irregular;
- stretched mostly horizontally or vertically.

---

### C. Brightness / Luminosity

| Feature | Meaning |
|---|---|
| `Sum_of_Luminosity` | Total brightness intensity across the defect region |
| `Minimum_of_Luminosity` | Darkest pixel intensity in the defect |
| `Maximum_of_Luminosity` | Brightest pixel intensity in the defect |
| `Luminosity_Index` | Derived index describing overall brightness characteristics |

In a grayscale image:

~~~text
darker pixel  → lower intensity
brighter pixel → higher intensity
~~~

Brightness can help distinguish defects because scratches, stains, bumps, and other surface irregularities may reflect light differently.

---

### D. Production / Steel Information

| Feature | Meaning |
|---|---|
| `Length_of_Conveyer` | Conveyor-system length or related production-line dimension recorded with the observation |
| `TypeOfSteel_A300` | Indicator showing whether the steel belongs to the A300 category |
| `TypeOfSteel_A400` | Indicator showing whether the steel belongs to the A400 category |
| `Steel_Plate_Thickness` | Thickness of the steel plate |

The two steel-type variables act like **yes/no indicator variables**.

For example:

~~~text
TypeOfSteel_A300 = 1 → A300 category
TypeOfSteel_A300 = 0 → not A300
~~~

Steel type and thickness can influence how surface defects appear and how they should be interpreted.

---

### E. Shape Indices

| Feature | Meaning |
|---|---|
| `Edges_Index` | Derived measure related to the defect's position or edge characteristics |
| `Empty_Index` | Measure of how much empty space exists inside the defect's bounding region |
| `Square_Index` | Measure of how square-like the defect shape is |
| `Outside_X_Index` | Derived horizontal size/position measure |
| `Outside_Global_Index` | Derived indicator describing the defect's overall outside orientation or extent |

These are **engineered features** calculated from the original image geometry.

They are not direct measurements such as temperature or pressure.

Instead, they summarize the **shape of the defect** in a way a machine-learning model can use.

---

### F. Edge Direction Features

| Feature | Meaning |
|---|---|
| `Edges_X_Index` | Measure of how strongly the defect extends or changes in the horizontal direction |
| `Edges_Y_Index` | Measure of how strongly the defect extends or changes in the vertical direction |
| `Orientation_Index` | Derived measure describing the overall orientation of the defect |

These features can help distinguish shapes such as:

~~~text
Horizontal defect:  ─────────

Vertical defect:       │
                       │
                       │

Compact defect:       ●
~~~

A long scratch may have a very different orientation pattern from a compact stain or bump.

---

### G. Log-Transformed Size Features

| Feature | Meaning |
|---|---|
| `LogOfAreas` | Logarithmic transformation of defect area |
| `Log_X_Index` | Log-transformed horizontal size/index |
| `Log_Y_Index` | Log-transformed vertical size/index |

Why use a logarithm?

Defect sizes may vary greatly.

For example:

~~~text
Area = 10
Area = 100
Area = 1000
Area = 10000
~~~

A logarithmic transformation compresses a large numerical range:

~~~text
log10(10)    = 1
log10(100)   = 2
log10(1000)  = 3
log10(10000) = 4
~~~

This can make large differences easier for a statistical model to handle.

---

### H. Sigmoid-Based Area Feature

| Feature | Meaning |
|---|---|
| `SigmoidOfAreas` | Area-related feature transformed using a sigmoid-type mathematical function |

A sigmoid transformation converts a wide numerical range into a more compressed nonlinear scale.

Conceptually:

~~~text
very small values  → near one end
medium values      → transition region
very large values  → near the other end
~~~

The important idea is that this is **not a new physical measurement**. It is a transformed version of geometric information.

---

## Feature Groups at a Glance

| Group | Example features | What they describe |
|---|---|---|
| Location | X_Minimum, X_Maximum, Y_Minimum, Y_Maximum | Where the fault is |
| Size | Pixels_Areas | How large the fault is |
| Boundary | X_Perimeter, Y_Perimeter | Shape boundary |
| Brightness | Minimum/Maximum/Sum of Luminosity | How dark or bright it is |
| Material | TypeOfSteel_A300, TypeOfSteel_A400 | Steel category |
| Plate property | Steel_Plate_Thickness | Plate thickness |
| Shape | Square_Index, Empty_Index | Geometry |
| Direction | Edges_X_Index, Edges_Y_Index, Orientation_Index | Direction/orientation |
| Transformed size | LogOfAreas, Log_X_Index, Log_Y_Index | Compressed size information |
| Nonlinear transformed feature | SigmoidOfAreas | Nonlinear area representation |

---

## Why So Many Features?

Two defects can have the same area but still look very different.

For example:

~~~text
Defect A:
Large area
Horizontal
Dark
Long and narrow

Defect B:
Large area
Compact
Bright
Nearly square
~~~

If we used only `Pixels_Areas`, these defects might look similar to the model.

By combining location, size, shape, orientation, brightness, and material information, the classifier receives a much richer description of each fault.

This is the main idea behind **multivariable machine learning**:

> one feature gives part of the story; several features together provide a better description of the engineering condition.

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

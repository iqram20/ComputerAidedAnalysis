# Week 6 — Machine Learning Fundamentals and Data Preparation
## How to Use This Lecture Page

Work through the material the same way you would use a Colab notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB implementation**

This chapter introduces the same supervised-learning workflow used throughout the course, implemented in MATLAB.

## Machine Learning Workflow

```text
Engineering problem
        ↓
Collect data
        ↓
Define features X and target y
        ↓
Inspect and clean data
        ↓
Split into training and test sets
        ↓
Train model
        ↓
Predict unseen data
        ↓
Evaluate
        ↓
Engineering interpretation
```

---

## Features and Target

Suppose each row represents one operating condition.

```matlab
X = [1.2 20;
     1.4 25;
     1.6 30;
     1.8 35;
     2.0 40];        % Two input features

y = [10;
     12;
     15;
     18;
     21];            % Numerical target
```

`X` contains predictor variables.  
`y` contains the value the model should learn to predict.

Check dimensions:

```matlab
size(X)
size(y)
```

---

## Tables and Named Variables

Tables are useful because engineering variables can keep descriptive names.

```matlab
Temperature_C = [20;25;30;35;40];
Pressure_kPa = [100;110;120;130;140];
Power_kW = [10;12;15;18;21];

T = table(Temperature_C,Pressure_kPa,Power_kW);

head(T)
summary(T)
```

Select features and target:

```matlab
X = T{:,{'Temperature_C','Pressure_kPa'}};
y = T.Power_kW;
```

---

## Check Missing Data

```matlab
ismissing(T)
sum(ismissing(T))
```

Rows with missing values can be identified using:

```matlab
missingRows = any(ismissing(T),2);
```

A missing value should not be removed automatically without understanding why it is missing.

---

## Train/Test Split

A model should be evaluated using data that were not used for training.

```matlab
rng(42)                                      % Reproducible random split
cv = cvpartition(length(y),'HoldOut',0.20);

trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
Xtest = X(testIdx,:);
ytrain = y(trainIdx);
ytest = y(testIdx);
```

The training set is used to fit the model.

The test set is used to estimate performance on unseen observations.

---

## Reproducibility

```matlab
rng(42)
```

sets the random-number generator to a known state.

This serves the same purpose as:

```python
random_state=42
```

in many Python/scikit-learn functions.

---

## Data Leakage

Preprocessing parameters should be learned from the **training data**, not from the test data.

Example scaling:

```matlab
mu = mean(Xtrain,1);
sigma = std(Xtrain,0,1);

XtrainScaled = (Xtrain-mu)./sigma;
XtestScaled = (Xtest-mu)./sigma;
```

The same training mean and standard deviation are applied to the test data.

Incorrect approach:

```matlab
mu = mean([Xtrain;Xtest],1);
```

because test information has entered the training workflow.

---

## Baseline Model

A useful model should perform better than a simple baseline.

For regression, one baseline is the training-target mean.

```matlab
baselineValue = mean(ytrain);
baselinePred = repmat(baselineValue,size(ytest));

baselineMAE = mean(abs(ytest-baselinePred));
```

---

## Simple Regression Model

```matlab
model = fitlm(Xtrain,ytrain);
ypred = predict(model,Xtest);
```

Evaluate:

```matlab
MAE = mean(abs(ytest-ypred));
RMSE = sqrt(mean((ytest-ypred).^2));
```

---

## Regression vs Classification

Regression predicts a number:

```matlab
model = fitlm(X,y);
```

Example output:

```text
Power = 452.8 MW
```

Classification predicts a category:

```matlab
model = fitclinear(X,classLabels);
```

Example output:

```text
Machine condition = Fault
```

---

## Python and MATLAB Comparison

| Task | Python | MATLAB |
|---|---|---|
| Table | pandas DataFrame | table |
| First rows | `df.head()` | `head(T)` |
| Summary | `df.describe()` | `summary(T)` |
| Missing check | `df.isna().sum()` | `sum(ismissing(T))` |
| Split | `train_test_split` | `cvpartition` |
| Linear regression | `LinearRegression` | `fitlm` |
| Predict | `model.predict(X)` | `predict(model,X)` |

---

## Common Errors

- using the test set during preprocessing;
- forgetting to fix the random seed;
- confusing features with the target;
- training and testing on the same observations;
- reporting a metric without engineering interpretation.

---

## Practice

1. Create a table containing temperature, pressure, vibration, and machine status.
2. Identify which columns are features and which column is the target.
3. Create an 80/20 train/test split.
4. Calculate scaling parameters from training data only.
5. Fit a simple regression model.
6. Compare model MAE with a mean-value baseline.

---

## Required Toolbox

The machine-learning examples use the **Statistics and Machine Learning Toolbox**.

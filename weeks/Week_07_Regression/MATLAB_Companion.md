# Week 7 — Regression for Engineering Prediction
## How to Use This Lecture Page

Work through the material as a MATLAB Live Editor notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB implementation**

Regression predicts a continuous numerical engineering quantity.

The Week 7 case study predicts **net electrical output (MW)** from power-plant operating conditions.

## Variables

| Variable | Meaning |
|---|---|
| Ambient_Temperature_C | Ambient temperature |
| Exhaust_Vacuum_cmHg | Exhaust vacuum |
| Ambient_Pressure_mbar | Ambient pressure |
| Relative_Humidity_percent | Relative humidity |
| Net_Electrical_Output_MW | Target power output |

---

## Select Features and Target

Assume the data are stored in table `T`.

```matlab
featureNames = {
    'Ambient_Temperature_C'
    'Exhaust_Vacuum_cmHg'
    'Ambient_Pressure_mbar'
    'Relative_Humidity_percent'
};

X = T{:,featureNames};
y = T.Net_Electrical_Output_MW;
```

Check dimensions:

```matlab
size(X)
size(y)
```

---

## Explore Feature–Target Relationships

```matlab
scatter(T.Ambient_Temperature_C,y)
xlabel('Ambient Temperature (°C)')
ylabel('Net Electrical Output (MW)')
grid on
```

A scatter plot helps reveal whether a feature and target have an approximately linear, nonlinear, weak, or unusual relationship.

---

## Train/Test Split

```matlab
rng(42)

cv = cvpartition(length(y),'HoldOut',0.20);

trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
Xtest = X(testIdx,:);
ytrain = y(trainIdx);
ytest = y(testIdx);
```

The model learns from `Xtrain` and `ytrain`.

Final evaluation uses `Xtest` and `ytest`.

---

## Fit Multiple Linear Regression

```matlab
model = fitlm(Xtrain,ytrain);
```

View the fitted model:

```matlab
disp(model)
```

Make predictions:

```matlab
ypred = predict(model,Xtest);
```

---

## MAE

```matlab
MAE = mean(abs(ytest-ypred));
```

MAE is the average absolute prediction error.

If:

```text
MAE = 3.2 MW
```

the model is wrong by about 3.2 MW on average, ignoring direction.

---

## RMSE

```matlab
RMSE = sqrt(mean((ytest-ypred).^2));
```

RMSE gives more weight to large errors.

A large gap between RMSE and MAE can indicate some relatively large prediction errors.

---

## R²

```matlab
SS_res = sum((ytest-ypred).^2);
SS_tot = sum((ytest-mean(ytest)).^2);

R2 = 1 - SS_res/SS_tot;
```

R² is not “percent accuracy.”

It describes how much variation in the target is explained relative to a mean-based reference.

---

## Actual vs Predicted Plot

```matlab
scatter(ytest,ypred)
hold on

limits = [min(ytest) max(ytest)];
plot(limits,limits,'--')

hold off
xlabel('Actual Power Output (MW)')
ylabel('Predicted Power Output (MW)')
title('Actual vs Predicted')
grid on
```

Predictions close to the diagonal line are close to the measured values.

---

## Residuals

Define:

```text
Residual = Actual - Predicted
```

```matlab
residuals = ytest-ypred;

histogram(residuals)
xlabel('Residual (MW)')
ylabel('Count')
title('Residual Distribution')
grid on
```

Positive residual:

```text
Actual > Predicted
```

The model underpredicted.

Negative residual:

```text
Actual < Predicted
```

The model overpredicted.

---

## Largest Errors

```matlab
absoluteError = abs(residuals);

[sortedError,idx] = sort(absoluteError,'descend');

largestErrors = table( ...
    ytest(idx(1:10)), ...
    ypred(idx(1:10)), ...
    residuals(idx(1:10)), ...
    sortedError(1:10), ...
    'VariableNames',{'Actual','Predicted','Residual','AbsoluteError'});

disp(largestErrors)
```

Inspecting individual errors is important because average metrics can hide unusual operating conditions.

---

## Coefficients

```matlab
model.Coefficients
```

A regression coefficient describes the model's estimated change in output when that predictor changes while other predictors are held fixed.

A coefficient does not automatically prove causation.

---

## Single-Feature Model

Temperature-only model:

```matlab
temperatureModel = fitlm( ...
    T.Ambient_Temperature_C(trainIdx), ...
    ytrain);

tempPred = predict( ...
    temperatureModel, ...
    T.Ambient_Temperature_C(testIdx));
```

Compare its performance with the four-feature model.

This demonstrates whether additional operating variables improve prediction.

---

## MATLAB Workflow Summary

The examples in this chapter use MATLAB syntax throughout.

---

## Common Errors

- calling R² “accuracy”;
- reporting MAE without units;
- interpreting coefficients as causal effects;
- evaluating only training performance;
- ignoring residual patterns;
- using a model outside the operating range represented by training data.

---

## Practice

1. Fit a temperature-only linear model.
2. Fit a four-feature linear model.
3. Calculate MAE, RMSE, and R² for both.
4. Plot actual vs predicted values.
5. Plot residuals.
6. Identify the ten largest errors.
7. Explain which model would be more useful for engineering prediction and why.

---

## Required Toolbox

Statistics and Machine Learning Toolbox.


## Complete 3-Hour MATLAB Code Study

For extended self-paced practice, open:

[Week_07_3Hour_MATLAB_Code_Study.m](Week_07_3Hour_MATLAB_Code_Study.m)

The runnable study file contains detailed comments, visible outputs, engineering examples, guided practice, and review material. Run one `%%` section at a time in MATLAB Live Editor.

---

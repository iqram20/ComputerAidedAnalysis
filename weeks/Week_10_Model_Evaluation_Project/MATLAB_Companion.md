# Week 10 — Model Evaluation, Tuning, and Engineering ML Project
## How to Use This Lecture Page

Work through the material the same way you would use a Colab notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB implementation**

A model should not be selected using the final test set repeatedly. Week 10 separates model development from final evaluation.

## Data Roles

```text
Training data
    ↓
Fit model

Validation / cross-validation
    ↓
Choose model and hyperparameters

Test data
    ↓
Final unbiased evaluation
```

---

## Holdout Test Set

```matlab
rng(42)

cv = cvpartition(length(y),'HoldOut',0.20);

trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
ytrain = y(trainIdx);

Xtest = X(testIdx,:);
ytest = y(testIdx);
```

Do not use `Xtest` and `ytest` while tuning the model.

---

## Cross-Validation

```matlab
model = fitrensemble(Xtrain,ytrain);

cvModel = crossval(model,'KFold',5);

cvLoss = kfoldLoss(cvModel);
```

Five-fold cross-validation divides the training data into five subsets and rotates which subset is used for validation.

---

## Cross-Validated Predictions

```matlab
cvPred = kfoldPredict(cvModel);
```

These predictions can be used to inspect development performance without touching the final test set.

---

## Hyperparameters

Hyperparameters are model settings chosen before or during training.

For a tree, examples include:

- maximum number of splits;
- minimum leaf size.

For an ensemble:

- number of learning cycles;
- tree complexity;
- learning method.

---

## Automatic Hyperparameter Optimization

```matlab
modelTuned = fitrensemble( ...
    Xtrain, ...
    ytrain, ...
    'OptimizeHyperparameters','auto');
```

The optimization process should use only development/training information.

---

## Final Test Evaluation

After model selection:

```matlab
ypred = predict(modelTuned,Xtest);
```

Calculate metrics:

```matlab
MAE = mean(abs(ytest-ypred));

RMSE = sqrt(mean((ytest-ypred).^2));

R2 = 1 - ...
    sum((ytest-ypred).^2) / ...
    sum((ytest-mean(ytest)).^2);
```

---

## Actual vs Predicted

```matlab
scatter(ytest,ypred)
hold on

limits = [min(ytest) max(ytest)];
plot(limits,limits,'--')

hold off
xlabel('Actual')
ylabel('Predicted')
title('Final Test Performance')
grid on
```

---

## Residual Analysis

```matlab
residuals = ytest-ypred;

scatter(ypred,residuals)
yline(0,'--')
xlabel('Predicted')
ylabel('Residual')
title('Residuals vs Predicted')
grid on
```

Systematic residual patterns may indicate model limitations.

---

## Compare Candidate Models

```matlab
results = table( ...
    ["Linear";"Tree";"Ensemble"], ...
    [rmseLinear;rmseTree;rmseEnsemble], ...
    'VariableNames',{'Model','RMSE'});

disp(results)
```

Model choice should consider:

- test performance;
- stability;
- interpretability;
- computational cost;
- engineering plausibility.

---

## Overfitting and Underfitting

Underfitting:

```text
Training error high
Test error high
```

Overfitting:

```text
Training error very low
Test error much higher
```

A useful model generalizes to unseen engineering conditions represented by the data.

---

## Reproducibility

Record:

- random seed;
- dataset source;
- feature definitions;
- train/test method;
- preprocessing;
- model settings;
- software/toolbox requirements;
- evaluation metrics.

---

## Python and MATLAB Comparison

| Task | Python | MATLAB |
|---|---|---|
| Split | `train_test_split` | `cvpartition` |
| K-fold CV | `cross_val_score` / CV objects | `crossval` |
| Grid/tuning | `GridSearchCV` | `OptimizeHyperparameters` |
| Predict | `.predict()` | `predict` |
| MAE/RMSE/R² | sklearn metrics | direct formulas or evaluation functions |

---

## Engineering Project Reporting

A complete project should state:

1. engineering question;
2. dataset source;
3. meaning and units of features;
4. meaning of one observation;
5. preprocessing steps;
6. model-selection strategy;
7. final test metrics;
8. plots;
9. largest errors or failure cases;
10. limitations and assumptions;
11. engineering interpretation.

---

## Practice

1. Create a fixed test set.
2. Perform five-fold cross-validation on training data.
3. Compare at least two candidate models.
4. Tune one model without using the final test set.
5. Evaluate the selected model once on the test set.
6. Prepare a summary table and residual plot.
7. Write a short engineering interpretation of the errors.

---

## Required Toolbox

Statistics and Machine Learning Toolbox.

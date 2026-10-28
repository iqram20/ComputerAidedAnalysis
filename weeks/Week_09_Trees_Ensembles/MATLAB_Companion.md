# Week 9 — Decision Trees, Random Forests, and Feature Importance
## How to Use This Lecture Page

Work through the material the same way you would use a Colab notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB implementation**

Tree-based models can represent nonlinear relationships and interactions without requiring a single global linear equation.

## Decision Tree Idea

A tree repeatedly divides the feature space using rules such as:

```text
Is cement content < threshold?
        ↓
Yes / No
        ↓
Next split
        ↓
Prediction
```

---

## Fit a Regression Tree

```matlab
treeModel = fitrtree( ...
    Xtrain, ...
    ytrain, ...
    'MaxNumSplits',20);
```

Predict:

```matlab
ypredTree = predict(treeModel,Xtest);
```

Evaluate:

```matlab
treeMAE = mean(abs(ytest-ypredTree));
treeRMSE = sqrt(mean((ytest-ypredTree).^2));
```

---

## Visualize the Tree

```matlab
view(treeModel,'Mode','graph')
```

A shallow tree is easier to interpret.

A very deep tree can fit noise in the training data.

---

## Training vs Test Performance

```matlab
predTrain = predict(treeModel,Xtrain);

rmseTrain = sqrt(mean((ytrain-predTrain).^2));
rmseTest = sqrt(mean((ytest-ypredTree).^2));

fprintf('Training RMSE = %.3f\n',rmseTrain)
fprintf('Test RMSE = %.3f\n',rmseTest)
```

If training error is very small but test error is much larger, the tree may be overfitting.

---

## Tree Complexity

`MaxNumSplits` controls tree size.

```matlab
smallTree = fitrtree(Xtrain,ytrain,'MaxNumSplits',5);
largeTree = fitrtree(Xtrain,ytrain,'MaxNumSplits',100);
```

Comparing these models demonstrates the bias–variance tradeoff.

---

## Ensemble of Trees

A tree ensemble combines predictions from many trees.

```matlab
ensembleModel = fitrensemble( ...
    Xtrain, ...
    ytrain, ...
    'Method','Bag');
```

Predict:

```matlab
ypredEnsemble = predict(ensembleModel,Xtest);
```

Evaluate:

```matlab
ensembleRMSE = sqrt(mean((ytest-ypredEnsemble).^2));
```

Bagging reduces sensitivity to a single tree's training-data fluctuations.

---

## Compare Models

```matlab
comparison = table( ...
    treeRMSE, ...
    ensembleRMSE, ...
    'VariableNames',{'DecisionTree','Ensemble'});

disp(comparison)
```

A more complex model is not automatically better. Test performance and engineering usefulness matter.

---

## Feature Importance

Tree:

```matlab
importance = predictorImportance(treeModel);
```

Plot:

```matlab
bar(importance)
xlabel('Feature')
ylabel('Importance')
title('Tree Feature Importance')
grid on
```

If feature names are available:

```matlab
bar(categorical(featureNames),importance)
ylabel('Importance')
```

Feature importance identifies variables that contributed strongly to tree splits.

It does not prove that those variables cause the target.

---

## Actual vs Predicted

```matlab
scatter(ytest,ypredEnsemble)
xlabel('Actual')
ylabel('Predicted')
title('Ensemble: Actual vs Predicted')
grid on
```

---

## Python and MATLAB Comparison

| Concept | Python | MATLAB |
|---|---|---|
| Regression tree | `DecisionTreeRegressor` | `fitrtree` |
| Random-forest-style bagging | `RandomForestRegressor` | `fitrensemble(...,'Method','Bag')` |
| Predict | `.predict()` | `predict` |
| Feature importance | `feature_importances_` | `predictorImportance` |

---

## Common Errors

- evaluating only training performance;
- assuming deeper trees are always better;
- interpreting feature importance as causation;
- comparing models with different test sets;
- ignoring engineering plausibility.

---

## Practice

1. Fit trees with several values of `MaxNumSplits`.
2. Compare training and test RMSE.
3. Fit a bagged ensemble.
4. Compare tree and ensemble performance.
5. Plot feature importance.
6. Identify the most important engineering variables and discuss whether the ranking is physically plausible.

---

## Required Toolbox

Statistics and Machine Learning Toolbox.

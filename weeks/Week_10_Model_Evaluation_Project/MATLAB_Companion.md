# Week 10 MATLAB Companion — Model Evaluation and Tuning

## Holdout test set
```matlab
cv = cvpartition(length(y),'HoldOut',0.20);
Xtrain = X(training(cv),:);
ytrain = y(training(cv));
Xtest = X(test(cv),:);
ytest = y(test(cv));
```

## Cross-validation
```matlab
model = fitrensemble(Xtrain,ytrain);
cvModel = crossval(model,'KFold',5);
cvLoss = kfoldLoss(cvModel);
```

## Final test prediction
```matlab
ypred = predict(model,Xtest);

MAE = mean(abs(ytest-ypred));
RMSE = sqrt(mean((ytest-ypred).^2));
R2 = 1 - sum((ytest-ypred).^2)/sum((ytest-mean(ytest)).^2);
```

## Hyperparameter tuning
MATLAB can automatically search model hyperparameters.

```matlab
modelTuned = fitrensemble(Xtrain,ytrain, ...
    'OptimizeHyperparameters','auto');
```

The test set should remain untouched until the final model has been selected.

## Engineering reporting
Report:
- model used;
- train/validation/test strategy;
- MAE, RMSE, and R²;
- important hyperparameters;
- limitations;
- engineering meaning of the errors.

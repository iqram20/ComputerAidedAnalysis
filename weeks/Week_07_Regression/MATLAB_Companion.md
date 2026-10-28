# Week 7 MATLAB Companion — Engineering Regression

This companion mirrors the Python regression workflow.

## Regression model
Assume a table `T` contains:

- Ambient_Temperature_C
- Exhaust_Vacuum_cmHg
- Ambient_Pressure_mbar
- Relative_Humidity_percent
- Net_Electrical_Output_MW

```matlab
X = T{:,1:4};                    % Four predictor columns
y = T.Net_Electrical_Output_MW; % Regression target
```

## Train/test split
```matlab
cv = cvpartition(length(y),'HoldOut',0.20);
Xtrain = X(training(cv),:);
ytrain = y(training(cv));
Xtest = X(test(cv),:);
ytest = y(test(cv));
```

## Fit linear regression
```matlab
model = fitlm(Xtrain,ytrain);
ypred = predict(model,Xtest);
```

## Evaluate
```matlab
MAE = mean(abs(ytest-ypred));
RMSE = sqrt(mean((ytest-ypred).^2));
R2 = 1 - sum((ytest-ypred).^2)/sum((ytest-mean(ytest)).^2);
```

## Actual vs predicted
```matlab
scatter(ytest,ypred)
xlabel('Actual Power Output (MW)')
ylabel('Predicted Power Output (MW)')
grid on
```

## Residuals
```matlab
residuals = ytest-ypred;
histogram(residuals)
xlabel('Residual (MW)')
ylabel('Count')
```

The same engineering interpretation used in Python applies in MATLAB: evaluate prediction error, inspect residuals, and decide whether performance is useful for the engineering task.

# Week 6 MATLAB Companion — Machine Learning Fundamentals

MATLAB can perform the same basic supervised-learning workflow introduced in Python.

## Features and target
```matlab
X = [1.2 20; 1.4 25; 1.6 30; 1.8 35; 2.0 40]; % Two input features
y = [10; 12; 15; 18; 21];                       % Numerical target
```

`X` contains the **features**.  
`y` contains the **target**.

## Train/test idea
```matlab
cv = cvpartition(length(y),'HoldOut',0.20);
trainIdx = training(cv);
testIdx = test(cv);

Xtrain = X(trainIdx,:);
Xtest = X(testIdx,:);
ytrain = y(trainIdx);
ytest = y(testIdx);
```

## Simple regression model
```matlab
model = fitlm(Xtrain,ytrain);
ypred = predict(model,Xtest);
```

## Basic error
```matlab
MAE = mean(abs(ytest-ypred));
```

## Regression vs classification in MATLAB
Regression:
```matlab
model = fitlm(X,y);
```

Classification:
```matlab
model = fitclinear(X,classLabels);
```

Functions such as `cvpartition` and `fitclinear` require the **Statistics and Machine Learning Toolbox**.

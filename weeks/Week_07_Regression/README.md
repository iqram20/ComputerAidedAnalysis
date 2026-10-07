# Week 7 — Regression for Engineering Prediction

## Topics
- Continuous target variables
- Linear regression
- Model fitting
- Prediction
- Actual vs. predicted values
- Mean Absolute Error (MAE)
- Mean Squared Error (MSE)
- Root Mean Squared Error (RMSE)
- R²

## Example applications
- Predict concrete compressive strength
- Predict energy consumption
- Predict material strength
- Predict temperature or pressure from sensor variables

## Core scikit-learn workflow
```python
from sklearn.linear_model import LinearRegression

model = LinearRegression()
model.fit(X_train, y_train)
pred = model.predict(X_test)
```

## Learning outcomes
Students should be able to train a regression model, generate predictions, and explain model errors in engineering units.


## Class Notebook

- [Open the 3-hour teaching notebook](Week_07_Regression.ipynb)

The notebook includes explanations, worked examples, engineering applications, guided exercises, independent practice, real open-data activities, and an end-of-class quiz.

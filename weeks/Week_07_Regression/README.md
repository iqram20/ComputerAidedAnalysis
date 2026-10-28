# Week 7 — Regression for Engineering Prediction

## Main Engineering Case Study

This week uses the **UCI Combined Cycle Power Plant dataset** to predict **net electrical power output (MW)** from measured plant and environmental conditions.

The dataset contains **9,568 full-load operating observations** collected over 2006–2011.

### Features

| Feature used in notebook | Meaning | Unit |
|---|---|---|
| `Ambient_Temperature_C` | Ambient temperature | °C |
| `Exhaust_Vacuum_cmHg` | Steam-turbine exhaust vacuum | cm Hg |
| `Ambient_Pressure_mbar` | Ambient pressure | mbar |
| `Relative_Humidity_percent` | Relative humidity | % |

### Target

`Net_Electrical_Output_MW` — net electrical output of the plant in MW.

Dataset source: UCI Machine Learning Repository, dataset 294  
https://archive.ics.uci.edu/dataset/294/combined+cycle+power+plant

DOI: 10.24432/C5002N

## Topics

- regression vs classification
- engineering meaning of continuous targets
- dataset/cohort interpretation
- self-descriptive feature names and units
- exploratory feature–target plots
- train/test split
- reproducibility with `random_state`
- multiple linear regression
- `fit()` and `predict()`
- MAE
- RMSE
- R²
- actual vs predicted plots
- residual analysis
- largest prediction errors
- model coefficients
- coefficient interpretation and limitations
- single-feature vs multiple-feature regression
- common mistakes and student questions
- engineering interpretation

## Learning Outcomes

Students should be able to:

1. identify features and a regression target in an engineering dataset;
2. explain what one dataset observation represents;
3. construct reproducible training and test sets;
4. train and evaluate a linear regression model;
5. explain MAE and RMSE in engineering units;
6. explain R² without calling it “percent accuracy”;
7. interpret residuals;
8. inspect large prediction errors;
9. interpret regression coefficients cautiously;
10. distinguish statistical association from causation;
11. compare single-feature and multiple-feature models;
12. explain model limitations in engineering terms.

## Class Notebook

- [Week 7 — Detailed Regression Lecture Notebook](Week_07_Regression.ipynb)

The notebook is intentionally detailed and includes **concept explanations, student-question sections, code, engineering interpretations, common mistakes, guided exercises, independent exercises, and a review quiz**.


## MATLAB Materials

[MATLAB Companion](MATLAB_Companion.md) — linear regression, MAE, RMSE, R², residuals, and prediction plots.

MATLAB Online: https://matlab.mathworks.com/

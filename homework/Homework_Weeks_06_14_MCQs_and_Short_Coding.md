# ESC 113 — Homework: Weeks 6–14

**Course:** ESC 113 — Computer Aided Analysis for Engineering  
**Instructor:** Iqram Hussain, PhD  
**Primary Environment:** MATLAB / MATLAB Live Editor  

## Coverage

- Week 6 — Machine Learning Fundamentals and Data Preparation
- Week 7 — Regression for Engineering Prediction
- Week 8 — Classification for Engineering Decisions
- Week 9 — Programming Review and Matrix-Based Engineering Computation
- Week 10 — Engineering Data Analysis and Numerical Methods
- Week 11 — Decision Trees, Ensembles, and Feature Importance
- Week 12 — Model Evaluation, Tuning, and Engineering ML Project
- Week 13 — Deep Learning, NLP, and Large Language Models for Engineering
- Week 14 — Engineering Simulation and Computational Modeling

## Instructions

### Part A — Multiple Choice Questions
- Answer all 100 questions.
- Select the **single best answer** for each question.
- Each question has four choices: A, B, C, and D.
- Show calculations where a numerical interpretation is required.

### Part B — Short MATLAB Coding
- Complete all 40 short coding problems.
- Use meaningful variable names.
- Include units in comments and displayed outputs where appropriate.
- Use MATLAB Live Editor sections (`%%`) where helpful.
- Include plots only when requested.
- Code should run without errors.

---

# Part A — 100 Multiple Choice Questions

## Week 6 — Machine Learning Fundamentals and Data Preparation

**1.** In supervised machine learning, the feature matrix is commonly represented by:

A. `y`  
B. `X`  
C. `rng`  
D. `T.Properties`

**2.** Which statement best describes a target variable?

A. It is always a text label.  
B. It is used only to store units.  
C. It is the quantity or class the model is trained to predict.  
D. It is a random seed.

**3.** Which MATLAB command is used in the Week 6 workflow to create a reproducible random split?

A. `rng(42)`  
B. `clear all`  
C. `summary(T)`  
D. `predict(model,Xtest)`

**4.** What is the main purpose of a test set?

A. To calculate training means.  
B. To fit the model coefficients.  
C. To replace missing values.  
D. To estimate performance on unseen observations.

**5.** Which MATLAB function is used to create a holdout partition?

A. `fitlm`  
B. `cvpartition`  
C. `predictorImportance`  
D. `polyfit`

**6.** Which operation creates data leakage?

A. Calculating scaling parameters from the training set only.  
B. Applying training-set scaling parameters to the test set.  
C. Calculating the mean and standard deviation using training and test data together before model fitting.  
D. Fixing the random seed before splitting.

**7.** Why are MATLAB tables useful for engineering datasets?

A. They preserve descriptive variable names.  
B. They automatically train machine-learning models.  
C. They remove all missing values.  
D. They guarantee normal distributions.

**8.** What does the command `missingRows = any(ismissing(T),2);` identify?

A. Columns with negative values.  
B. Rows containing at least one missing value.  
C. Rows used only for testing.  
D. Rows with duplicate labels.

**9.** In the Week 6 regression baseline, the prediction for every test observation is based on:

A. the maximum of `ytest`.  
B. the median of `Xtest`.  
C. the training-target mean.  
D. a random number.

**10.** Which of the following is a classification target?

A. Net electrical output in MW  
B. Concrete strength in MPa  
C. Temperature in °C  
D. Machine condition: Normal or Fault

**11.** Which command correctly selects two named table columns as a numerical feature matrix?

A. `X = T{:,{'Temperature_C','Pressure_kPa'}};`  
B. `X = T('Temperature_C','Pressure_kPa');`  
C. `X = mean(T);`  
D. `X = predict(T);`

---

## Week 7 — Regression for Engineering Prediction

**12.** Regression is used when the target is:

A. a continuous numerical quantity.  
B. always binary.  
C. a text document.  
D. a confusion matrix.

**13.** In the Combined Cycle Power Plant case study, the target variable is:

A. relative humidity.  
B. ambient temperature.  
C. net electrical output.  
D. exhaust vacuum.

**14.** Which MATLAB function is used to fit the multiple linear regression model in Week 7?

A. `fitcecoc`  
B. `fitlm`  
C. `fitrtree`  
D. `fzero`

**15.** What does MAE measure?

A. The average absolute prediction error.  
B. The largest prediction error only.  
C. The percentage of correct classes.  
D. The number of model coefficients.

**16.** Why can RMSE be larger than MAE?

A. RMSE ignores large errors.  
B. RMSE gives more weight to large errors.  
C. MAE uses squared errors.  
D. RMSE is always expressed as a percentage.

**17.** In Week 7, R² should NOT be described as:

A. a measure relative to a mean-based reference.  
B. a quantity related to explained variation.  
C. percent accuracy.  
D. a regression performance metric.

**18.** A positive residual defined as `Actual - Predicted` means:

A. the model overpredicted.  
B. the model underpredicted.  
C. the prediction is exact.  
D. the target is categorical.

**19.** On an actual-vs-predicted plot, a perfect prediction lies:

A. on the horizontal axis.  
B. on the vertical axis.  
C. on the diagonal `y = x` line.  
D. at the mean of the target.

**20.** Why inspect the largest individual prediction errors?

A. Average metrics can hide unusual operating conditions.  
B. They always identify data leakage.  
C. They replace the need for a test set.  
D. They determine the random seed.

**21.** A regression coefficient should be interpreted as:

A. proof of causation.  
B. the estimated change in output associated with a predictor change while other predictors are held fixed.  
C. the probability of a class.  
D. the test-set accuracy.

**22.** Comparing a temperature-only model with a four-feature model helps determine:

A. whether extra operating variables improve prediction.  
B. whether the target should be categorical.  
C. whether MATLAB indexing starts at zero.  
D. whether `rng` is required for plotting.

---

## Week 8 — Classification for Engineering Decisions

**23.** The Week 8 Steel Plates Faults problem is:

A. binary regression.  
B. multiclass classification.  
C. numerical integration.  
D. time-series simulation.

**24.** How many target classes are used in the Week 8 case study?

A. 4  
B. 5  
C. 7  
D. 27

**25.** How many numerical input features are used in the Steel Plates Faults dataset?

A. 7  
B. 20  
C. 27  
D. 1,941

**26.** Why is a stratified split useful for classification?

A. It makes all features have the same units.  
B. It helps preserve class proportions across train and test sets.  
C. It converts categories into continuous targets.  
D. It guarantees perfect accuracy.

**27.** Which pair of MATLAB functions is central to the Week 8 multiclass model?

A. `polyfit` and `polyval`  
B. `gradient` and `trapz`  
C. `templateLinear` and `fitcecoc`  
D. `fzero` and `fitlm`

**28.** Precision is defined as:

A. TP / (TP + FN)  
B. TP / (TP + FP)  
C. TN / total  
D. (TP + TN) / FP

**29.** Recall asks:

A. Of all true observations in a class, how many were detected?  
B. Of all predictions, how many features were used?  
C. How many models were trained?  
D. How many rows were scaled?

**30.** F1 score combines:

A. MAE and RMSE.  
B. train and test error.  
C. precision and recall.  
D. mean and standard deviation.

**31.** Which statement about accuracy is most appropriate?

A. Accuracy always reveals minority-class performance.  
B. Accuracy is sufficient for every imbalanced classification problem.  
C. Accuracy can hide poor performance on smaller classes.  
D. Accuracy is the same as recall.

**32.** In a confusion matrix, correct predictions are normally found:

A. in the diagonal cells.  
B. only in the first row.  
C. only in the final column.  
D. outside the matrix.

**33.** A macro average gives:

A. larger classes more weight.  
B. each class equal contribution.  
C. only the majority class weight.  
D. each feature equal weight.

**34.** A weighted average gives:

A. every class exactly the same weight.  
B. each class weight according to its support.  
C. every feature a value of one.  
D. only misclassified samples weight.

---

## Week 9 — Programming Review and Matrix-Based Engineering Computation

**35.** MATLAB indexing begins at:

A. 0  
B. 1  
C. -1  
D. any value selected by `rng`

**36.** What does `A(:,3)` return?

A. Row 3  
B. Column 3  
C. The third diagonal element only  
D. All elements except column 3

**37.** What does `A(2,:)` return?

A. The second row  
B. The second column  
C. The second matrix  
D. Two random rows

**38.** Which operator performs element-by-element multiplication?

A. `*`  
B. `.*`  
C. `^`  
D. `\`

**39.** Which operator performs element-by-element power?

A. `.^`  
B. `^/`  
C. `**`  
D. `%`

**40.** Which command creates six equally spaced values from 0 to 10?

A. `0:6:10`  
B. `linspace(0,10,6)`  
C. `zeros(0,10,6)`  
D. `size(0,10,6)`

**41.** Which loop is generally appropriate when the number of repetitions is not known in advance?

A. `for` only  
B. `while`  
C. `switch`  
D. `table`

**42.** Which MATLAB command is most suitable for formatted engineering output with units?

A. `fprintf`  
B. `hold on`  
C. `size`  
D. `cvpartition`

**43.** What is the primary reason for using descriptive variable names such as `pressure_kPa`?

A. They reduce all numerical errors.  
B. They make the engineering meaning and units clearer.  
C. They automatically create plots.  
D. They replace comments completely.

**44.** Which command is commonly used to keep multiple curves on the same axes?

A. `grid off`  
B. `hold on`  
C. `clear`  
D. `break`

**45.** In MATLAB, `%%` is used to:

A. begin a runnable code section.  
B. square a variable.  
C. create a matrix.  
D. comment out an entire file automatically.

---

## Week 10 — Engineering Data Analysis and Numerical Methods

**46.** Which MATLAB function reads a CSV or spreadsheet into a table?

A. `readtable`  
B. `fitrnet`  
C. `confusionchart`  
D. `templateTree`

**47.** Which statistic describes variability around the mean?

A. Minimum  
B. Median  
C. Standard deviation  
D. Maximum

**48.** Which operation is used to estimate a linear calibration relationship?

A. `polyfit(x,y,1)`  
B. `fzero(x,y)`  
C. `trapz(x,y,1)`  
D. `gradient(x,y,1)`

**49.** What does `polyval` do?

A. Solves a matrix system.  
B. Evaluates a fitted polynomial at specified values.  
C. Creates a class label.  
D. Splits a dataset.

**50.** Numerical differentiation in Week 10 is demonstrated using:

A. `gradient`  
B. `predict`  
C. `fitcecoc`  
D. `kfoldLoss`

**51.** The area under a velocity-time curve represents:

A. acceleration.  
B. displacement.  
C. pressure.  
D. power.

**52.** Which MATLAB function estimates an integral using the trapezoidal rule?

A. `trapz`  
B. `summary`  
C. `rng`  
D. `head`

**53.** If flow rate is in L/min and time is in minutes, integrating flow rate over time produces:

A. liters.  
B. L/min².  
C. minutes/L.  
D. pressure.

**54.** Which MATLAB function is used to solve a scalar nonlinear equation `f(x)=0` in Week 10?

A. `fitlm`  
B. `fzero`  
C. `fitrtree`  
D. `confusionchart`

**55.** Why is `A\b` preferred over explicitly using `inv(A)*b` for linear systems?

A. It is MATLAB's standard direct solving approach.  
B. It creates categorical data.  
C. It always returns an integer.  
D. It performs numerical differentiation.

**56.** Why should fitted or numerical results be checked for physical plausibility?

A. Numerical output can be mathematically computed but still be physically unreasonable.  
B. MATLAB cannot display units.  
C. Plots are always exact.  
D. Every numerical method proves causation.

---

## Week 11 — Decision Trees, Ensembles, and Feature Importance

**57.** A regression tree predicts:

A. only categorical labels.  
B. a continuous numerical target.  
C. MATLAB commands.  
D. random seeds.

**58.** Which MATLAB function fits a regression tree?

A. `fitrtree`  
B. `fitlm`  
C. `fitcecoc`  
D. `readtable`

**59.** In Week 11, `MaxNumSplits` controls:

A. the train/test ratio.  
B. tree complexity.  
C. the number of target variables.  
D. the random seed.

**60.** A very deep tree may:

A. be more likely to overfit.  
B. always improve test performance.  
C. eliminate all residuals on new data.  
D. make feature importance unnecessary.

**61.** Which pattern suggests overfitting?

A. Training error high and test error high.  
B. Training error very low and test error much higher.  
C. Training and test errors both exactly zero for every dataset.  
D. Test error lower than every training measurement.

**62.** Bagging combines:

A. multiple tree predictions.  
B. multiple target variables into one feature.  
C. only linear regression coefficients.  
D. only one training observation.

**63.** Which MATLAB function is used for the bagged regression ensemble in Week 11?

A. `fitrensemble`  
B. `polyfit`  
C. `fzero`  
D. `fitrnet`

**64.** Feature importance indicates:

A. variables that contributed strongly to tree splits.  
B. variables that are proven causes of the target.  
C. only variables with missing values.  
D. the final test-set size.

**65.** Which command obtains feature importance from a tree or ensemble?

A. `predictorImportance`  
B. `ismissing`  
C. `cvpartition`  
D. `gradient`

**66.** A more complex model should be selected primarily because:

A. it has more parameters.  
B. its unseen-data performance and engineering usefulness are better.  
C. its training error is always zero.  
D. it has the longest MATLAB code.

**67.** Why should the same test set be used when comparing candidate models?

A. To make the comparison fair and consistent.  
B. To increase data leakage.  
C. To make the target categorical.  
D. To avoid calculating metrics.

---

## Week 12 — Model Evaluation, Tuning, and Engineering ML Project

**68.** Which data should be used for final unbiased evaluation?

A. Training data  
B. Validation data only  
C. Final test data  
D. All data repeatedly during tuning

**69.** Five-fold cross-validation divides training data into:

A. five rotating training/validation subsets.  
B. five final test sets that are all used for tuning.  
C. five target variables.  
D. five feature-importance values.

**70.** Which command creates a cross-validated version of a fitted model?

A. `crossval(model,'KFold',5)`  
B. `trapz(model,5)`  
C. `gradient(model,5)`  
D. `polyval(model,5)`

**71.** What does `kfoldLoss` provide?

A. A cross-validation loss estimate.  
B. A feature-importance ranking.  
C. A nonlinear root.  
D. A table of missing values.

**72.** Which of the following is a hyperparameter?

A. Measured target value  
B. Maximum number of tree splits  
C. Test residual for one observation  
D. Engineering unit

**73.** During hyperparameter tuning, the final test set should:

A. be repeatedly used to select the best settings.  
B. remain untouched.  
C. replace the training set.  
D. be used to compute scaling parameters.

**74.** Which MATLAB option can request automatic hyperparameter tuning for an ensemble?

A. `'OptimizeHyperparameters','auto'`  
B. `'MissingValues','all'`  
C. `'EulerMethod','auto'`  
D. `'Residuals','zero'`

**75.** Underfitting is typically associated with:

A. high training error and high test error.  
B. very low training error and much higher test error.  
C. perfect training and test performance.  
D. no training data.

**76.** Which is NOT one of the model-selection considerations emphasized in Week 12?

A. Stability  
B. Interpretability  
C. Engineering plausibility  
D. Choosing the model with the most lines of code

**77.** Why record the random seed, dataset source, preprocessing, and model settings?

A. For reproducibility.  
B. To eliminate the need for validation.  
C. To guarantee causality.  
D. To change continuous targets into classes.

**78.** A complete engineering ML report should include:

A. only final accuracy.  
B. only MATLAB code.  
C. dataset meaning, preprocessing, model selection, metrics, plots, errors, limitations, and interpretation.  
D. only the largest error.

---

## Week 13 — Deep Learning, NLP, and Large Language Models

**79.** A neural network can be useful because it can model:

A. only constant relationships.  
B. nonlinear relationships.  
C. only alphabetical data.  
D. only one feature.

**80.** Which MATLAB function is shown for high-level neural-network regression?

A. `fitrnet`  
B. `fitlm`  
C. `fitcecoc`  
D. `fzero`

**81.** Which is part of a typical deep-learning workflow?

A. Prepare data → define network → train → validate → predict  
B. Predict → delete data → choose units  
C. Test repeatedly → tune on test set  
D. Skip preprocessing → assume results are correct

**82.** For engineering time-series data, which preprocessing detail is important?

A. Sampling rate  
B. Font size only  
C. File color  
D. MATLAB window position

**83.** Which is an example of engineering text data?

A. Maintenance notes  
B. Only voltage arrays  
C. Only images  
D. Only matrix inverses

**84.** A typical text-analytics workflow begins with:

A. raw text.  
B. terminal velocity.  
C. RC resistance.  
D. a confusion matrix diagonal.

**85.** Transformers rely heavily on:

A. attention mechanisms.  
B. Euler time stepping only.  
C. matrix inversion only.  
D. random class removal.

**86.** Which is an appropriate use of an LLM in engineering?

A. Summarizing technical documents with verification.  
B. Treating generated text as an authoritative safety standard without checking.  
C. Replacing all measurements with generated values.  
D. Ignoring governing equations.

**87.** LLM-generated engineering content should be validated against:

A. measured data, governing equations, standards, validated software, or domain expertise.  
B. only another unverified LLM response.  
C. only the longest answer.  
D. only training accuracy.

**88.** Which is a responsible-use concern mentioned in Week 13?

A. Exposing sensitive data to external AI systems.  
B. Using units on plots.  
C. Fixing a random seed.  
D. Comparing train and test performance.

**89.** Which toolbox may be relevant for tokenization and document representation?

A. Text Analytics Toolbox  
B. Mapping Toolbox only  
C. Symbolic Math Toolbox only  
D. Aerospace Toolbox only

---

## Week 14 — Engineering Simulation and Computational Modeling

**90.** A simulation converts:

A. a mathematical model into a sequence of numerical calculations.  
B. every variable into a category.  
C. a confusion matrix into a table.  
D. a test set into training data.

**91.** The Euler update has the general form:

A. next state = current state + time step × rate of change  
B. next state = current state / target  
C. next state = random value  
D. next state = mean of all features

**92.** Why is `zeros(size(t))` used before a simulation loop?

A. To allocate storage for the state history.  
B. To calculate a confusion matrix.  
C. To fit a regression model.  
D. To tune hyperparameters.

**93.** For the falling-object model `dv/dt = g - (c/m)v`, increasing drag coefficient `c` will generally:

A. reduce terminal velocity.  
B. increase terminal velocity without limit.  
C. have no effect.  
D. make mass equal zero.

**94.** The analytical terminal velocity for the linear-drag model is:

A. `mg/c`  
B. `c/(mg)`  
C. `m+c+g`  
D. `g/c²`

**95.** In Newton's cooling model, the object temperature approaches:

A. ambient temperature.  
B. zero in every case.  
C. infinity.  
D. the drag coefficient.

**96.** The RC charging model used in Week 14 is:

A. `dV/dt = (Vs - V)/(RC)`  
B. `dV/dt = mg/c`  
C. `dV/dt = Qin - Qout`  
D. `dV/dt = -k(T-Tamb)`

**97.** Why is a physical constraint included in the tank simulation?

A. Tank volume should not exceed capacity.  
B. It improves class recall.  
C. It creates feature importance.  
D. It changes the target into text.

**98.** What is the purpose of a parameter study?

A. To observe how model output changes when an input parameter changes.  
B. To reuse the test set during training.  
C. To avoid defining initial conditions.  
D. To remove engineering units.

**99.** Time-step sensitivity analysis checks:

A. whether the numerical solution changes when `dt` changes.  
B. whether class labels are balanced.  
C. whether text can be tokenized.  
D. whether feature names are categorical.

**100.** Which statement correctly distinguishes verification from validation?

A. Verification asks whether the equations were solved correctly; validation asks whether the model adequately represents the real system.  
B. Verification and validation are exactly the same.  
C. Verification uses only experiments; validation uses only code syntax.  
D. Validation means checking whether MATLAB opened correctly.

---

# Part B — 40 Short MATLAB Coding Questions

## Week 6 — ML Fundamentals and Data Preparation

**C1.** Create a MATLAB table with four columns: `Temperature_C`, `Pressure_kPa`, `Vibration_mm_s`, and `Power_kW`. Use at least six rows of data. Display the first five rows.

**C2.** From the table in C1, create a feature matrix `X` using temperature, pressure, and vibration, and create target vector `y` using power.

**C3.** Use `rng(42)` and `cvpartition` to create an 80/20 train/test split. Create `Xtrain`, `Xtest`, `ytrain`, and `ytest`.

**C4.** Calculate the training-set mean and standard deviation of each feature. Standardize both training and test features using **training statistics only**.

**C5.** Create a mean-value regression baseline using `mean(ytrain)`. Calculate the baseline MAE on the test set.

---

## Week 7 — Regression

**C6.** Given:
```matlab
x = [10 15 20 25 30 35]';
y = [480 475 468 460 451 442]';
```
fit a linear regression model using `fitlm`.

**C7.** Using the model from C6, predict `y` for the same `x` values and calculate MAE.

**C8.** Calculate RMSE for the predictions from C7.

**C9.** Create an actual-vs-predicted scatter plot and add a dashed `y=x` reference line.

**C10.** Compute residuals using `residual = actual - predicted`. Display the observation with the largest absolute residual.

---

## Week 8 — Classification

**C11.** Create a categorical target vector:
```matlab
status = categorical(["Normal";"Fault";"Normal";"Warning";"Fault";"Normal"]);
```
Use `countcats` and `categories` to inspect the class distribution.

**C12.** Create a numerical feature matrix with six observations and three features. Use `cvpartition` to make a holdout split based on the categorical target.

**C13.** Compute training-set means and standard deviations for the feature matrix in C12 and apply the same scaling to the test data.

**C14.** Suppose:
```matlab
ytrue = categorical(["A";"A";"B";"B";"C";"C"]);
ypred = categorical(["A";"B";"B";"B";"C";"A"]);
```
Create a confusion chart.

**C15.** For a binary class, assume `TP=32`, `FP=8`, and `FN=10`. Write MATLAB code to calculate precision, recall, and F1 score.

---

## Week 9 — Programming and Matrix Review

**C16.** Create a 3×4 matrix `A`. Display the second row, third column, and the element in row 2 column 4.

**C17.** Create `velocity = 0:2:20` m/s for a 5 kg object. Calculate kinetic energy at every velocity using element-wise operations.

**C18.** Given:
```matlab
pressures = [480 510 495 530 470 550 505];
```
use logical indexing to extract only pressures greater than 500 kPa.

**C19.** Write an `if/elseif/else` block that classifies machine temperature as:
- Normal: below 70 °C
- Warning: 70–90 °C
- Critical: above 90 °C

**C20.** Use a `while` loop to determine how many minutes are required for a 600 L tank to drain at 15 L/min, starting full.

---

## Week 10 — Data Analysis and Numerical Methods

**C21.** Create a MATLAB table containing `Time_s`, `Temperature_C`, and `Pressure_kPa`. Calculate mean, median, standard deviation, minimum, and maximum temperature.

**C22.** Given:
```matlab
voltage = [0.5 1.0 1.5 2.0 2.5];
temperature = [10 21 31 42 52];
```
use `polyfit` to fit a straight line and `polyval` to estimate temperature at 1.75 V.

**C23.** Given position measurements:
```matlab
t = 0:0.5:5;
position = [0 0.6 2.4 5.4 9.6 15.0 21.6 29.4 38.4 48.6 60.0];
```
use `gradient` to estimate velocity.

**C24.** Given:
```matlab
time_min = [0 1 2 3 4 5 6];
flow_L_min = [10 11 13 15 14 12 10];
```
use `trapz` to estimate total delivered volume.

**C25.** Solve `x^3 - 4x - 9 = 0` using `fzero` and verify the solution by evaluating the original function at the root.

---

## Week 11 — Trees, Ensembles, and Feature Importance

**C26.** Create a regression tree using:
```matlab
treeModel = fitrtree(Xtrain,ytrain,'MaxNumSplits',8);
```
Then predict `Xtest` and calculate test RMSE.

**C27.** Fit three trees using `MaxNumSplits = [3 8 20]`. Store and display the training and test RMSE for each model.

**C28.** Fit a bagged regression ensemble using `fitrensemble` with `'Method','Bag'`. Predict the test set and calculate RMSE.

**C29.** Use `predictorImportance` on a fitted regression tree. Sort the importance values from largest to smallest and display the corresponding feature names.

---

## Week 12 — Model Evaluation and Tuning

**C30.** Fit a regression model using training data and create a 5-fold cross-validated model with:
```matlab
cvModel = crossval(model,'KFold',5);
```
Calculate `kfoldLoss`.

**C31.** Use `kfoldPredict` to obtain cross-validated predictions and calculate RMSE between the development targets and cross-validated predictions.

**C32.** Create a table comparing RMSE for three candidate models named `Linear`, `Tree`, and `Ensemble`.

**C33.** After selecting a final model, predict `Xtest` once and calculate MAE, RMSE, and R².

---

## Week 13 — Deep Learning, NLP, and LLMs

**C34.** Given numerical `Xtrain`, `ytrain`, `Xtest`, and `ytest`, fit a neural-network regression model using `fitrnet`, predict the test set, and calculate RMSE.

**C35.** Create a MATLAB string array containing at least five engineering maintenance notes. Use `tokenizedDocument` to tokenize the notes.

**C36.** Write MATLAB code that stores four engineering text categories — `Electrical`, `Mechanical`, `Hydraulic`, and `Normal` — as a categorical array.

**C37.** Write a short MATLAB cell array named `validationChecks` containing at least four ways an AI-generated engineering answer should be verified before use.

---

## Week 14 — Engineering Simulation

**C38.** Simulate `dy/dt = -0.5y` from `t=0` to `10` using Euler's method with `dt=0.1` and initial condition `y(1)=1`. Plot the result.

**C39.** Simulate Newton cooling:
```text
dT/dt = -k(T - Tamb)
```
using `T0=95 °C`, `Tamb=22 °C`, `k=0.08`, and `dt=0.1`. Plot temperature versus time.

**C40.** Simulate an RC charging circuit:
```text
dV/dt = (Vs - V)/(RC)
```
using `Vs=12 V`, `R=1000 ohm`, `C=0.001 F`, and `dt=0.01 s`. Plot both the Euler solution and the analytical solution `V = Vs*(1-exp(-t/(R*C)))` on the same figure.

---

## Submission Reminder

Before submitting, verify that:

- all 100 MCQs are answered;
- all 40 MATLAB coding problems are attempted;
- MATLAB code runs without errors;
- variables have meaningful names;
- engineering units are included where appropriate;
- plots include titles, axis labels, and units;
- copied code or generated answers are understood and checked.

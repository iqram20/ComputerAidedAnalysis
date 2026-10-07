# Week 12 Assignment — MATLAB Data Analysis and Numerical Methods

## Submission

Submit one MATLAB script file (`.m`) containing all coding solutions and a short PDF or Word document containing written answers.

Use comments and `%%` sections to separate problems.

---

## Part A — Engineering Data Handling

1. Create a MATLAB table with columns for Time, Temperature, Pressure, and Flow Rate.
2. Save the table as a CSV file.
3. Read the CSV file back into MATLAB using `readtable`.
4. Display the first five rows.
5. Display the table variable names.
6. Calculate mean, median, standard deviation, minimum, and maximum for Temperature.
7. Repeat the statistical analysis for Pressure.
8. Extract only rows where Pressure > 500 kPa.
9. Extract rows where Temperature > 80°C and Pressure > 500 kPa.
10. Add a new logical column named `Warning`.

---

## Part B — Engineering Visualization

11. Plot Temperature vs Time.
12. Plot Pressure vs Time.
13. Plot Flow Rate vs Time.
14. Plot Temperature and Pressure on one figure with a legend.
15. Create a tiled figure showing Temperature, Pressure, and Flow Rate.

Every plot must include:
- title,
- axis labels,
- units,
- grid.

---

## Part C — Curve Fitting

16. Use the following calibration data:

```matlab
voltage = [0.5 1.0 1.5 2.0 2.5];
temperature = [10 21 31 42 52];
```

Fit a linear model using `polyfit`.

17. Report the slope and intercept.
18. Predict temperature at 1.75 V.
19. Plot measured data and fitted line.
20. Calculate residuals between measured and predicted values.

---

## Part D — Numerical Differentiation

21. Given:

```matlab
t = 0:0.5:5;
x = [0 0.6 2.4 5.4 9.6 15 21.6 29.4 38.4 48.6 60];
```

use `gradient` to estimate velocity.

22. Use the velocity result to estimate acceleration.
23. Plot position, velocity, and acceleration.

---

## Part E — Numerical Integration

24. Given:

```matlab
t = 0:1:10;
v = [0 2 4 6 8 10 11 12 12 11 10];
```

use `trapz` to estimate displacement.

25. Given flow-rate data, use `trapz` to estimate total delivered volume.

---

## Part F — Nonlinear Equations

26. Solve:

```
x^3 - 4x - 9 = 0
```

using `fzero`.

27. Verify the result by substituting the root back into the equation.

28. Solve:

```
x^3 - 2x - 5 = 0
```

using `fzero`.

---

## Part G — Linear Systems

29. Solve:

```
2x + y = 8
x + 3y = 9
```

using matrix notation.

30. Solve:

```
3x + 2y = 18
x + 4y = 16
```

using `A\b`.

31. Verify both solutions using matrix multiplication.

---

## Part H — Engineering Applications

32. Use a linear fit on stress-strain data to estimate elastic modulus.
33. Analyze a temperature sensor calibration curve.
34. Integrate a measured flow-rate curve to estimate total volume.
35. Differentiate position data to estimate velocity.
36. Solve one nonlinear engineering equation of your choice using `fzero`.

---

## Short Questions

37. What is the difference between a MATLAB numeric matrix and a table?
38. Why is logical filtering useful for engineering datasets?
39. What does `polyfit(x,y,1)` calculate?
40. What does `polyval` do?
41. What does `gradient` approximate?
42. What does `trapz` approximate?
43. What type of problem does `fzero` solve?
44. Why is `A\b` preferred to explicitly calculating `inv(A)*b`?
45. Why should engineers inspect plots before fitting models?
46. Why must numerical results be checked for physical reasonableness?

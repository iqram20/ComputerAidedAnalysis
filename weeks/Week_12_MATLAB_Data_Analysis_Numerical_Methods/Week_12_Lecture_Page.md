# Week 12 — Engineering Data Analysis and Numerical Methods
## How to Use This Lecture Page

Work through the material the same way you would use a Colab notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB lecture material**

Engineering measurements are often discrete rather than available as exact mathematical functions. Numerical methods allow useful engineering quantities to be estimated directly from measured data.

This chapter covers:

- tabular data;
- descriptive statistics;
- filtering;
- curve fitting;
- numerical differentiation;
- numerical integration;
- nonlinear equations;
- linear systems.

---

## Engineering Data Tables

```matlab
Time_s = [0;5;10;15;20;25;30];
Temperature_C = [22;25;30;37;45;54;60];
Pressure_kPa = [101;110;125;150;185;220;260];

data = table(Time_s,Temperature_C,Pressure_kPa);
```

A table keeps variable names attached to the measurements.

Inspect:

```matlab
head(data)
summary(data)
```

Access a variable:

```matlab
temperature = data.Temperature_C;
```

---

## Import Engineering Data

CSV:

```matlab
T = readtable('sensor_data.csv');
```

Excel:

```matlab
T = readtable('sensor_data.xlsx');
```

Before analysis, inspect:

- variable names;
- dimensions;
- missing values;
- units;
- impossible values.

---

## Descriptive Statistics

```matlab
mean_temp = mean(temperature);
median_temp = median(temperature);
std_temp = std(temperature);
min_temp = min(temperature);
max_temp = max(temperature);
```

Each statistic answers a different question.

| Statistic | Meaning |
|---|---|
| Mean | Average level |
| Median | Middle value |
| Standard deviation | Spread/variability |
| Minimum | Lowest value |
| Maximum | Highest value |

---

## Logical Filtering

```matlab
highPressureRows = data.Pressure_kPa > 180;

highPressureData = data(highPressureRows,:);
```

Multiple conditions:

```matlab
warningRows = ...
    data.Temperature_C > 45 & ...
    data.Pressure_kPa > 200;

warningData = data(warningRows,:);
```

Filtering is useful for identifying operating conditions that exceed limits.

---

## Engineering Plot

```matlab
plot(data.Time_s,data.Temperature_C,'o-')
xlabel('Time (s)')
ylabel('Temperature (°C)')
title('Temperature vs Time')
grid on
```

A plot should help answer an engineering question, not only display data.

---

# Curve Fitting

Measured calibration data rarely fall exactly on a mathematical line.

A fitted model summarizes the relationship.

## Linear Fit

```matlab
voltage = [0.5 1.0 1.5 2.0 2.5];
temperature = [10 21 31 42 52];

p = polyfit(voltage,temperature,1);
```

`p` contains:

```text
slope
intercept
```

Predict fitted values:

```matlab
temperatureFit = polyval(p,voltage);
```

For a new voltage:

```matlab
newVoltage = 1.75;
estimatedTemperature = polyval(p,newVoltage);
```

---

## Polynomial Fit

```matlab
p2 = polyfit(x,y,2);
```

The final argument:

```text
2
```

means second-order polynomial.

A higher-order polynomial is not automatically better. It can overfit measured data.

---

# Numerical Differentiation

If position is measured at discrete times, velocity can be estimated numerically.

```matlab
velocity = gradient(position,t);
```

Then acceleration:

```matlab
acceleration = gradient(velocity,t);
```

Physical meaning:

```text
position
   ↓ derivative
velocity
   ↓ derivative
acceleration
```

Numerical differentiation can amplify measurement noise.

---

# Numerical Integration

The area under a velocity-time curve represents displacement.

```matlab
distance = trapz(time,velocity);
```

`trapz` uses the trapezoidal rule.

---

## Flow-Rate Example

If flow rate is measured in L/min:

```matlab
time_min = [0 1 2 3 4 5 6];
flow_L_min = [10 11 13 15 14 12 10];

volume_L = trapz(time_min,flow_L_min);
```

Because:

```text
(L/min) × min = L
```

the integral gives total volume.

---

# Solving Nonlinear Equations

Many engineering equations cannot be rearranged easily.

Example:

```text
x³ - 4x - 9 = 0
```

Define the function:

```matlab
f = @(x) x.^3 - 4*x - 9;
```

Find a root:

```matlab
root = fzero(f,3);
```

Verify:

```matlab
f(root)
```

The result should be close to zero.

---

## Engineering Example — Terminal Velocity

Force balance:

```text
cv² - mg = 0
```

```matlab
m = 80;
g = 9.81;
c = 0.25;

forceBalance = @(v) c*v.^2 - m*g;

terminalVelocity = fzero(forceBalance,50);
```

---

# Solving Linear Systems

Consider:

```text
2x + y = 8
x + 3y = 9
```

Matrix form:

```text
Ax = b
```

MATLAB:

```matlab
A = [2 1;
     1 3];

b = [8;
     9];

solution = A\b;
```

The backslash operator is MATLAB's standard way to solve linear systems.

---

## Verify the Solution

```matlab
A*solution
```

should reproduce:

```matlab
b
```

Verification is important because a numerical answer should satisfy the original engineering equations.

---

# Stress–Strain Example

```matlab
strain = [0 0.0005 0.0010 0.0015 0.0020 0.0025];
stress_MPa = [0 100 200 295 385 465];

p = polyfit(strain,stress_MPa,1);

E_MPa = p(1);
```

The slope of the approximately linear stress–strain relationship estimates elastic modulus.

The fitted value should still be checked for physical plausibility.

---

# Python and MATLAB Comparison

| Task | Python | MATLAB |
|---|---|---|
| Read CSV | `pd.read_csv` | `readtable` |
| Mean | `.mean()` / `np.mean` | `mean` |
| Filter rows | Boolean indexing | Logical indexing |
| Linear fit | `np.polyfit` | `polyfit` |
| Evaluate fit | `np.polyval` | `polyval` |
| Derivative | `np.gradient` | `gradient` |
| Integral | `np.trapz` | `trapz` |
| Root | `brentq` / `root` | `fzero` |
| Linear system | `np.linalg.solve` | `A\b` |

---

# Common Errors

## Incorrect units in integration

If time is in minutes and flow is in L/s, units must be converted before integration.

## Interpreting a fit outside the data range

Extrapolation can be unreliable.

## Using a very high polynomial order

A curve may fit the measured points closely but behave unrealistically between or outside them.

## Forgetting to verify a root

Always evaluate the original equation at the computed root.

## Using matrix inverse unnecessarily

Prefer:

```matlab
x = A\b;
```

instead of:

```matlab
x = inv(A)*b;
```

---

# Guided Practice

1. Create a table containing time, voltage, and current.
2. Add a power column using `P = VI`.
3. Calculate mean, median, standard deviation, minimum, and maximum pressure.
4. Fit a calibration line and estimate an unknown pressure.
5. Use `gradient` to estimate velocity from displacement data.
6. Use `trapz` to estimate total volume from flow-rate measurements.
7. Solve `x³ - 2x - 5 = 0` using `fzero`.
8. Solve a two-equation linear system using `A\b`.

---

# Complete Code

[MATLAB data analysis and numerical methods](MATLAB_Data_Analysis_Numerical_Methods.m)

[Python equivalent examples](Engineering_Data_Analysis_Numerical_Methods_Python.py)

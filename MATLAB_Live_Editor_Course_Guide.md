# ESC 113 — MATLAB Live Editor Course Guide

## Primary Course Format

ESC 113 uses **MATLAB Live Editor** as the primary teaching and coding environment.

A lecture should feel like a notebook rather than a long script.

The standard pattern is:

```text
Short explanation
      ↓
Equation / engineering meaning
      ↓
Small MATLAB code section
      ↓
Visible output / table / figure
      ↓
Interpretation
      ↓
Next step
```

Students should not run a very long file without understanding intermediate results.

---

## 1. Open MATLAB

MATLAB Online:

https://matlab.mathworks.com/

Students may also use MATLAB Desktop if it is installed.

For lecture work, use the **Live Editor**.

---

## 2. Live Script Structure

A Live Script should combine:

- headings;
- explanatory text;
- equations;
- small code sections;
- output;
- tables;
- figures;
- interpretation.

Example structure:

### Engineering concept

Weight is:

```text
W = mg
```

### Code

```matlab
mass = 10;      % kg
g = 9.81;       % m/s^2
```

### Next code section

```matlab
weight = mass*g;
fprintf('Weight = %.2f N\n',weight)
```

### Interpretation

A 10 kg mass has a weight of approximately 98.1 N near Earth's surface.

---

## 3. Keep Code Sections Small

For beginning students, most code sections should contain roughly **2–8 lines**.

Avoid placing an entire analysis into one large block.

Better:

```matlab
X = T{:,featureNames};
y = T.Power_MW;
```

Then explain what `X` and `y` mean.

Next:

```matlab
rng(42)
cv = cvpartition(length(y),'HoldOut',0.20);
```

Then explain the train/test split.

---

## 4. Use Section Breaks in MATLAB Code

In MATLAB scripts, use:

```matlab
%%
```

to create runnable sections.

Example:

```matlab
%% Define Variables
mass = 10;
g = 9.81;

%% Calculate Weight
weight = mass*g;

%% Display Result
fprintf('Weight = %.2f N\n',weight)
```

Each section should represent one logical step.

---

## 5. Give Students Visible Evidence That a Step Ran

Where practical, an important section should produce something visible:

```matlab
disp(variable)
```

or:

```matlab
fprintf('RMSE = %.2f MPa\n',RMSE)
```

or:

```matlab
head(T)
```

or a plot:

```matlab
plot(x,y)
grid on
```

Students should inspect the output before running the next section.

---

## 6. Explain Variables Before Using Them

Example:

```matlab
mass_kg = 25;               % Mass in kg
acceleration_m_s2 = 3.2;   % Acceleration in m/s^2
```

Then:

```matlab
force_N = mass_kg*acceleration_m_s2;
```

Descriptive names make the engineering meaning clear.

---

## 7. Always Include Units

Engineering output should not be reported as:

```text
98.1
```

Prefer:

```matlab
fprintf('Weight = %.1f N\n',weight)
```

Plots should include units:

```matlab
xlabel('Time (s)')
ylabel('Velocity (m/s)')
```

---

## 8. Put Interpretation After Important Output

A result is not complete until its engineering meaning is explained.

Example:

```matlab
RMSE = sqrt(mean((ytest-ypred).^2));
fprintf('RMSE = %.2f MPa\n',RMSE)
```

Then explain:

> RMSE represents the typical prediction-error scale, with larger errors receiving more weight. Because the target is concrete strength, the RMSE unit is MPa.

---

## 9. Separate Setup, Calculation, and Interpretation

Recommended structure:

### Step 1 — Define data

```matlab
time = 0:1:10;
velocity = [0 2 4 6 8 10 11 12 12 11 10];
```

### Step 2 — Calculate

```matlab
distance = trapz(time,velocity);
```

### Step 3 — Display

```matlab
fprintf('Distance = %.2f m\n',distance)
```

### Step 4 — Interpret

The area under the velocity-time curve estimates displacement.

---

## 10. Plotting Standard

Every engineering plot should normally include:

- descriptive title;
- x-axis label;
- y-axis label;
- units;
- legend when multiple curves are shown;
- grid where useful.

Example:

```matlab
plot(time,temperature,'o-')
xlabel('Time (min)')
ylabel('Temperature (°C)')
title('Cooling Response')
grid on
```

---

## 11. Machine-Learning Standard

Machine-learning lectures should use this sequence:

```text
Engineering problem
      ↓
Dataset description
      ↓
What one row represents
      ↓
Features and target
      ↓
Data inspection
      ↓
Train/test split
      ↓
Training-only preprocessing
      ↓
Model
      ↓
Prediction
      ↓
Metrics
      ↓
Error analysis
      ↓
Engineering interpretation
```

Do not introduce a model before students understand the dataset and target.

---

## 12. Numerical-Methods Standard

For a numerical method, explain:

1. physical or mathematical problem;
2. equation;
3. why an exact solution may be unavailable or inconvenient;
4. MATLAB numerical function;
5. result;
6. verification;
7. engineering meaning.

Example:

```matlab
root = fzero(f,3);
```

Then verify:

```matlab
f(root)
```

---

## 13. Simulation Standard

Every simulation should identify:

- governing equation;
- state variable;
- parameters;
- initial condition;
- time step;
- update equation;
- physical constraints;
- verification;
- validation considerations.

Students should never treat a smooth plot as proof that a simulation is correct.

---

## 14. Common MATLAB Conventions

| Concept | MATLAB |
|---|---|
| Comment | `%` |
| Section | `%%` |
| Suppress output | `;` |
| First element | `x(1)` |
| All rows | `:` |
| Element multiply | `.*` |
| Element divide | `./` |
| Element power | `.^` |
| Matrix solve | `A\b` |

---

## 15. Submission Standard

Unless an assignment states otherwise, students should submit:

- MATLAB Live Script (`.mlx`) preferred;
- MATLAB script (`.m`) acceptable when appropriate;
- requested figures;
- short written interpretation;
- data or data-access instructions when external data are used.

A submission should be readable from top to bottom and should include section titles and comments.

---

## 16. Course Language

The active course is MATLAB-based. Archived Python files may be retained for historical reference, but students should follow the MATLAB Live Editor materials for all active chapters.

---

## 17. Recommended Student Workflow

For every lecture:

1. Read the text.
2. Predict what the next code block should do.
3. Run only that block.
4. Inspect output.
5. Check units and physical reasonableness.
6. Read the interpretation.
7. Modify one value and observe the effect.
8. Continue to the next section.

This approach builds understanding rather than encouraging students to run code without knowing what it does.

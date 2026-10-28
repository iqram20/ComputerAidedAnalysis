# Week 11 — Programming Review and Matrix-Based Engineering Computation
## How to Use This Lecture Page

Work through the material the same way you would use a Colab notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB lecture material**

## Why MATLAB Is Useful in Engineering

MATLAB is designed for numerical computation with vectors, matrices, data, plots, and engineering algorithms.

Many engineering problems naturally involve:

- sensor arrays;
- forces and displacements;
- electrical signals;
- time-series measurements;
- systems of equations;
- matrices;
- repeated calculations.

MATLAB makes these operations compact because vectors and matrices are fundamental data types.

---

## MATLAB Workspace

The main MATLAB areas are:

| Area | Purpose |
|---|---|
| Editor | Write and edit scripts |
| Command Window | Run commands and view output |
| Workspace | Inspect variables currently stored |
| Current Folder | Manage files used by MATLAB |
| Figure Window | Display plots |

MATLAB scripts use the extension:

```text
.m
```

MATLAB Online:

https://matlab.mathworks.com/

---

## Variables and Arithmetic

```matlab
mass = 25;              % kg
acceleration = 3.2;     % m/s^2

force = mass*acceleration;

fprintf('Force = %.2f N\n',force)
```

The program evaluates:

```text
F = ma
```

The semicolon suppresses automatic output.

---

## Vectors

```matlab
temperature = [20 22 24 26 28];
```

A vector can represent several measurements of the same physical quantity.

Access individual values:

```matlab
temperature(1)
temperature(3)
temperature(end)
```

MATLAB indexing starts at **1**.

---

## Matrices

```matlab
A = [1 2 3;
     4 5 6;
     7 8 9];
```

Interpretation:

```text
row 1 → 1 2 3
row 2 → 4 5 6
row 3 → 7 8 9
```

Extract:

```matlab
A(2,3)       % row 2, column 3
A(2,:)       % all values in row 2
A(:,3)       % all values in column 3
```

---

## Why Matrix Operations Matter

Engineering systems often involve equations such as:

```text
Ax = b
```

where:

- `A` contains coefficients;
- `x` contains unknowns;
- `b` contains known values.

MATLAB is particularly strong for this type of computation.

---

## Matrix vs Element-by-Element Operations

This is one of the most important MATLAB concepts.

```matlab
A*B
```

means matrix multiplication.

```matlab
A.*B
```

means multiply matching elements.

Similarly:

| Purpose | MATLAB |
|---|---|
| Matrix multiplication | `*` |
| Element-wise multiplication | `.*` |
| Matrix power | `^` |
| Element-wise power | `.^` |
| Matrix division | `/` |
| Element-wise division | `./` |

---

## Engineering Example — Kinetic Energy

For several velocities:

```matlab
mass = 5;
velocity = [2 4 6 8 10];

KE = 0.5*mass.*velocity.^2;

disp(KE)
```

The dot before the power is required because every velocity value is squared individually.

---

## Logical Indexing

```matlab
pressure = [220 310 450 510 490 540 300];

unsafe = pressure > 500;

unsafePressure = pressure(unsafe);
```

This creates:

```text
510   540
```

Logical indexing is useful for:

- threshold filtering;
- quality control;
- alarm detection;
- selecting operating regions.

---

## Branching

```matlab
temperature = 85;

if temperature < 70
    status = "Normal";
elseif temperature <= 90
    status = "Warning";
else
    status = "Critical";
end
```

Branching converts engineering decision logic into program logic.

---

## for Loop

```matlab
acceleration = 3;

for t = 0:10
    velocity = acceleration*t;
    fprintf('t = %d s, v = %.1f m/s\n',t,velocity)
end
```

---

## while Loop

```matlab
volume = 0;
flowRate = 12;
minutes = 0;

while volume < 500
    volume = volume + flowRate;
    minutes = minutes + 1;
end
```

A `while` loop is useful when the number of iterations is not known in advance.

---

## Plotting

```matlab
t = 0:0.1:10;
velocity = 3*t;

plot(t,velocity)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity vs Time')
grid on
```

Engineering plots should include:

- axis labels;
- units;
- descriptive title;
- legend when multiple curves appear.

---

## Engineering Example — Projectile Motion

```matlab
v0 = 30;
theta_deg = 40;
g = 9.81;

theta = deg2rad(theta_deg);

t_flight = 2*v0*sin(theta)/g;
t = linspace(0,t_flight,100);

x = v0*cos(theta).*t;
y = v0*sin(theta).*t - 0.5*g.*t.^2;

plot(x,y)
xlabel('Horizontal Distance (m)')
ylabel('Height (m)')
grid on
```

The equations are evaluated at 100 time points to produce the trajectory.

---

## Engineering Example — Reynolds Number

```matlab
rho = 998;
mu = 0.001;
D = 0.05;

velocity = 0.2:0.2:3.0;

Re = rho.*velocity.*D./mu;

plot(velocity,Re)
xlabel('Velocity (m/s)')
ylabel('Reynolds Number')
grid on
```

This is a vectorized calculation: one expression computes Reynolds number at every velocity.

---

## Functions

```matlab
function force = calculateForce(mass,acceleration)
    force = mass*acceleration;
end
```

Functions reduce repeated code and make engineering programs easier to test.

---

## Python and MATLAB Equivalence

| Concept | Python | MATLAB |
|---|---|---|
| First array element | `x[0]` | `x(1)` |
| Power | `x**2` | `x^2` |
| Element-wise square | `x**2` with NumPy | `x.^2` |
| Matrix multiplication | `A @ B` | `A*B` |
| Mean | `np.mean(x)` | `mean(x)` |
| Plot | `plt.plot(x,y)` | `plot(x,y)` |
| Condition | `elif` | `elseif` |

---

## Common Errors

### 1. Index starts at zero

Incorrect assumption:

```text
first value = x(0)
```

MATLAB starts at:

```matlab
x(1)
```

### 2. Missing dot operator

For vector powers:

```matlab
velocity.^2
```

not:

```matlab
velocity^2
```

unless a matrix power is actually intended.

### 3. Missing `end`

`if`, `for`, `while`, and functions require `end`.

---

## Guided Practice

### Exercise 1 — Potential Energy

Calculate:

```text
PE = mgh
```

for a 15 kg object raised 8 m.

### Exercise 2 — Voltage vs Current

Create current values from 1 A to 8 A for a 12 Ω resistor and calculate:

```text
V = IR
```

Plot voltage vs current.

### Exercise 3 — Pressure Filtering

Given:

```matlab
pressure = [480 495 505 520 475 540];
```

extract values above 500 kPa.

### Exercise 4 — Motor Efficiency

Classify:

```text
High efficiency: ≥ 90%
Acceptable: 75% to < 90%
Low efficiency: < 75%
```

### Exercise 5 — Cooling

Use a while loop to simulate a temperature falling from 100°C by 5°C each minute until it drops below 40°C.

---

## Complete Code

[MATLAB programming examples](MATLAB_Basics_Engineering_Examples.m)

[Python equivalent examples](Programming_Examples_Python.py)

[MATLAB usage guide](MATLAB_Usage_Guide.md)

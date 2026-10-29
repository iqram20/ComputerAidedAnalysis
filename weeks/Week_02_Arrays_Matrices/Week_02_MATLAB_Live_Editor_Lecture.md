# Week 2 — Variables, Data Structures, Arrays, and Matrices
## How to Use This Lecture Page

Work through the material as a MATLAB Live Editor notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB implementation**

Engineering data often contain many measurements rather than one number. MATLAB is built around vectors, matrices, and tables, making it especially useful for numerical engineering data.

## Scalar, Vector, and Matrix

A **scalar** contains one value:

```matlab
temperature = 25;
```

A **vector** contains a sequence of values:

```matlab
temperature = [20 22 24 27 30];
```

A **matrix** contains rows and columns:

```matlab
A = [1 2 3;
     4 5 6;
     7 8 9];
```

---

## Row and Column Vectors

Row vector:

```matlab
force = [10 20 30 40];
```

Column vector:

```matlab
force = [10; 20; 30; 40];
```

Transpose a row vector into a column vector:

```matlab
force_column = force';
```

---

## MATLAB Indexing Starts at 1

```matlab
temperature = [20 22 24 27 30];

temperature(1)          % First value
temperature(3)          % Third value
temperature(end)        % Last value
```

MATLAB indexing begins at 1.

---

## Slicing

```matlab
temperature(2:4)        % Values 2 through 4
```

For a matrix:

```matlab
A(2,3)                  % Row 2, column 3
A(:,2)                  % Every row, column 2
A(1,:)                  % Row 1, every column
```

The colon `:` means “all values in this dimension.”

---

## Creating Numerical Sequences

Using the colon operator:

```matlab
time = 0:1:10;          % 0,1,2,...,10
```

Using `linspace`:

```matlab
time = linspace(0,10,6);
```

Result:

```text
0  2  4  6  8  10
```

---

## Element-by-Element Operations

Consider:

```matlab
velocity = [2 4 6 8 10];
```

Square every value:

```matlab
velocity_squared = velocity.^2;
```

Multiply each element:

```matlab
momentum = 5.*velocity;
```

Divide each element:

```matlab
half_velocity = velocity./2;
```

The dot is important for element-wise operations:

| Operation | Matrix form | Element-wise form |
|---|---|---|
| Multiply | `*` | `.*` |
| Divide | `/` | `./` |
| Power | `^` | `.^` |

---

## Engineering Example — Kinetic Energy at Several Speeds

```matlab
mass = 5;                        % kg
velocity = [2 4 6 8 10];         % m/s

KE = 0.5*mass.*velocity.^2;      % J

disp(KE)
```

The code evaluates the same equation for every velocity:

```text
KE = 1/2 mv²
```

---

## Descriptive Statistics

```matlab
measurements = [12.5 15.8 14.2 18.6 16.1];

mean_value = mean(measurements);
median_value = median(measurements);
minimum_value = min(measurements);
maximum_value = max(measurements);
std_value = std(measurements);
```

These commands summarize measured engineering data.

---

## Logical Indexing

```matlab
pressure = [220 310 450 510 490 540 300];

unsafe = pressure > 500;
unsafe_pressure = pressure(unsafe);

disp(unsafe_pressure)
```

Output:

```text
510   540
```

Logical indexing is useful for filtering measurements that exceed an engineering limit.

---

## Tables

A table can store several named engineering variables.

```matlab
Time_s = [0;1;2;3];
Temperature_C = [22;25;29;34];
Pressure_kPa = [101;105;111;118];

T = table(Time_s,Temperature_C,Pressure_kPa);

disp(T)
```

Access one column:

```matlab
T.Temperature_C
```

---

## MATLAB Syntax Summary

| Concept | MATLAB |
|---|---|
| Row vector | `[1 2 3]` |
| First element | `A(1)` |
| Matrix size | `size(A)` |
| Column 2 | `A(:,2)` |
| Element power | `A.^2` |
| Mean | `mean(A)` |

---

## Common Errors

A frequent MATLAB error is using matrix multiplication when element-wise multiplication is intended.

For vectors:

```matlab
x*y
```

and

```matlab
x.*y
```

do not mean the same thing.

Another common mistake is forgetting that MATLAB indexing starts at **1**.

---

## Practice

1. Create a vector of temperatures from 20°C to 100°C in increments of 10°C.
2. Convert all temperatures to Fahrenheit using a vectorized expression.
3. Create a 3 × 3 matrix and extract its second row.
4. Given pressure measurements, extract only values above 400 kPa.
5. Create a table containing time, voltage, and current.
6. Add a calculated power column using `P = VI`.

---

## Key Idea

Vectors and matrices allow one engineering equation to be applied to many measurements efficiently.

# Week 1 — Programming Basics and Engineering Calculations
## How to Use This Lecture Page

Work through the material the same way you would use a Colab notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB implementation**

MATLAB can be used as both an engineering calculator and a programming environment. The engineering equations are the same as in Python; only the syntax changes.

## Start MATLAB

MATLAB Online: https://matlab.mathworks.com/

A MATLAB script is normally saved with the extension:

```text
.m
```

Example:

```text
Week01_Engineering_Calculations.m
```

MATLAB sections begin with:

```matlab
%%
```

A section can be run independently using **Run Section**.

---

## Numbers and Arithmetic

```matlab
2 + 3                  % Addition
10 - 4                 % Subtraction
6 * 5                  % Multiplication
20 / 4                 % Division
2^3                    % Power
sqrt(25)               % Square root
```

A percent sign begins a comment:

```matlab
% This is a MATLAB comment
```

A semicolon suppresses automatic output:

```matlab
x = 5;                 % Store 5 without printing it
```

Without the semicolon:

```matlab
x = 5
```

MATLAB prints the result in the Command Window.

---

## Variables and Engineering Quantities

A variable stores a value that can be used later.

```matlab
mass = 10;             % Mass in kg
gravity = 9.81;        % Gravitational acceleration in m/s^2
weight = mass*gravity; % Weight in N

disp(weight)
```

Expected result:

```text
98.1
```

The calculation represents:

```text
W = mg
  = 10 × 9.81
  = 98.1 N
```

Variable names should describe the engineering quantity.

Good:

```matlab
pressure_kPa = 250;
velocity_m_s = 12;
```

Less clear:

```matlab
x = 250;
a = 12;
```

---

## Formatted Output

`fprintf` allows units and formatting to be included.

```matlab
mass = 10;
gravity = 9.81;
weight = mass*gravity;

fprintf('Weight = %.2f N\n',weight)
```

Output:

```text
Weight = 98.10 N
```

`%.2f` means display two digits after the decimal point.

---

## Built-in Mathematical Functions

```matlab
sqrt(81)               % Square root
sin(pi/6)              % Sine, angle in radians
cos(pi/3)              % Cosine
log(10)                % Natural logarithm
log10(1000)            % Base-10 logarithm
exp(2)                 % e^2
abs(-25)               % Absolute value
```

MATLAB uses `pi` directly:

```matlab
area = pi*0.5^2;
```

---

## Engineering Example 1 — Force

Equation:

```text
F = ma
```

```matlab
mass = 25;                  % kg
acceleration = 3.2;         % m/s^2

force = mass*acceleration;  % N

fprintf('Force = %.2f N\n',force)
```

---

## Engineering Example 2 — Electrical Power

Equation:

```text
P = VI
```

```matlab
voltage = 24;               % V
current = 3.5;              % A

power = voltage*current;    % W

fprintf('Power = %.2f W\n',power)
```

---

## Engineering Example 3 — Kinetic Energy

Equation:

```text
KE = 1/2 mv²
```

```matlab
mass = 1200;                % kg
velocity = 20;              % m/s

KE = 0.5*mass*velocity^2;   % J

fprintf('Kinetic energy = %.0f J\n',KE)
```

The exponent operator in MATLAB is:

```text
^
```

---

## Engineering Example 4 — Cylinder Volume

Equation:

```text
V = πr²h
```

```matlab
radius = 0.4;               % m
height = 1.5;               % m

volume = pi*radius^2*height;

fprintf('Volume = %.3f m^3\n',volume)
```

---

## Python and MATLAB Comparison

| Task | Python | MATLAB |
|---|---|---|
| Assignment | `x = 5` | `x = 5;` |
| Comment | `# text` | `% text` |
| Print | `print(x)` | `disp(x)` |
| Formatted output | `print(f"{x:.2f}")` | `fprintf('%.2f',x)` |
| Power | `x**2` | `x^2` |
| Square root | `np.sqrt(x)` | `sqrt(x)` |
| π | `np.pi` | `pi` |

The physics and mathematics do not change between languages.

---

## Common Errors

### Missing multiplication symbol

Incorrect:

```matlab
force = mass acceleration;
```

Correct:

```matlab
force = mass*acceleration;
```

### Using `**` for power

Incorrect MATLAB:

```matlab
velocity**2
```

Correct:

```matlab
velocity^2
```

### Forgetting units

A numerical result such as:

```text
98.1
```

is incomplete in engineering communication unless its meaning and unit are known.

---

## Practice

1. Calculate the pressure produced by a force of 5,000 N acting over an area of 0.02 m².
2. Calculate electrical resistance using `R = V/I` for 24 V and 3 A.
3. Calculate gravitational potential energy using `PE = mgh`.
4. Calculate the volume of a cylinder for a radius of 0.25 m and height of 2 m.
5. Display each answer using `fprintf` with an appropriate unit.

---

## Key Idea

Programming is being used to evaluate and organize engineering calculations. MATLAB syntax is a tool; the engineering equation and interpretation remain the central part of the problem.

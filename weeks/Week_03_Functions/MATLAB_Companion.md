# Week 3 — Functions for Engineering Computation

**MATLAB implementation**

A function packages a calculation into a reusable block. This is useful when the same engineering equation must be evaluated repeatedly.

## Function Structure

```matlab
function output = functionName(input)
    output = calculation;
end
```

Example:

```matlab
function weight = calculateWeight(mass,gravity)
    weight = mass*gravity;
end
```

Call the function:

```matlab
W = calculateWeight(75,9.81);
```

---

## Inputs and Outputs

For:

```text
W = mg
```

the inputs are:

- mass;
- gravitational acceleration.

The output is:

- weight.

```matlab
function weight_N = calculateWeight(mass_kg,gravity_m_s2)
    weight_N = mass_kg*gravity_m_s2;
end
```

Descriptive variable names make the function easier to interpret.

---

## Multiple Outputs

```matlab
function [area,circumference] = circleProperties(radius)
    area = pi*radius^2;
    circumference = 2*pi*radius;
end
```

Use:

```matlab
[A,C] = circleProperties(0.5);
```

---

## Engineering Example — Stress

```text
σ = F/A
```

```matlab
function stress_Pa = normalStress(force_N,area_m2)
    stress_Pa = force_N/area_m2;
end
```

Example:

```matlab
sigma = normalStress(12000,0.004);
fprintf('Stress = %.2f MPa\n',sigma/1e6)
```

---

## Engineering Example — Ohm's Law

```text
I = V/R
```

```matlab
function current_A = ohmsLaw(voltage_V,resistance_ohm)
    current_A = voltage_V/resistance_ohm;
end
```

---

## Engineering Example — Cylinder Volume

```matlab
function volume_m3 = cylinderVolume(radius_m,height_m)
    volume_m3 = pi*radius_m^2*height_m;
end
```

---

## Local Functions in a Script

MATLAB allows local functions at the end of a script.

```matlab
%% Main calculation

F = calculateForce(12,4.5);
fprintf('Force = %.2f N\n',F)

%% Local function

function force_N = calculateForce(mass_kg,acceleration_m_s2)
    force_N = mass_kg*acceleration_m_s2;
end
```

The script code appears first, followed by the local function.

---

## Anonymous Functions

A short one-line function can be written using `@`.

```matlab
area = @(r) pi*r.^2;

A = area(0.5);
```

Another example:

```matlab
fahrenheit = @(C) (9/5).*C + 32;
```

---

## Python and MATLAB Comparison

| Concept | Python | MATLAB |
|---|---|---|
| Define function | `def f(x):` | `function y = f(x)` |
| Return result | `return y` | output variable `y` |
| End block | indentation | `end` |
| Multiple outputs | `return a,b` | `function [a,b] = f(x)` |
| Short function | `lambda x: ...` | `@(x) ...` |

---

## Common Errors

### Function name and filename

When a function is stored in its own file, the filename should normally match the main function name.

Example:

```text
calculateWeight.m
```

for:

```matlab
function weight = calculateWeight(...)
```

### Output never assigned

Incorrect:

```matlab
function result = squareValue(x)
    x^2;
end
```

Correct:

```matlab
function result = squareValue(x)
    result = x^2;
end
```

---

## Practice

Create MATLAB functions for:

1. density, `ρ = m/V`;
2. electrical power, `P = VI`;
3. pressure, `P = F/A`;
4. kinetic energy, `KE = 1/2 mv²`;
5. Celsius-to-Fahrenheit conversion;
6. Reynolds number, `Re = ρVD/μ`.

---

## Key Idea

Functions make engineering calculations reusable, testable, and easier to organize.

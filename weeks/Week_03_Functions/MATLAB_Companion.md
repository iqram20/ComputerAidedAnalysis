# Week 3 MATLAB Companion — Functions

Functions allow engineering calculations to be reused.

## Basic function
```matlab
function weight = calculateWeight(mass,gravity)
    weight = mass*gravity;          % Return weight in N
end
```

Example call:
```matlab
W = calculateWeight(75,9.81);
```

## Function with two outputs
```matlab
function [area,circumference] = circleProperties(radius)
    area = pi*radius^2;
    circumference = 2*pi*radius;
end
```

Example:
```matlab
[A,C] = circleProperties(0.5);
```

## Engineering example — Ohm's law
```matlab
function current = ohmsLaw(voltage,resistance)
    current = voltage/resistance;
end
```

## Python → MATLAB
| Python | MATLAB |
|---|---|
| `def f(x):` | `function y = f(x)` |
| `return y` | output variable in function definition |
| indentation defines block | `end` closes function |

MATLAB functions are commonly placed at the end of a script or saved in their own `.m` file.

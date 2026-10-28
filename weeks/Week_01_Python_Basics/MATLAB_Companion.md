# Week 1 MATLAB Companion — Basics and Engineering Calculations

This page shows the MATLAB equivalent of the Week 1 Python ideas.

## MATLAB Online
Open: https://matlab.mathworks.com/

## Basic calculations
```matlab
2 + 3                  % Addition
10 - 4                 % Subtraction
6 * 5                  % Multiplication
20 / 4                 % Division
2^3                    % Power
sqrt(25)               % Square root
```

## Variables
```matlab
mass = 10;             % Mass in kg
gravity = 9.81;        % Gravitational acceleration in m/s^2
weight = mass*gravity; % Calculate weight in N
fprintf('Weight = %.2f N\n',weight)
```

## Engineering example — kinetic energy
```matlab
m = 1200;              % Vehicle mass in kg
v = 20;                % Speed in m/s
KE = 0.5*m*v^2;        % Kinetic energy in joules
fprintf('KE = %.0f J\n',KE)
```

## Python → MATLAB
| Python | MATLAB |
|---|---|
| `print(x)` | `disp(x)` or `fprintf(...)` |
| `x ** 2` | `x^2` |
| `math.sqrt(x)` | `sqrt(x)` |
| `# comment` | `% comment` |

The engineering equation is the same. Only the programming syntax changes.

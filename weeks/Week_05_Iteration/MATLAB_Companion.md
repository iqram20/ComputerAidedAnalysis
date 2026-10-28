# Week 5 — Iteration and Engineering Simulations
## How to Use This Lecture Page

Work through the material the same way you would use a Colab notebook:

1. Read the short explanation.
2. Run the small MATLAB code block.
3. Inspect the output or figure.
4. Read the interpretation before moving to the next step.

Keep each code step small. In MATLAB Live Editor, these blocks can be placed in separate sections so they can be run one at a time.

---


**MATLAB implementation**

Iteration repeats a calculation. It is useful when engineering calculations must be performed for many values or repeatedly over time.

## for Loop

```matlab
for i = 1:5
    fprintf('Iteration %d\n',i)
end
```

The loop variable `i` takes the values:

```text
1, 2, 3, 4, 5
```

---

## Engineering Example — Velocity Table

For constant acceleration:

```text
v = at
```

```matlab
acceleration = 3;                  % m/s^2

for t = 0:10
    velocity = acceleration*t;
    fprintf('t = %2d s, v = %5.1f m/s\n',t,velocity)
end
```

---

## Store Results in an Array

```matlab
time = 0:1:10;
velocity = zeros(size(time));

for i = 1:length(time)
    velocity(i) = 9.81*time(i);
end

plot(time,velocity)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
grid on
```

`zeros(size(time))` creates storage before the loop.

This is called **preallocation** and is good MATLAB practice.

---

## while Loop

A `while` loop repeats while a condition remains true.

```matlab
temperature = 20;

while temperature < 80
    temperature = temperature + 10;
    fprintf('Temperature = %.1f C\n',temperature)
end
```

---

## Engineering Example — Tank Filling

```matlab
volume = 0;               % L
flow_rate = 12;           % L/min
minutes = 0;

while volume < 500
    volume = volume + flow_rate;
    minutes = minutes + 1;
end

fprintf('Tank reaches 500 L after %d min\n',minutes)
```

The final value may exceed 500 L because the simulation updates in discrete time steps.

---

## break

`break` exits a loop immediately.

```matlab
measurements = [20 25 30 35 105 40];

for i = 1:length(measurements)
    if measurements(i) > 100
        fprintf('Critical reading found at index %d\n',i)
        break
    end
end
```

---

## continue

`continue` skips the remainder of the current iteration.

```matlab
data = [12 NaN 15 18 NaN 20];

for i = 1:length(data)
    if isnan(data(i))
        continue
    end
    fprintf('Valid value = %.1f\n',data(i))
end
```

---

## Loop or Vectorized Calculation?

Loop:

```matlab
for i = 1:length(time)
    velocity(i) = 9.81*time(i);
end
```

Vectorized:

```matlab
velocity = 9.81*time;
```

Both can be correct.

MATLAB often allows concise vectorized calculations, but loops remain important for algorithms with changing states, decisions, or simulations.

---

## Python and MATLAB Comparison

| Python | MATLAB |
|---|---|
| `for i in range(5):` | `for i = 1:5` |
| `while condition:` | `while condition` |
| `break` | `break` |
| `continue` | `continue` |
| `range(1,11)` | `1:10` |
| indentation | `end` |

---

## Common Errors

### Infinite while loop

If the condition never becomes false, the loop does not stop.

Example:

```matlab
while temperature < 80
    disp(temperature)
end
```

Here `temperature` never changes.

### Wrong index range

MATLAB indexing begins at 1.

---

## Practice

1. Generate a table of electrical power for current values from 1 A to 10 A using `P = I²R`.
2. Use a loop to calculate free-fall velocity from 0 to 10 s.
3. Simulate a tank filling at a constant flow rate.
4. Count how many sensor readings exceed a safety threshold.
5. Simulate cooling by reducing temperature each minute until it falls below 40°C.

---

## Key Idea

Loops automate repeated calculations. Vectorization is useful for simple array calculations, while loops are especially useful for state-based engineering simulations.

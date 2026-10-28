# Week 4 — Branching and Engineering Decision Logic

**MATLAB implementation**

Branching allows a program to choose different actions based on engineering conditions.

## Boolean Comparisons

```matlab
temperature > 80
pressure <= 200
speed == 0
temperature ~= 25
```

Comparison operators:

| Meaning | MATLAB |
|---|---|
| Greater than | `>` |
| Less than | `<` |
| Greater/equal | `>=` |
| Less/equal | `<=` |
| Equal | `==` |
| Not equal | `~=` |

---

## if Statement

```matlab
temperature = 95;

if temperature > 80
    disp("Temperature is high")
end
```

---

## if / elseif / else

```matlab
temperature = 95;

if temperature > 100
    status = "Critical";
elseif temperature > 80
    status = "Warning";
else
    status = "Normal";
end

disp(status)
```

The conditions are checked from top to bottom.

---

## Logical Operators

MATLAB uses:

| Logic | MATLAB |
|---|---|
| AND | `&&` |
| OR | `||` |
| NOT | `~` |

Example:

```matlab
temperature = 90;
pressure = 180;

if temperature > 80 && pressure > 150
    disp("Inspection required")
end
```

---

## Engineering Example — Structural Stress Check

```matlab
stress = 180;            % MPa
allowable = 250;         % MPa

if stress <= allowable
    status = "Within allowable stress";
else
    status = "Unsafe condition";
end

disp(status)
```

---

## Engineering Example — Battery Condition

```matlab
battery_voltage = 12.4;

if battery_voltage < 11.5
    status = "Low";
elseif battery_voltage <= 13.0
    status = "Normal";
else
    status = "High";
end

fprintf('Battery status: %s\n',status)
```

---

## Engineering Example — Multiple Conditions

A pump requires inspection when temperature is high **or** vibration is excessive.

```matlab
temperature = 88;        % C
vibration = 6.2;         % mm/s

if temperature > 85 || vibration > 5
    status = "Inspect";
else
    status = "Normal";
end

disp(status)
```

---

## Nested Conditions

```matlab
temperature = 95;
pressure = 220;

if temperature > 80
    if pressure > 200
        disp("High temperature and high pressure")
    else
        disp("High temperature only")
    end
else
    disp("Temperature normal")
end
```

Nested branching is useful, but very complicated nested logic can become difficult to maintain.

---

## Python and MATLAB Comparison

| Python | MATLAB |
|---|---|
| `if x > 5:` | `if x > 5` |
| `elif` | `elseif` |
| `else:` | `else` |
| `and` | `&&` |
| `or` | `||` |
| `not` | `~` |
| indentation | `end` |

---

## Common Errors

### Assignment instead of comparison

Incorrect:

```matlab
if x = 5
```

Correct:

```matlab
if x == 5
```

### Missing `end`

Every `if` block must be closed with:

```matlab
end
```

---

## Practice

1. Classify pressure as Normal, Warning, or Critical.
2. Determine whether a measured stress is below an allowable stress.
3. Classify battery voltage as Low, Normal, or High.
4. Create a rule that requires inspection when either vibration or temperature exceeds its limit.
5. Create a rule that shuts down a system only when both pressure and temperature are critical.

---

## Key Idea

Branching translates engineering decision rules into executable logic.

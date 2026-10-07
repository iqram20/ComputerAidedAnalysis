# MATLAB Usage Guide for Students

## 1. Ways to Run MATLAB

You can use MATLAB in any of the following ways:

### Option A — MATLAB Desktop
Use MATLAB installed on your computer.

Typical workflow:
1. Open MATLAB.
2. Navigate to the folder containing your course files.
3. Open the `.m` file.
4. Click **Run** to execute the entire script.
5. Use **Run Section** to execute one section at a time.

### Option B — MATLAB Online
MATLAB Online runs in a web browser and is often the easiest option for students who do not want to install MATLAB.

General workflow:
1. Open MATLAB Online.
2. Sign in with your MathWorks account.
3. Upload the `.m` file from the course GitHub repository.
4. Open the file in the MATLAB Editor.
5. Click **Run** or **Run Section**.
6. View variables in the Workspace and figures in the plot window.

### Option C — MATLAB Live Editor
MATLAB Live Editor allows code, equations, formatted text, figures, and results to appear together.

Live Script file extension:

```
.mlx
```

This is useful for reports, demonstrations, and assignments that require explanation together with code.

---

## 2. MATLAB Interface

The main MATLAB environment contains several important areas.

### Command Window
Used to run individual MATLAB commands.

Example:

```matlab
2 + 3
```

or

```matlab
sqrt(81)
```

### Editor
Used to write and save MATLAB scripts and functions.

Script files use:

```
.m
```

Example:

```
engineering_example.m
```

### Workspace
Shows variables currently stored in memory.

For example, after running:

```matlab
mass = 25;
velocity = 10;
```

the Workspace will show `mass` and `velocity`.

### Current Folder
Shows files in the folder MATLAB is currently using.

Your script and supporting files should usually be placed in this folder.

---

## 3. Creating a New MATLAB Script

1. Open MATLAB.
2. Click **New Script**.
3. Type your MATLAB code.
4. Save the file using a meaningful name.

Example:

```
week11_practice.m
```

MATLAB script names should:
- avoid spaces;
- begin with a letter;
- use meaningful names;
- preferably use underscores instead of spaces.

Good:

```
beam_stress_analysis.m
```

Avoid:

```
my file 1.m
```

---

## 4. Running MATLAB Code

### Run the Entire Script

Click:

**Run**

or enter the script name in the Command Window without `.m`.

Example:

If the file is:

```
beam_stress_analysis.m
```

type:

```matlab
beam_stress_analysis
```

### Run Only One Section

MATLAB sections begin with:

```matlab
%%
```

Example:

```matlab
%% Calculate force

mass = 10;
acceleration = 3;
force = mass * acceleration;
```

Place the cursor inside the section and click **Run Section**.

For the Week 11 course file, running one section at a time is recommended.

---

## 5. Comments in MATLAB

Use `%` for comments.

Example:

```matlab
mass = 10;       % kg
velocity = 5;    % m/s
```

Use comments to explain:
- engineering units;
- assumptions;
- important calculations;
- purpose of code sections.

---

## 6. Semicolons

A semicolon prevents MATLAB from displaying a result automatically.

Without semicolon:

```matlab
x = 5
```

MATLAB displays:

```
x =

     5
```

With semicolon:

```matlab
x = 5;
```

the value is stored but not automatically printed.

For larger programs, semicolons help keep the Command Window clean.

---

## 7. Displaying Results

### disp()

```matlab
force = 120;

disp(force)
```

### fprintf()

Use `fprintf` when you want formatted engineering output.

```matlab
force = 120.456;

fprintf('Force = %.2f N\n', force);
```

Output:

```
Force = 120.46 N
```

---

## 8. MATLAB Variables

MATLAB variables do not require a type declaration.

Example:

```matlab
mass = 20;
temperature = 75.5;
material = 'Steel';
```

Variable names should be descriptive.

Better:

```matlab
pressure_kPa = 520;
```

Less clear:

```matlab
x = 520;
```

---

## 9. Vectors

### Row Vector

```matlab
velocity = [2 4 6 8 10];
```

### Column Vector

```matlab
velocity = [2; 4; 6; 8; 10];
```

### Colon Operator

```matlab
x = 0:2:10;
```

creates:

```
0  2  4  6  8  10
```

### linspace

```matlab
x = linspace(0, 10, 6);
```

creates six equally spaced values from 0 to 10.

---

## 10. Matrices

Create a matrix using spaces between columns and semicolons between rows.

```matlab
A = [1 2 3;
     4 5 6;
     7 8 9];
```

Access an element:

```matlab
A(2,3)
```

This means:

row 2, column 3.

MATLAB indexing begins at **1**.

---

## 11. Selecting Rows and Columns

Entire second row:

```matlab
A(2,:)
```

Entire third column:

```matlab
A(:,3)
```

First two rows:

```matlab
A(1:2,:)
```

---

## 12. Matrix Operations vs Element-by-Element Operations

This is one of the most important MATLAB topics.

### Matrix Multiplication

```matlab
A * B
```

### Element-by-Element Multiplication

```matlab
A .* B
```

### Matrix Power

```matlab
A^2
```

### Element-by-Element Power

```matlab
A.^2
```

### Matrix Division

```matlab
A / B
```

### Element-by-Element Division

```matlab
A ./ B
```

For engineering vectors, you will frequently use:

```
.*
./
.^
```

Example:

```matlab
velocity = [2 4 6 8];

KE = 0.5 * 5 .* velocity.^2;
```

---

## 13. Clearing MATLAB

Clear variables:

```matlab
clear
```

Clear the Command Window:

```matlab
clc
```

Close figures:

```matlab
close all
```

Common script beginning:

```matlab
clear
clc
close all
```

Use this carefully. During debugging, clearing everything can make it harder to inspect variables.

---

## 14. Basic Plotting

Example:

```matlab
t = 0:0.1:10;
v = 3 .* t;

plot(t, v)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity vs Time')
grid on
```

Always include:
- x-axis label;
- y-axis label;
- engineering units;
- descriptive title.

---

## 15. Multiple Curves

```matlab
t = 0:0.1:5;

y1 = sin(t);
y2 = cos(t);

plot(t, y1)
hold on
plot(t, y2)
hold off

legend('sin(t)', 'cos(t)')
grid on
```

---

## 16. Branching

Example:

```matlab
temperature = 85;

if temperature < 70
    status = 'Normal';
elseif temperature <= 90
    status = 'Warning';
else
    status = 'Critical';
end

disp(status)
```

MATLAB requires:

```
end
```

to close an `if`, loop, or function block.

---

## 17. for Loops

Example:

```matlab
for t = 0:5
    velocity = 3 * t;
    fprintf('t = %d s, v = %.1f m/s\n', t, velocity);
end
```

---

## 18. while Loops

Example:

```matlab
volume = 0;
minutes = 0;

while volume < 500
    volume = volume + 12;
    minutes = minutes + 1;
end

fprintf('Time = %d minutes\n', minutes);
```

---

## 19. Functions

A simple function:

```matlab
function F = calculate_force(mass, acceleration)

    F = mass * acceleration;

end
```

Call the function:

```matlab
F = calculate_force(10, 4);
```

A function can also return multiple outputs:

```matlab
function [area, volume] = cylinder_properties(r, h)

    area = 2*pi*r^2 + 2*pi*r*h;
    volume = pi*r^2*h;

end
```

Call it with:

```matlab
[A, V] = cylinder_properties(2, 5);
```

---

## 20. Common MATLAB Errors

### Undefined function or variable

Example:

```
Unrecognized function or variable 'mass'
```

Possible causes:
- variable was never created;
- variable name was misspelled;
- script section was not run.

### Matrix dimensions do not agree

Often caused by using:

```
*
```

when you intended:

```
.*
```

### Incorrect indexing

MATLAB indexing begins at 1.

This is invalid:

```matlab
A(0)
```

### Missing end

MATLAB requires `end` for:
- `if`,
- `for`,
- `while`,
- functions in many contexts.

---

## 21. Debugging Tips

When code does not work:

1. Read the complete MATLAB error message.
2. Look at the highlighted line.
3. Check variable names.
4. Check dimensions using:

```matlab
size(A)
```

5. Check variables using:

```matlab
whos
```

6. Run the script one section at a time.
7. Display intermediate values using `disp()` or `fprintf()`.

---

## 22. Saving Figures

You can save a plot from the figure window or with MATLAB code.

Example:

```matlab
saveas(gcf, 'velocity_plot.png')
```

or:

```matlab
exportgraphics(gcf, 'velocity_plot.png', 'Resolution', 300)
```

---

## 23. Recommended File Organization

For an assignment:

```
Week11_Assignment/
│
├── week11_assignment.m
├── figures/
│   ├── voltage_current.png
│   ├── pressure_depth.png
│   └── projectile_motion.png
└── report.pdf
```

Use meaningful filenames.

---

## 24. How to Use the Week 11 Course File

Course MATLAB file:

```
MATLAB_Basics_Engineering_Examples.m
```

Recommended steps:

1. Download the file from GitHub.
2. Open MATLAB or MATLAB Online.
3. Open the `.m` file.
4. Start with the first section.
5. Click **Run Section**.
6. Read the comments.
7. Examine the Workspace.
8. Modify example values.
9. Complete each guided exercise in the corresponding section.
10. Save your own copy before editing.

---

## 25. MATLAB Online Workflow

A simple workflow for this class:

1. Download the course `.m` file from GitHub.
2. Open MATLAB Online.
3. Upload the file.
4. Open it in the Editor.
5. Run one section at a time.
6. Complete practice directly in your own copy.
7. Download your completed `.m` file for submission if required.

---

## 26. MATLAB vs Python — Important Differences

| MATLAB | Python |
|---|---|
| Indexing starts at 1 | Indexing starts at 0 |
| `A(2,3)` | `A[1,2]` |
| `A.^2` | `A**2` with NumPy |
| `A.*B` | `A*B` with NumPy arrays |
| `elseif` | `elif` |
| blocks close with `end` | blocks use indentation |
| `% comment` | `# comment` |

Students switching between Python and MATLAB should pay particular attention to indexing and array operators.

---

## 27. Good MATLAB Coding Practices

- Use descriptive variable names.
- Include units in comments or variable names.
- Use sections `%%` for long scripts.
- Avoid unnecessary loops when vectorized operations are simple.
- Label every engineering plot.
- Do not manually type results that MATLAB can calculate.
- Test functions with more than one input.
- Check dimensions before matrix operations.
- Keep raw data separate from calculated results.
- Save your work frequently.

---

## 28. Before Submitting MATLAB Work

Check that:

- the script runs from beginning to end;
- no unresolved errors remain;
- figures are labeled;
- units are shown;
- functions are included;
- all requested problems are completed;
- your name is included in the script comments;
- files use clear names;
- the submitted script is your final version.

# MATLAB Usage Instructions for BMCC Students

**ESC 113: Computer Aided Analysis for Engineering**

This page is written for students who are new to MATLAB. It explains where to run MATLAB code, how to open course files, how to run one section at a time, how to read outputs, and what to do when errors appear.

---

## 1. Where Can I Use MATLAB?

BMCC students can use MATLAB in two main ways.

### Option A — MATLAB Online

MATLAB Online runs in a web browser.

Use it if:
- MATLAB is not installed on your computer;
- you are using a Chromebook;
- you are working from a campus computer;
- you want the easiest setup.

General workflow:

1. Open MATLAB Online.
2. Sign in with your MathWorks account.
3. Upload the course `.m` file.
4. Open the file in the Editor.
5. Run one section at a time.
6. Save your work.

### Option B — MATLAB Desktop

Use MATLAB Desktop if MATLAB is already installed on your computer.

General workflow:

1. Open MATLAB.
2. Go to the folder containing your course file.
3. Open the `.m` file.
4. Run the code one section at a time.

---

## 2. What Is a MATLAB .m File?

A file ending in:

```
.m
```

is a MATLAB script or function file.

Example:

```
Week_08_Classification_MATLAB.m
```

You can open it in MATLAB and run the code.

---

## 3. Main MATLAB Windows

### Editor

This is where you read and write code.

### Command Window

This is where MATLAB prints results and where you can type commands directly.

Example:

```matlab
2 + 3
```

### Workspace

This shows variables currently stored in memory.

Examples:

```
Xtrain
Xtest
ytrain
ypred
```

### Current Folder

This shows the files MATLAB can currently access.

If MATLAB cannot find your script or data file, check the Current Folder first.

### Figure Window

Plots and charts appear here.

Examples:
- class distribution
- confusion matrix
- scatter plots
- line plots

---

## 4. How to Open the Course MATLAB File

For Week 8, open:

```
Week_08_Classification_MATLAB.m
```

In MATLAB Online:

1. Upload the file.
2. Double-click the file.
3. It opens in the Editor.

In MATLAB Desktop:

1. Save the file on your computer.
2. Open MATLAB.
3. Use the Current Folder window to locate the file.
4. Double-click it.

---

## 5. Run One Section at a Time

MATLAB sections begin with:

```matlab
%%
```

Example:

```matlab
%% Load Data

X = readmatrix("data.csv");
```

Place your cursor inside the section and click:

**Run Section**

This is the recommended method for this course.

Why?

Because it lets you:
- see what each block of code does;
- inspect outputs;
- find errors more easily;
- avoid running too much code at once.

---

## 6. Do Not Run the Entire File Immediately

For beginner students, do not press **Run** on the full file before understanding the sections.

Recommended sequence:

> Read section → Run section → inspect output → continue

This makes debugging much easier.

---

## 7. Read the Right-Side Comments

Course MATLAB code includes comments such as:

```matlab
Xtrain = X(trainIdx,:);      % Select training feature rows
```

Everything after:

```
%
```

is a comment.

MATLAB does not execute comments.

Comments explain what the line does.

---

## 8. Useful Commands

### Show variables

```matlab
whos
```

### Check matrix size

```matlab
size(Xtrain)
```

### Show first rows of a table

```matlab
head(T)
```

### Show class categories

```matlab
categories(ytrain)
```

### Clear Command Window

```matlab
clc
```

### Clear variables

```matlab
clear
```

### Close figures

```matlab
close all
```

---

## 9. MATLAB Indexing Starts at 1

This is different from Python.

MATLAB:

```matlab
A(1)
```

means the first element.

Python:

```python
A[0]
```

means the first element.

This difference is very important.

---

## 10. Rows and Columns

MATLAB uses:

```matlab
A(row, column)
```

Example:

```matlab
A(2,3)
```

means:

> row 2, column 3

All rows from column 3:

```matlab
A(:,3)
```

All columns from row 2:

```matlab
A(2,:)
```

---

## 11. Element-by-Element Operations

MATLAB distinguishes matrix operations from element-by-element operations.

### Multiplication

Matrix multiplication:

```matlab
A * B
```

Element-by-element:

```matlab
A .* B
```

### Division

Matrix division:

```matlab
A / B
```

Element-by-element:

```matlab
A ./ B
```

### Powers

Matrix power:

```matlab
A^2
```

Element-by-element:

```matlab
A.^2
```

For engineering vectors, you will often use:

```
.*
./
.^
```

---

## 12. Required Toolbox for Week 8

Week 8 classification uses the:

**Statistics and Machine Learning Toolbox**

Functions include:

```matlab
cvpartition
templateLinear
fitcecoc
confusionchart
```

To see installed toolboxes:

```matlab
ver
```

Look for:

```
Statistics and Machine Learning Toolbox
```

---

## 13. Common Error: Variable Not Found

Example:

```
Unrecognized function or variable 'Xtrain'
```

Possible reason:

You skipped the section that creates `Xtrain`.

Fix:

1. Go to the previous section.
2. Run it.
3. Then return to the current section.

---

## 14. Common Error: File Not Found

Example:

```
Unable to find file
```

Check:
- Current Folder;
- filename spelling;
- file extension;
- whether the file was uploaded.

Useful command:

```matlab
pwd
```

This shows your current working folder.

---

## 15. Common Error: Toolbox Function Not Found

Example:

```
Unrecognized function 'fitcecoc'
```

Possible reason:

Statistics and Machine Learning Toolbox is not available.

Check:

```matlab
ver
```

---

## 16. Common Error: Matrix Dimensions Do Not Agree

This often happens when arrays have incompatible sizes.

Check:

```matlab
size(A)
size(B)
```

If you intended element-by-element multiplication, check whether you should use:

```matlab
.*
```

instead of:

```matlab
*
```

---

## 17. Use the Workspace During Class

After running a section, look at the Workspace.

You may see:

```
Xtrain
Xtest
ytrain
ytest
ypred
C
```

Double-click a variable to inspect it.

This is useful for understanding what the code created.

---

## 18. How to Save Your Work

Use:

**File → Save**

or press:

```
Ctrl + S
```

Save your own copy before making major changes.

Recommended filename:

```
LastName_Week08_Classification.m
```

Example:

```
Hussain_Week08_Classification.m
```

---

## 19. How to Save a Figure

You can save a figure manually from the Figure window.

Or use:

```matlab
exportgraphics(gcf,"confusion_matrix.png","Resolution",300)
```

This saves the current figure.

---

## 20. How to Submit MATLAB Work

Unless your instructor gives different instructions, submit:

- your final `.m` file;
- required plots;
- short answers or report if requested.

Before submitting, check:

- code runs without errors;
- your name is included;
- figures are labeled;
- units are included;
- all questions are completed;
- comments are readable.

---

## 21. Recommended Header for Student Scripts

At the top of your MATLAB file:

```matlab
%% ESC 113 - Week 8 Classification
% Name: Your Name
% Date:
% Course: ESC 113
% Instructor: Iqram Hussain
```

---

## 22. MATLAB Online Tips for BMCC Students

MATLAB Online is usually the easiest option when working from different computers.

Remember:

- uploaded files are stored in your MATLAB Drive;
- always confirm that you are editing the correct file;
- save often;
- run sections in order;
- keep your browser tab open while working;
- download a final copy if you want a backup.

---

## 23. If the Dataset Downloads Automatically

Some course scripts download public data from the internet.

For Week 8, the MATLAB script downloads the UCI Steel Plates Faults dataset automatically.

If it fails:

1. confirm internet access;
2. run the download section again;
3. check the Current Folder;
4. confirm the ZIP file was created;
5. run the unzip section.

---

## 24. Best Workflow for This Course

Use this every time:

1. Read the section title.
2. Read the explanation.
3. Read the code comments.
4. Run the section.
5. Look at the Command Window.
6. Look at the Workspace.
7. Look at any figure.
8. Answer the exercise or question.
9. Continue to the next section.

---

## 25. MATLAB vs Python Quick Reference

| Task | MATLAB | Python |
|---|---|---|
| First element | `A(1)` | `A[0]` |
| Comment | `% text` | `# text` |
| Element multiply | `A.*B` | `A*B` with NumPy arrays |
| Power | `A.^2` | `A**2` |
| Else-if | `elseif` | `elif` |
| End block | `end` | indentation |
| Matrix dimensions | `size(A)` | `A.shape` |
| Display variable | `disp(A)` | `print(A)` |

---

## 26. Most Important Advice

Do not try to memorize every MATLAB command.

Instead, understand:

- what data you have;
- what each variable represents;
- what each section is trying to do;
- what the output means physically.

For ESC 113, the goal is:

> **Understand the engineering problem first, then use MATLAB as the computational tool.**

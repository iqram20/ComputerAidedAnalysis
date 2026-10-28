# Week 2 MATLAB Companion — Arrays, Vectors, and Matrices

MATLAB is designed around vectors and matrices, so many NumPy ideas have direct MATLAB equivalents.

## Vectors
```matlab
temperature = [20 22 24 27 30];   % Row vector
temperature(1)                     % First value
temperature(2:4)                   % Values 2 through 4
```

MATLAB indexing starts at **1**, not 0.

## Column vector
```matlab
force = [10; 20; 30; 40];          % Column vector
```

## Matrix
```matlab
A = [1 2 3; 4 5 6; 7 8 9];        % 3-by-3 matrix
A(2,3)                              % Row 2, column 3
A(:,2)                              % Entire column 2
A(1,:)                              % Entire row 1
```

## Element-by-element calculations
```matlab
x = [1 2 3 4];
y = x.^2;                           % Square every element
z = x.*5;                           % Multiply every element by 5
```

## Useful commands
```matlab
length(x)
size(A)
mean(temperature)
max(temperature)
min(temperature)
```

## NumPy → MATLAB
| NumPy/Python | MATLAB |
|---|---|
| `np.array([1,2,3])` | `[1 2 3]` |
| `A.shape` | `size(A)` |
| `A[0]` | `A(1)` |
| `A[:,1]` | `A(:,2)` |
| `A**2` | `A.^2` |

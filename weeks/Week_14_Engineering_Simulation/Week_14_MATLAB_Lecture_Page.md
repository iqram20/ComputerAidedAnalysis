# Week 14 — Engineering Simulation and Computational Modeling

**MATLAB implementation**

## How to Use This Lecture Page

Use this page like a Colab notebook:

1. Read one short explanation.
2. Run the small MATLAB block below it.
3. Inspect the result or plot.
4. Read the engineering interpretation.
5. Continue to the next step.

---

# What Is a Simulation?

A simulation converts a mathematical model into a sequence of numerical calculations.

A common structure is:

```text
Initial condition
      ↓
Calculate rate of change
      ↓
Advance one time step
      ↓
Store new state
      ↓
Repeat
```

---

# Euler Method

Consider:

```text
dy/dt = -0.5y
```

The Euler update is:

```text
y(next) = y(current) + Δt × dy/dt
```

---

## Step 1 — Define Time

```matlab
dt = 0.1;
t = 0:dt:10;
```

`dt` is the simulation time step.

---

## Step 2 — Allocate the State

```matlab
y = zeros(size(t));
y(1) = 1;
```

The initial condition is:

```text
y(0) = 1
```

---

## Step 3 — Advance the Simulation

```matlab
for i = 1:length(t)-1
    dydt = -0.5*y(i);
    y(i+1) = y(i) + dt*dydt;
end
```

Each iteration calculates the rate of change and updates the state.

---

## Step 4 — Plot the Result

```matlab
plot(t,y)
xlabel('Time')
ylabel('y')
grid on
```

The state decreases over time because the rate of change is negative.

---

# Falling Object with Linear Drag

The governing equation is:

```text
dv/dt = g - (c/m)v
```

---

## Step 5 — Define Physical Parameters

```matlab
m = 80;      % kg
c = 12;      % drag coefficient
g = 9.81;    % m/s^2
```

---

## Step 6 — Create Time and Velocity Arrays

```matlab
dt = 0.05;
t = 0:dt:30;

v = zeros(size(t));
```

---

## Step 7 — Simulate Velocity

```matlab
for i = 1:length(t)-1
    dvdt = g-(c/m)*v(i);
    v(i+1) = v(i)+dt*dvdt;
end
```

---

## Step 8 — Compare with Terminal Velocity

Analytical terminal velocity is:

```text
v_terminal = mg/c
```

Calculate it.

```matlab
v_terminal = m*g/c;
```

Compare:

```matlab
fprintf('Simulated final velocity = %.2f m/s\n',v(end))
fprintf('Analytical terminal velocity = %.2f m/s\n',v_terminal)
```

This is a **verification check**.

---

# Cooling Simulation

Newton's cooling model is:

```text
dT/dt = -k(T - Tamb)
```

---

## Step 9 — Define Cooling Parameters

```matlab
T0 = 95;
Tamb = 22;
k = 0.08;
```

---

## Step 10 — Initialize Temperature

```matlab
dt = 0.1;
t = 0:dt:60;

T = zeros(size(t));
T(1) = T0;
```

---

## Step 11 — Simulate Cooling

```matlab
for i = 1:length(t)-1
    dTdt = -k*(T(i)-Tamb);
    T(i+1) = T(i)+dt*dTdt;
end
```

---

## Step 12 — Plot Temperature

```matlab
plot(t,T)
xlabel('Time (min)')
ylabel('Temperature (°C)')
grid on
```

The temperature approaches ambient temperature over time.

---

# RC Circuit Simulation

For capacitor charging:

```text
dV/dt = (Vs - V)/(RC)
```

---

## Step 13 — Define Circuit Parameters

```matlab
Vs = 12;
R = 1000;
C = 0.001;
```

---

## Step 14 — Initialize the Simulation

```matlab
dt = 0.01;
t = 0:dt:6;

V = zeros(size(t));
```

---

## Step 15 — Euler Simulation

```matlab
for i = 1:length(t)-1
    dVdt = (Vs-V(i))/(R*C);
    V(i+1) = V(i)+dt*dVdt;
end
```

---

## Step 16 — Analytical Solution

```matlab
Vexact = Vs*(1-exp(-t/(R*C)));
```

---

## Step 17 — Compare Numerical and Analytical Results

```matlab
plot(t,V)
hold on
plot(t,Vexact,'--')
hold off
legend('Euler','Analytical')
xlabel('Time (s)')
ylabel('Voltage (V)')
grid on
```

Agreement between the numerical and analytical curves helps verify the implementation.

---

# Tank Simulation

Net flow:

```text
dV/dt = Qin - Qout
```

---

## Step 18 — Define Tank Parameters

```matlab
Qin = 18;
Qout = 12;
capacity = 500;
```

---

## Step 19 — Initialize Tank Volume

```matlab
dt = 1;
t = 0:dt:120;

volume = zeros(size(t));
volume(1) = 100;
```

---

## Step 20 — Simulate Until Capacity

```matlab
for i = 1:length(t)-1
    volume(i+1) = volume(i)+dt*(Qin-Qout);

    if volume(i+1) >= capacity
        volume(i+1:end) = capacity;
        break
    end
end
```

The `if` statement adds a physical constraint: tank volume cannot exceed capacity.

---

# Parameter Study

A parameter study asks:

> How does the model output change when an input parameter changes?

For cooling, vary `k`.

---

## Step 21 — Define Several Values

```matlab
k_values = [0.03 0.05 0.08 0.12];
```

---

## Step 22 — Simulate Each Case

```matlab
for k = k_values
    T = zeros(size(t));
    T(1) = 95;

    for i = 1:length(t)-1
        T(i+1) = T(i)+dt*(-k*(T(i)-22));
    end

    plot(t,T,'DisplayName',['k=' num2str(k)])
    hold on
end
```

Finish the figure.

```matlab
hold off
legend
xlabel('Time')
ylabel('Temperature')
grid on
```

A larger cooling constant produces faster convergence toward ambient temperature.

---

# Time-Step Sensitivity

A numerical solution depends on the time step.

Compare:

```matlab
dt1 = 1.0;
dt2 = 0.1;
dt3 = 0.01;
```

Smaller time steps generally improve numerical resolution, but increase computation.

A simulation should not use an arbitrary time step without checking sensitivity.

---

# Verification vs Validation

**Verification**

> Did we solve the equations correctly?

Examples:

- compare with an analytical solution;
- reduce the time step;
- check conservation or known limiting behavior.

**Validation**

> Does the model adequately represent the real physical system?

Examples:

- compare with experiments;
- compare with measured sensor data;
- check assumptions against real operating conditions.

---

# Python and MATLAB Comparison

| Task | Python | MATLAB |
|---|---|---|
| Time vector | `np.arange` | colon operator |
| Allocate zeros | `np.zeros` | `zeros` |
| Loop | `for i in range(...)` | `for i = ...` |
| Exponential | `np.exp` | `exp` |
| Plot | `plt.plot` | `plot` |
| Break loop | `break` | `break` |

The governing equation and numerical method should be identical in both languages.

---

# Common Errors

## Time step too large

The numerical solution can become inaccurate or unstable.

## Units are inconsistent

For example, seconds and minutes should not be mixed without conversion.

## Initial condition is missing

A dynamic simulation cannot begin without an initial state.

## No physical constraints

A model may produce impossible values unless boundaries are implemented.

## No verification

A plot that looks smooth is not proof that the model is correct.

---

# Guided Practice

1. Change the Euler time step and compare solutions.
2. Increase the drag coefficient and explain the effect on terminal velocity.
3. Change ambient temperature in the cooling model.
4. Change resistance or capacitance in the RC circuit.
5. Change tank inflow and determine when capacity is reached.
6. Perform a parameter study with at least four values.
7. Identify one verification test and one validation test for each model.

---

# Complete Runnable MATLAB Code

[Engineering Simulation MATLAB Script](Engineering_Simulation_MATLAB.m)

[Python Equivalent Notebook](Engineering_Simulation_Python.ipynb)

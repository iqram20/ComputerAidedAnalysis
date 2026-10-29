%% Week 14 - Engineering Simulation and Computational Modeling
% Treat each %% section like a notebook code cell.
% Read the explanation, run one section, inspect the output, then continue.
% In MATLAB Live Editor, each %% section can be run independently.
% ESC 113: Computer Aided Analysis for Engineering
%
% Run one section at a time.
% Comments explain the model, the update equation, and the physical meaning
% so the script can be followed independently at a self-paced speed.

clear
clc
close all

%% 1. Euler Method Example

% dt is the numerical time step. Smaller dt usually gives a finer approximation.
dt = 0.1;
t = 0:dt:10;

% Preallocate one solution value for every time point.
y = zeros(size(t));

% Initial condition: y = 1 at t = 0.
y(1) = 1;

% Euler method: next value = current value + dt*(current rate of change).
for i = 1:length(t)-1
    dydt = -0.5*y(i);                 % evaluate dy/dt at the current state
    y(i+1) = y(i) + dt*dydt;          % advance one time step
end

figure
plot(t,y,'LineWidth',1.5)
xlabel('Time')
ylabel('y')
title('Euler Simulation')
grid on

%% 2. Falling Object with Linear Drag

% Physical parameters for a falling object with linear drag.
m = 80;       % mass, kg
c = 12;       % linear drag coefficient
g = 9.81;      % gravitational acceleration, m/s^2

dt = 0.05;
t = 0:dt:30;

% Start from rest, so every velocity is initially zero and v(1)=0.
v = zeros(size(t));

% Governing equation: dv/dt = g - (c/m)*v.
for i = 1:length(t)-1
    dvdt = g - (c/m)*v(i);             % current acceleration
    v(i+1) = v(i) + dt*dvdt;           % Euler update for velocity
end

figure
plot(t,v,'LineWidth',1.5)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Falling Object with Drag')
grid on

fprintf('Simulated final velocity = %.2f m/s\n',v(end))
fprintf('Analytical terminal velocity = %.2f m/s\n',m*g/c)

%% 3. Cooling Simulation

T0 = 95;      % initial object temperature, °C
Tamb = 22;     % ambient temperature, °C
k = 0.08;      % cooling constant

dt = 0.1;
t = 0:dt:60;

% Preallocate temperature and set the initial condition.
T = zeros(size(t));
T(1) = T0;

% Newton cooling model: dT/dt = -k*(T-Tamb).
for i = 1:length(t)-1
    dTdt = -k*(T(i)-Tamb);              % cooling rate at current temperature
    T(i+1) = T(i) + dt*dTdt;            % Euler temperature update
end

figure
plot(t,T,'LineWidth',1.5)
xlabel('Time (min)')
ylabel('Temperature (C)')
title('Cooling Simulation')
grid on

%% 4. RC Circuit Simulation

Vs = 12;       % supply voltage, V
R = 1000;      % resistance, ohm
C = 0.001;     % capacitance, F

dt = 0.01;
t = 0:dt:6;

% Capacitor begins uncharged, so V(1)=0.
V = zeros(size(t));

% Charging model: dV/dt = (Vs-V)/(RC).
for i = 1:length(t)-1
    dVdt = (Vs - V(i))/(R*C);            % current charging rate
    V(i+1) = V(i) + dt*dVdt;             % Euler update
end

% Analytical solution is used to verify the numerical Euler result.
Vexact = Vs*(1-exp(-t/(R*C)));

figure
plot(t,V,'LineWidth',1.5)
hold on
plot(t,Vexact,'--','LineWidth',1.5)
hold off
xlabel('Time (s)')
ylabel('Voltage (V)')
title('RC Circuit Simulation')
legend('Euler','Analytical')
grid on

%% 5. Tank Simulation

Qin = 18;       % inflow, L/min
Qout = 12;      % outflow, L/min
capacity = 500; % maximum tank volume, L

dt = 1;
t = 0:dt:120;

% Preallocate the volume history and set the initial tank volume.
volume = zeros(size(t));
volume(1) = 100;

for i = 1:length(t)-1
    % Volume balance: next volume = current volume + dt*(inflow-outflow).
    volume(i+1) = volume(i) + dt*(Qin-Qout);

    % Apply the physical constraint that the tank cannot exceed capacity.
    if volume(i+1) >= capacity
        volume(i+1:end) = capacity;
        fprintf('Capacity reached at %.1f min\n',t(i+1))
        break
    end
end

figure
plot(t,volume,'LineWidth',1.5)
xlabel('Time (min)')
ylabel('Volume (L)')
title('Tank Volume Simulation')
grid on

%% 6. Parameter Study - Cooling Constant

% Run the same cooling model for several values to study parameter sensitivity.
k_values = [0.03 0.05 0.08 0.12];

figure
hold on

% Each pass through this outer loop uses one cooling constant.
for k = k_values
    T = zeros(size(t));
    T(1) = 95;

    for i = 1:length(t)-1
        T(i+1) = T(i) + dt*(-k*(T(i)-22));
    end

    plot(t,T,'DisplayName',['k=' num2str(k)])
end

hold off
xlabel('Time')
ylabel('Temperature')
title('Cooling Parameter Study')
legend
grid on

%% 7. Review
%
% Verification:
% Did we solve the equations correctly?
%
% Validation:
% Does the model represent the physical system?
%
% Always document:
% assumptions
% parameters
% units
% time step
% model limitations

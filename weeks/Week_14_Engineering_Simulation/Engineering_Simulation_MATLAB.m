%% Week 14 - Engineering Simulation and Computational Modeling
% ESC 113: Computer Aided Analysis for Engineering
%
% Run one section at a time.

clear
clc
close all

%% 1. Euler Method Example

dt = 0.1;
t = 0:dt:10;

y = zeros(size(t));
y(1) = 1;

for i = 1:length(t)-1
    dydt = -0.5*y(i);
    y(i+1) = y(i) + dt*dydt;
end

figure
plot(t,y,'LineWidth',1.5)
xlabel('Time')
ylabel('y')
title('Euler Simulation')
grid on

%% 2. Falling Object with Linear Drag

m = 80;
c = 12;
g = 9.81;

dt = 0.05;
t = 0:dt:30;

v = zeros(size(t));

for i = 1:length(t)-1
    dvdt = g - (c/m)*v(i);
    v(i+1) = v(i) + dt*dvdt;
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

T0 = 95;
Tamb = 22;
k = 0.08;

dt = 0.1;
t = 0:dt:60;

T = zeros(size(t));
T(1) = T0;

for i = 1:length(t)-1
    dTdt = -k*(T(i)-Tamb);
    T(i+1) = T(i) + dt*dTdt;
end

figure
plot(t,T,'LineWidth',1.5)
xlabel('Time (min)')
ylabel('Temperature (C)')
title('Cooling Simulation')
grid on

%% 4. RC Circuit Simulation

Vs = 12;
R = 1000;
C = 0.001;

dt = 0.01;
t = 0:dt:6;

V = zeros(size(t));

for i = 1:length(t)-1
    dVdt = (Vs - V(i))/(R*C);
    V(i+1) = V(i) + dt*dVdt;
end

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

Qin = 18;
Qout = 12;
capacity = 500;

dt = 1;
t = 0:dt:120;

volume = zeros(size(t));
volume(1) = 100;

for i = 1:length(t)-1
    volume(i+1) = volume(i) + dt*(Qin-Qout);

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

k_values = [0.03 0.05 0.08 0.12];

figure
hold on

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

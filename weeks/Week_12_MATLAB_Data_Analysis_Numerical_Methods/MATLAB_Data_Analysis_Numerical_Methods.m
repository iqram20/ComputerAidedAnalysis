%% Week 12 - MATLAB for Engineering Data Analysis and Numerical Methods
% ESC 113: Computer Aided Analysis for Engineering
%
% Run one section at a time.
% This lesson builds on Week 11 MATLAB basics.

clear
clc
close all

%% 1. Creating example engineering data

Time_s = (0:5:30)';
Temperature_C = [22 25 30 37 45 54 60]';
Pressure_kPa = [101 110 125 150 185 220 260]';
FlowRate_L_min = [10 11 12 13 14 15 16]';
Vibration_mm_s = [1.2 1.5 1.7 2.1 2.8 3.6 4.5]';

data = table(Time_s, Temperature_C, Pressure_kPa, ...
    FlowRate_L_min, Vibration_mm_s);

disp(data)

%% 2. Save and read engineering data

writetable(data, 'engineering_sensor_data.csv');

sensorData = readtable('engineering_sensor_data.csv');

disp(sensorData)

%% 3. Inspect a table

head(sensorData)

summary(sensorData)

disp(sensorData.Properties.VariableNames)

%% 4. Access table columns

temperature = sensorData.Temperature_C;
pressure = sensorData.Pressure_kPa;
flow = sensorData.FlowRate_L_min;
time = sensorData.Time_s;

disp(temperature)

%% 5. Descriptive statistics

mean_temp = mean(temperature);
median_temp = median(temperature);
std_temp = std(temperature);
min_temp = min(temperature);
max_temp = max(temperature);

fprintf('Mean temperature = %.2f C\n', mean_temp);
fprintf('Median temperature = %.2f C\n', median_temp);
fprintf('Standard deviation = %.2f C\n', std_temp);
fprintf('Minimum = %.2f C\n', min_temp);
fprintf('Maximum = %.2f C\n', max_temp);

%% 6. Logical filtering

highPressureRows = sensorData.Pressure_kPa > 180;

highPressureData = sensorData(highPressureRows, :);

disp(highPressureData)

%% 7. Multiple logical conditions

warningRows = sensorData.Temperature_C > 45 & ...
              sensorData.Pressure_kPa > 200;

warningData = sensorData(warningRows, :);

disp(warningData)

%% 8. Basic engineering plot

figure
plot(time, temperature, 'o-', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Temperature (C)')
title('Temperature vs Time')
grid on

%% 9. Multiple variables

figure
plot(time, pressure, 'o-', 'LineWidth', 1.5)
hold on
plot(time, flow*10, 's-', 'LineWidth', 1.5)
hold off

xlabel('Time (s)')
ylabel('Scaled Values')
title('Pressure and Flow Trend')
legend('Pressure (kPa)', 'Flow Rate x 10')
grid on

%% 10. Curve fitting - linear fit

voltage = [0.5 1.0 1.5 2.0 2.5];
temperature_cal = [10 21 31 42 52];

p = polyfit(voltage, temperature_cal, 1);

slope = p(1);
intercept = p(2);

fprintf('Slope = %.4f\n', slope);
fprintf('Intercept = %.4f\n', intercept);

predicted_temperature = polyval(p, voltage);

figure
plot(voltage, temperature_cal, 'o', 'MarkerSize', 7)
hold on
plot(voltage, predicted_temperature, '-', 'LineWidth', 1.5)
hold off

xlabel('Sensor Voltage (V)')
ylabel('Temperature (C)')
title('Sensor Calibration')
legend('Measured Data', 'Linear Fit')
grid on

%% 11. Predict using the fitted model

new_voltage = 1.75;
estimated_temperature = polyval(p, new_voltage);

fprintf('Estimated temperature at %.2f V = %.2f C\n', ...
    new_voltage, estimated_temperature);

%% 12. Polynomial fitting

x = [0 1 2 3 4 5];
y = [2.0 2.8 4.5 7.2 10.8 15.5];

p2 = polyfit(x, y, 2);

x_fit = linspace(min(x), max(x), 100);
y_fit = polyval(p2, x_fit);

figure
plot(x, y, 'o')
hold on
plot(x_fit, y_fit, 'LineWidth', 1.5)
hold off

xlabel('x')
ylabel('y')
title('Second-Order Polynomial Fit')
grid on

%% 13. Numerical differentiation

t = 0:0.5:5;

position = [0 0.6 2.4 5.4 9.6 15.0 ...
            21.6 29.4 38.4 48.6 60.0];

velocity = gradient(position, t);
acceleration = gradient(velocity, t);

disp(table(t', position', velocity', acceleration', ...
    'VariableNames', {'Time_s','Position_m','Velocity_m_s','Acceleration_m_s2'}))

%% 14. Plot position, velocity, and acceleration

figure
tiledlayout(3,1)

nexttile
plot(t, position, 'LineWidth', 1.5)
ylabel('Position (m)')
grid on

nexttile
plot(t, velocity, 'LineWidth', 1.5)
ylabel('Velocity (m/s)')
grid on

nexttile
plot(t, acceleration, 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on

%% 15. Numerical integration - distance from velocity

t2 = 0:1:10;

v = [0 2 4 6 8 10 11 12 12 11 10];

distance = trapz(t2, v);

fprintf('Estimated distance traveled = %.2f m\n', distance);

%% 16. Plot velocity-time data

figure
plot(t2, v, 'o-', 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity vs Time')
grid on

%% 17. Engineering interpretation of trapz
% The area under a velocity-time curve represents displacement.
%
% trapz performs trapezoidal numerical integration.

%% 18. Flow-rate integration

time_min = [0 1 2 3 4 5 6];
flow_L_min = [10 11 13 15 14 12 10];

total_volume_L = trapz(time_min, flow_L_min);

fprintf('Total volume = %.2f L\n', total_volume_L);

%% 19. Solving a nonlinear equation with fzero

f = @(x) x.^3 - 4*x - 9;

root = fzero(f, 3);

fprintf('Root = %.6f\n', root);
fprintf('Check f(root) = %.6e\n', f(root));

%% 20. Engineering nonlinear example - drag balance
% Solve:
%
% c*v^2 - m*g = 0
%
% for terminal velocity.

m = 80;
g = 9.81;
c = 0.25;

force_balance = @(v) c*v.^2 - m*g;

terminal_velocity = fzero(force_balance, 50);

fprintf('Terminal velocity = %.2f m/s\n', terminal_velocity);

%% 21. Solve a linear system

A = [2 1;
     1 3];

b = [8;
     9];

solution = A\b;

disp(solution)

%% 22. Verify the linear-system solution

check = A * solution;

disp(check)
disp(b)

%% 23. Engineering linear-system example - two unknown forces
% Example system:
%
% 2*F1 + F2 = 100
% F1 + 3*F2 = 120

A_force = [2 1;
           1 3];

b_force = [100;
           120];

F = A_force\b_force;

fprintf('F1 = %.2f N\n', F(1));
fprintf('F2 = %.2f N\n', F(2));

%% 24. Stress-strain engineering example

strain = [0 0.0005 0.0010 0.0015 0.0020 0.0025];
stress_MPa = [0 100 200 295 385 465];

pE = polyfit(strain, stress_MPa, 1);

E_MPa = pE(1);

fprintf('Estimated elastic modulus = %.2f MPa\n', E_MPa);
fprintf('Estimated elastic modulus = %.2f GPa\n', E_MPa/1000);

stress_fit = polyval(pE, strain);

figure
plot(strain, stress_MPa, 'o')
hold on
plot(strain, stress_fit, 'LineWidth', 1.5)
hold off

xlabel('Strain')
ylabel('Stress (MPa)')
title('Stress-Strain Linear Fit')
grid on

%% 25. Guided Exercise 1
% Create a table containing:
% Time, Voltage, Current
%
% Calculate Power = Voltage .* Current
% Add Power as a new table column.

%% 26. Guided Exercise 2
% Import or create pressure measurements.
% Calculate:
% mean
% median
% standard deviation
% minimum
% maximum
%
% Identify all pressure values above a safety threshold.

%% 27. Guided Exercise 3
% Given calibration data:
%
% voltage = [0.2 0.5 0.8 1.1 1.4]
% pressure = [20 48 82 111 139]
%
% Fit a line and estimate pressure at 1.0 V.

%% 28. Guided Exercise 4
% Given displacement data as a function of time,
% use gradient to estimate velocity and acceleration.

%% 29. Guided Exercise 5
% Given experimental flow-rate data as a function of time,
% use trapz to estimate total delivered volume.

%% 30. Guided Exercise 6
% Solve:
%
% x^3 - 2*x - 5 = 0
%
% with fzero and verify the answer.

%% 31. Guided Exercise 7
% Solve the linear system:
%
% 3*x + 2*y = 18
% x + 4*y = 16
%
% using A\b.

%% 32. Review Questions
%
% 1. What does readtable do?
% 2. How do you select rows from a MATLAB table?
% 3. Why is logical filtering useful in engineering?
% 4. What does polyfit return?
% 5. What does polyval do?
% 6. What does gradient estimate?
% 7. What physical quantity is obtained by integrating velocity over time?
% 8. What does trapz do?
% 9. What does fzero solve?
% 10. What does A\b calculate?
% 11. Why should numerical results be checked against physical expectations?
% 12. Why is data visualization important before numerical modeling?

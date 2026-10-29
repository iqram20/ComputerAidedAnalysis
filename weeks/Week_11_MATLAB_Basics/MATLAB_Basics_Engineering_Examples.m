%% Week 11 - Programming Review and Matrix-Based Engineering Computation
% Treat each %% section like a notebook code cell.
% Read the explanation, run one section, inspect the output, then continue.
% In MATLAB Live Editor, each %% section can be run independently.
% ESC 113: Computer Aided Analysis for Engineering
% MATLAB implementation of the Week 11 engineering programming examples.
% The comments are written for self-paced study: read the comment first,
% run the section, inspect the output, and then continue.
%
% Run one section at a time using "Run Section".

%% 1. MATLAB as an engineering calculator

% MATLAB follows normal order of operations: multiplication before addition.
2 + 3*4

% Parentheses force MATLAB to evaluate the addition first.
(2 + 3)*4

2^5                    % raise 2 to the 5th power
sqrt(81)               % square root
sin(pi/6)              % sine; MATLAB uses radians here
log(10)                % natural logarithm
exp(2)                 % e^2

%% 2. Variables and formatted output

mass = 25;              % kg
acceleration = 3.2;     % m/s^2
force = mass * acceleration;   % F = ma

fprintf('Force = %.2f N\n', force);

voltage = 24;           % V
current = 3.5;          % A
power = voltage * current;     % P = VI

fprintf('Electrical power = %.2f W\n', power);

%% 3. Vectors

% Square brackets with spaces create a row vector.
temperature = [20 22 24 26 28];          % temperature measurements
pressure = [101.2 101.8 102.1 101.5 100.9]; % pressure measurements

disp(temperature)
disp(pressure)

% Column vector
% Semicolons inside brackets create new rows, so this is a column vector.
time = [0; 1; 2; 3; 4; 5];

%% 4. Creating vectors with colon and linspace

x1 = 0:2:20;               % start:step:end
x2 = linspace(0, 10, 6);   % six equally spaced points

disp(x1)
disp(x2)

%% 5. Vector indexing

v = [10 20 30 40 50];

% MATLAB indexing starts at 1.
first_value = v(1);       % first element
third_value = v(3);       % third element
last_value = v(end);      % "end" means the final element
middle_values = v(2:4);   % elements 2, 3, and 4

disp(first_value)
disp(third_value)
disp(last_value)
disp(middle_values)

%% 6. Matrices

A = [1 2 3;
     4 5 6;
     7 8 9];

disp(A)

% ":" means keep all entries in that dimension.
row2 = A(2,:);            % row 2, all columns
col3 = A(:,3);            % all rows, column 3
value_23 = A(2,3);        % single value: row 2, column 3

disp(row2)
disp(col3)
disp(value_23)

%% 7. Matrix size and transpose

[r, c] = size(A);
fprintf('Rows = %d, Columns = %d\n', r, c);

AT = A';

disp(AT)

%% 8. Element-by-element operations

x = [1 2 3 4 5];

x_squared = x.^2;
x_times_3 = x .* 3;
x_divided_2 = x ./ 2;

disp(x_squared)
disp(x_times_3)
disp(x_divided_2)

%% Important
% MATLAB distinguishes:
%
% *   matrix multiplication
% .*  element-by-element multiplication
%
% ^   matrix power
% .^  element-by-element power
%
% /   matrix division
% ./  element-by-element division

%% 9. Engineering Example - Kinetic energy at several velocities

mass = 5;                         % kg
velocity = [2 4 6 8 10];          % m/s

% .^ squares EACH velocity value. The result is one KE value per speed.
KE = 0.5 * mass .* velocity.^2;

disp(KE)

%% 10. Built-in statistics

measurements = [12.5 15.8 14.2 18.6 16.1];

mean_value = mean(measurements);
min_value = min(measurements);
max_value = max(measurements);
std_value = std(measurements);

fprintf('Mean = %.2f\n', mean_value);
fprintf('Minimum = %.2f\n', min_value);
fprintf('Maximum = %.2f\n', max_value);
fprintf('Standard deviation = %.2f\n', std_value);

%% 11. Logical indexing

pressures = [220 310 450 510 490 540 300];

% The comparison creates a logical vector of TRUE/FALSE values.
unsafe = pressures > 500;

% Logical indexing keeps only the measurements where unsafe is TRUE.
unsafe_pressures = pressures(unsafe);

disp(unsafe)
disp(unsafe_pressures)

%% 12. if / elseif / else example

temperature = 85;

% MATLAB checks the conditions from top to bottom and stops at the first true branch.
if temperature < 70
    status = 'Normal';
elseif temperature <= 90
    status = 'Warning';
else
    status = 'Critical';
end

fprintf('Machine status: %s\n', status);

%% 13. Engineering Example - Battery voltage classifier

battery_voltage = 12.4;

if battery_voltage < 11.5
    battery_status = 'Low';
elseif battery_voltage <= 13.0
    battery_status = 'Normal';
else
    battery_status = 'High';
end

fprintf('Battery status: %s\n', battery_status);

%% 14. for loop - velocity table

acceleration = 3;   % m/s^2

% The loop repeats once for each integer time from 0 through 10 s.
for t = 0:10
    velocity = acceleration * t;   % v = at, assuming initial velocity is zero
    fprintf('t = %2d s, v = %5.1f m/s\n', t, velocity);
end

%% 15. for loop - electrical power table

R = 10;   % ohm

for I = 1:10
    P = I^2 * R;
    fprintf('I = %2d A, P = %4d W\n', I, P);
end

%% 16. while loop - tank filling

volume = 0;         % L
flow_rate = 12;     % L/min
minutes = 0;

% A while loop is useful when the number of repetitions is not known in advance.
while volume < 500
    volume = volume + flow_rate;   % add one minute of incoming volume
    minutes = minutes + 1;         % advance the simulated clock by one minute
end

fprintf('Tank reaches at least 500 L after %d min.\n', minutes);

%% 17. Basic 2D plotting

t = 0:0.1:10;
velocity = 3 .* t;

figure
plot(t, velocity, 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity vs Time')
grid on

%% 18. Engineering Example - Projectile motion

v0 = 30;                 % m/s
theta_deg = 40;          % degrees
g = 9.81;                % m/s^2

% Trigonometric functions such as sin() and cos() expect radians.
theta = deg2rad(theta_deg);

t_flight = 2 * v0 * sin(theta) / g;
t = linspace(0, t_flight, 100);

x = v0 * cos(theta) .* t;
y = v0 * sin(theta) .* t - 0.5 * g .* t.^2;

figure
plot(x, y, 'LineWidth', 1.5)
xlabel('Horizontal Distance (m)')
ylabel('Height (m)')
title('Projectile Motion')
grid on

%% 19. Engineering Example - Beam normal stress

load_N = [5000 10000 15000 20000 25000];
area_m2 = 0.004;

% Normal stress: sigma = F/A. "./" performs element-wise division.
stress_Pa = load_N ./ area_m2;

% Convert Pa to MPa so the plotted values are easier to read.
stress_MPa = stress_Pa / 1e6;

figure
plot(load_N, stress_MPa, 'o-', 'LineWidth', 1.5)
xlabel('Load (N)')
ylabel('Stress (MPa)')
title('Normal Stress vs Applied Load')
grid on

%% 20. Engineering Example - Fluid flow

rho = 998;       % kg/m^3
mu = 0.001;      % Pa.s
D = 0.05;        % m

velocity = 0.2:0.2:3.0;

% Reynolds number: Re = rho*v*D/mu, calculated for every velocity value.
Re = rho .* velocity .* D ./ mu;

figure
plot(velocity, Re, 'LineWidth', 1.5)
xlabel('Velocity (m/s)')
ylabel('Reynolds Number')
title('Reynolds Number vs Velocity')
grid on

%% 21. Engineering Example - Temperature sensor data

time_min = 0:5:30;
temp_C = [22 25 30 37 45 54 60];

figure
plot(time_min, temp_C, 's-', 'LineWidth', 1.5)
xlabel('Time (min)')
ylabel('Temperature (°C)')
title('Temperature Sensor Measurements')
grid on

average_temp = mean(temp_C);
fprintf('Average temperature = %.2f °C\n', average_temp);

%% 22. Multiple plots on one figure

t = 0:0.1:5;

y1 = 3 + exp(-t).*sin(6*t);
y2 = 4 + exp(-t).*cos(6*t);

figure
plot(t, y1, 'LineWidth', 1.5)
hold on
plot(t, y2, 'LineWidth', 1.5)
xlabel('Time')
ylabel('Response')
title('Damped Engineering Responses')
legend('Response 1', 'Response 2')
grid on
hold off

%% 23. User-defined function example
% Local functions can be placed at the end of a MATLAB script.

F = calculate_force(12, 4.5);
fprintf('Calculated force = %.2f N\n', F);

%% 24. User-defined function - cylinder volume

V = cylinder_volume(1.5, 4);
fprintf('Cylinder volume = %.2f m^3\n', V);

%% 25. User-defined function - machine temperature status

status = temperature_status(95);
fprintf('Temperature status = %s\n', status);

%% 26. Guided Exercise 1
% Calculate the gravitational potential energy of a 15 kg object
% raised 8 m above the ground.
%
% PE = m*g*h

%% 27. Guided Exercise 2
% Create a vector of currents from 1 A to 8 A.
% For a resistance of 12 ohm, calculate voltage using V = IR.
% Plot Voltage vs Current.

%% 28. Guided Exercise 3
% Given:
%
% pressure = [480 495 505 520 475 540]
%
% Use logical indexing to extract all values above 500 kPa.

%% 29. Guided Exercise 4
% A motor is:
%
% High efficiency   >= 90%
% Acceptable        75% to <90%
% Low efficiency    <75%
%
% Write MATLAB branching code that classifies an efficiency value.

%% 30. Guided Exercise 5
% Simulate an object cooling from 100°C by 5°C every minute.
% Use a while loop to find how many minutes are required to fall
% below 40°C.

%% 31. Review questions
%
% 1. What is the difference between * and .* ?
% 2. What is the difference between ^ and .^ ?
% 3. How does MATLAB indexing differ from Python indexing?
% 4. What does A(:,2) return?
% 5. What does linspace(0,10,6) create?
% 6. When would a while loop be preferable to a for loop?
% 7. Why are vectors and matrices central to MATLAB?
% 8. Why should engineering plots always include axis labels and units?

%% Local functions

function F = calculate_force(mass, acceleration)
    % Return force from Newton's second law, F = ma.
    F = mass * acceleration;
end

function V = cylinder_volume(radius, height)
    % Return cylinder volume from V = pi*r^2*h.
    V = pi * radius^2 * height;
end

function status = temperature_status(T)
    if T < 70
        status = 'Normal';
    elseif T <= 90
        status = 'Warning';
    else
        status = 'Critical';
    end
end

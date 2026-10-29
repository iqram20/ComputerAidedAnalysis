%% Week 2 - Variables, Arrays, Matrices, and Tables
% ESC 113: Computer Aided Analysis for Engineering
% 3-Hour Self-Paced MATLAB Code Study
%
% Suggested pacing:
% Part A: vectors and indexing
% Part B: matrices, element-wise operations, statistics, tables
% Part C: engineering data exercises and review
%
% Run one %% section at a time and inspect the output.

clear
clc
close all

%% PART A - VECTORS AND INDEXING

%% 1. Scalar, row vector, and column vector
temperature_C = 25;                   % scalar = one value
temperatures_C = [20 22 24 27 30];   % row vector = one row
temperatures_col_C = temperatures_C'; % transpose creates a column vector

disp(temperature_C)
disp(temperatures_C)
disp(temperatures_col_C)

%% 2. MATLAB indexing starts at 1
v = [10 20 30 40 50];

first_value = v(1);
third_value = v(3);
last_value = v(end);

fprintf('First = %.0f, Third = %.0f, Last = %.0f\n', ...
    first_value,third_value,last_value)

%% 3. Slicing with the colon operator
middle = v(2:4);      % elements 2 through 4
every_other = v(1:2:end);

disp(middle)
disp(every_other)

%% 4. Creating sequences
time1 = 0:1:10;           % start:step:end
time2 = linspace(0,10,6); % exactly six equally spaced points

disp(time1)
disp(time2)

%% 5. Vector arithmetic
voltage_V = [5 10 15 20];
current_A = [1 2 3 4];

power_W = voltage_V .* current_A;   % pairwise multiplication
resistance_ohm = voltage_V ./ current_A;

disp(table(voltage_V',current_A',power_W',resistance_ohm', ...
    'VariableNames',{'Voltage_V','Current_A','Power_W','Resistance_ohm'}))

%% 6. Element-wise powers
velocity_m_s = [2 4 6 8 10];
mass_kg = 5;

KE_J = 0.5*mass_kg.*velocity_m_s.^2;

disp(table(velocity_m_s',KE_J', ...
    'VariableNames',{'Velocity_m_s','KineticEnergy_J'}))

%% PART B - MATRICES AND ENGINEERING DATA

%% 7. Create a matrix
A = [1 2 3;
     4 5 6;
     7 8 9];

disp(A)

%% 8. Matrix indexing
row2 = A(2,:);      % row 2, all columns
col3 = A(:,3);      % all rows, column 3
value23 = A(2,3);   % row 2, column 3

disp(row2)
disp(col3)
disp(value23)

%% 9. Matrix dimensions
[nRows,nCols] = size(A);

fprintf('Rows = %d, Columns = %d\n',nRows,nCols)

%% 10. Transpose
AT = A';

disp(AT)

%% 11. Matrix multiplication vs element-wise multiplication
B = [1 2; 3 4];
C = [5 6; 7 8];

matrix_product = B*C;        % linear algebra multiplication
element_product = B.*C;      % multiply matching elements

disp(matrix_product)
disp(element_product)

%% 12. Predefined matrices
Z = zeros(3,4);   % all zeros
O = ones(2,3);    % all ones
I = eye(3);       % identity matrix

disp(Z)
disp(O)
disp(I)

%% 13. Replace part of a matrix
M = zeros(3,4);

M(:,2) = 1;       % replace the entire second column with ones

disp(M)

%% 14. Descriptive statistics
measurements = [12.5 15.8 14.2 18.6 16.1];

mean_value = mean(measurements);
median_value = median(measurements);
min_value = min(measurements);
max_value = max(measurements);
std_value = std(measurements);
range_value = max_value-min_value;

fprintf('Mean = %.2f\n',mean_value)
fprintf('Median = %.2f\n',median_value)
fprintf('Min = %.2f\n',min_value)
fprintf('Max = %.2f\n',max_value)
fprintf('Std = %.2f\n',std_value)
fprintf('Range = %.2f\n',range_value)

%% 15. Logical indexing
pressure_kPa = [220 310 450 510 490 540 300];

isHigh = pressure_kPa > 500;          % TRUE where threshold is exceeded
highPressure_kPa = pressure_kPa(isHigh);

disp(isHigh)
disp(highPressure_kPa)

%% 16. Multiple logical conditions
temperature_C = [40 55 70 82 95];
pressure_kPa = [150 170 190 210 230];

warningMask = temperature_C > 80 & pressure_kPa > 200;

disp(warningMask)

%% 17. Create a table
Time_s = [0;1;2;3;4];
Temperature_C = [22;25;29;34;40];
Pressure_kPa = [101;105;111;118;126];

T = table(Time_s,Temperature_C,Pressure_kPa);

disp(T)

%% 18. Access table columns
temp = T.Temperature_C;
pressure = T.Pressure_kPa;

disp(temp)
disp(pressure)

%% 19. Add a calculated table column
T.Pressure_Pa = T.Pressure_kPa*1000;

disp(T)

%% 20. Filter table rows
highRows = T.Temperature_C >= 30;
highTempData = T(highRows,:);

disp(highTempData)

%% 21. Sensor matrix example
% Rows = repeated observations
% Columns = three sensors
sensorData = [
    10.1 10.2 10.0
    10.5 10.4 10.6
    11.0 10.9 11.1
    11.4 11.5 11.3
];

sensorMeans = mean(sensorData,1);  % mean of each column

disp(sensorMeans)

%% PART C - SELF-PACED ENGINEERING PRACTICE

%% 22. Temperature conversion
C = 0:10:100;
F = (9/5).*C + 32;

disp(table(C',F','VariableNames',{'Temperature_C','Temperature_F'}))

%% 23. Velocity magnitude from components
vx = [2 4 6 8];
vy = [1 3 2 4];

speed = sqrt(vx.^2 + vy.^2);

disp(table(vx',vy',speed', ...
    'VariableNames',{'Vx','Vy','Speed'}))

%% 24. Stress for several loads
load_N = [5000 10000 15000 20000];
area_m2 = 0.004;

stress_MPa = (load_N./area_m2)/1e6;

disp(table(load_N',stress_MPa', ...
    'VariableNames',{'Load_N','Stress_MPa'}))

%% 25. Plot vector data
time_s = 0:1:10;
velocity_m_s = 3.*time_s;

figure
plot(time_s,velocity_m_s,'o-')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity vs Time')
grid on

%% 26. Common mistakes
% A(0) is invalid because MATLAB indexing begins at 1.
% x*y and x.*y are not the same operation.
% x^2 and x.^2 are not the same when x is an array.

%% 27. Mini challenge - normalize sensor data
sensor = [18 20 22 25 30];

sensor_mean = mean(sensor);
sensor_std = std(sensor);

z = (sensor-sensor_mean)./sensor_std;

disp(table(sensor',z', ...
    'VariableNames',{'Original','Standardized'}))

%% 28. Final review
% Make sure you can explain:
% - scalar vs vector vs matrix;
% - row vs column vector;
% - MATLAB indexing;
% - colon operator;
% - * vs .*;
% - ^ vs .^;
% - logical indexing;
% - why tables are useful for engineering data.

disp('Week 2 self-paced study complete.')

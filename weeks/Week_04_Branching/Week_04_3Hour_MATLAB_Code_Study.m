%% Week 4 - Branching and Engineering Decision Logic
% ESC 113: Computer Aided Analysis for Engineering
% 3-Hour Self-Paced MATLAB Code Study
%
% Part A: comparisons and logical operators
% Part B: engineering decisions and safety logic
% Part C: boundary testing and practice

clear
clc
close all

%% PART A - BOOLEAN LOGIC

%% 1. Comparison operators
temperature_C = 85;

disp(temperature_C > 80)    % greater than
disp(temperature_C < 80)    % less than
disp(temperature_C >= 85)   % greater than or equal
disp(temperature_C == 85)   % equal
disp(temperature_C ~= 85)   % not equal

%% 2. Simple if statement
temperature_C = 95;

if temperature_C > 80
    disp('Temperature is above the warning threshold.')
end

%% 3. if / elseif / else
temperature_C = 95;

if temperature_C > 100
    status = "Critical";
elseif temperature_C > 80
    status = "Warning";
else
    status = "Normal";
end

fprintf('Status = %s\n',status)

%% 4. Boundary values
% Notice the difference between > and >=.

temperature_C = 80;

if temperature_C >= 80
    disp('80 C is included in this condition.')
else
    disp('80 C is excluded.')
end

%% 5. Logical AND
temperature_C = 90;
pressure_kPa = 210;

if temperature_C > 80 && pressure_kPa > 200
    disp('Both temperature and pressure are high.')
end

%% 6. Logical OR
vibration_mm_s = 6.2;
temperature_C = 75;

if vibration_mm_s > 5 || temperature_C > 85
    disp('Inspection required because at least one limit is exceeded.')
else
    disp('No inspection trigger.')
end

%% 7. Logical NOT
systemReady = false;

if ~systemReady
    disp('System is not ready to start.')
end

%% PART B - ENGINEERING DECISION SYSTEMS

%% 8. Structural stress check
stress_MPa = 180;
allowable_MPa = 250;

if stress_MPa <= allowable_MPa
    status = "Within allowable stress";
else
    status = "Unsafe";
end

disp(status)

%% 9. Safety factor
yieldStrength_MPa = 300;
workingStress_MPa = 120;

safetyFactor = yieldStrength_MPa/workingStress_MPa;

if safetyFactor >= 2
    status = "Acceptable";
elseif safetyFactor >= 1.5
    status = "Review";
else
    status = "Unsafe";
end

fprintf('Safety factor = %.2f, Status = %s\n',safetyFactor,status)

%% 10. Battery classifier
batteryVoltage_V = 12.4;

if batteryVoltage_V < 11.5
    batteryStatus = "Low";
elseif batteryVoltage_V <= 13.0
    batteryStatus = "Normal";
else
    batteryStatus = "High";
end

fprintf('Battery status = %s\n',batteryStatus)

%% 11. Machine temperature classifier
T_C = 96;

if T_C < 70
    machineStatus = "Normal";
elseif T_C <= 90
    machineStatus = "Warning";
elseif T_C <= 105
    machineStatus = "Critical";
else
    machineStatus = "Shutdown";
end

fprintf('Machine status = %s\n',machineStatus)

%% 12. Pump-start interlock
levelOK = true;
valveOpen = true;
motorAvailable = true;

if levelOK && valveOpen && motorAvailable
    pumpCommand = "START";
else
    pumpCommand = "DO NOT START";
end

fprintf('Pump command = %s\n',pumpCommand)

%% 13. Multi-sensor warning
temperature_C = 88;
vibration_mm_s = 4.2;
pressure_kPa = 230;

if temperature_C > 85 || vibration_mm_s > 5 || pressure_kPa > 220
    inspectionStatus = "Inspect";
else
    inspectionStatus = "Normal";
end

disp(inspectionStatus)

%% 14. Redundant sensor voting
sensor1 = 101;
sensor2 = 102;
sensor3 = 160;
threshold = 120;

nHigh = (sensor1 > threshold) + ...
        (sensor2 > threshold) + ...
        (sensor3 > threshold);

if nHigh >= 2
    alarm = "High";
else
    alarm = "No high alarm";
end

fprintf('Sensors above threshold = %d, Alarm = %s\n',nHigh,alarm)

%% 15. Nested decision
temperature_C = 92;
pressure_kPa = 180;

if temperature_C > 80
    if pressure_kPa > 200
        message = "High temperature and high pressure";
    else
        message = "High temperature only";
    end
else
    message = "Temperature normal";
end

disp(message)

%% 16. Validate a measurement
pressure_kPa = -20;

if pressure_kPa < 0
    status = "Invalid measurement";
elseif pressure_kPa > 1000
    status = "Outside expected range";
else
    status = "Valid";
end

disp(status)

%% 17. Point inside a rectangular operating region
x = 4;
y = 7;

inside = x >= 0 && x <= 10 && y >= 0 && y <= 8;

if inside
    disp('Point is inside the operating region.')
else
    disp('Point is outside the operating region.')
end

%% PART C - TESTING AND PRACTICE

%% 18. Boundary testing
% A decision rule should be tested below, at, and above each threshold.

testTemperatures = [69 70 90 91 105 106];

for T = testTemperatures
    if T < 70
        status = "Normal";
    elseif T <= 90
        status = "Warning";
    elseif T <= 105
        status = "Critical";
    else
        status = "Shutdown";
    end

    fprintf('T = %3.0f C -> %s\n',T,status)
end

%% 19. Quadratic root type
a = 1;
b = 4;
c = 4;

discriminant = b^2 - 4*a*c;

if discriminant > 0
    rootType = "Two real roots";
elseif discriminant == 0
    rootType = "One repeated real root";
else
    rootType = "Two complex roots";
end

fprintf('Discriminant = %.2f, %s\n',discriminant,rootType)

%% 20. Motor efficiency classifier
efficiency_percent = 87;

if efficiency_percent >= 90
    status = "High efficiency";
elseif efficiency_percent >= 75
    status = "Acceptable";
else
    status = "Low efficiency";
end

disp(status)

%% 21. Common mistakes
% Use == for comparison, not =.
% Every if block must end with end.
% Check boundary values carefully.
% Complex nested logic can often be simplified with meaningful variables.

%% 22. Mini challenge
% Create an original engineering decision using at least three inputs
% and four possible output states.
%
% Suggested inputs:
% temperature, pressure, vibration
%
% Suggested outputs:
% Normal, Monitor, Inspect, Shutdown

disp('Week 4 self-paced study complete.')

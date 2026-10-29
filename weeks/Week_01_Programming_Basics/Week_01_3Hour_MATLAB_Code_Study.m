%% Week 1 - Programming Basics and Engineering Calculations
% ESC 113: Computer Aided Analysis for Engineering
% 3-Hour Self-Paced MATLAB Code Study
%
% HOW TO USE THIS FILE
% 1. Open this file in MATLAB Live Editor.
% 2. Run ONE %% section at a time.
% 3. Read the comments before running the code.
% 4. Inspect every printed value or figure.
% 5. Change one input value and run the section again.
%
% Suggested pacing:
% Part A (about 60 min): MATLAB basics and arithmetic
% Part B (about 60 min): engineering calculations
% Part C (about 60 min): guided practice and review
%
% Goal: use MATLAB as an engineering calculator and begin writing
% readable programs with variables, units, comments, and clear output.

clear
clc
close all

%% PART A - MATLAB BASICS

%% 1. Arithmetic and order of operations
% MATLAB follows standard mathematical order of operations.
a = 2 + 3*4;          % multiplication happens before addition
b = (2 + 3)*4;        % parentheses change the order
c = 2^5;              % ^ means power
d = sqrt(81);         % square root

fprintf('2 + 3*4 = %.0f\n',a)
fprintf('(2 + 3)*4 = %.0f\n',b)
fprintf('2^5 = %.0f\n',c)
fprintf('sqrt(81) = %.0f\n',d)

%% 2. Variables
% A variable gives a meaningful name to a value.
mass_kg = 25;                 % mass in kilograms
acceleration_m_s2 = 3.2;      % acceleration in m/s^2

force_N = mass_kg*acceleration_m_s2;   % F = ma

fprintf('Force = %.2f N\n',force_N)

%% 3. Comments and semicolons
% A percent sign starts a comment.
% A semicolon suppresses automatic output.

temperature_C = 25;     % stored without automatic display
pressure_kPa = 101.3;   % another engineering variable

disp(temperature_C)      % disp shows a value
fprintf('Pressure = %.1f kPa\n',pressure_kPa)

%% 4. Built-in mathematical functions
angle_rad = pi/6;

s = sin(angle_rad);
c = cos(angle_rad);
e2 = exp(2);
ln10 = log(10);
log1000 = log10(1000);
absolute_value = abs(-25);

fprintf('sin(pi/6) = %.3f\n',s)
fprintf('cos(pi/6) = %.3f\n',c)
fprintf('exp(2) = %.3f\n',e2)
fprintf('ln(10) = %.3f\n',ln10)
fprintf('log10(1000) = %.1f\n',log1000)
fprintf('abs(-25) = %.0f\n',absolute_value)

%% 5. Degrees and radians
% sin() and cos() use radians.
% sind() and cosd() use degrees.

angle_deg = 30;

value1 = sin(deg2rad(angle_deg));
value2 = sind(angle_deg);

fprintf('Using radians: %.3f\n',value1)
fprintf('Using degrees: %.3f\n',value2)

%% 6. Scientific notation
% 1e6 means 1 x 10^6.
stress_Pa = 180e6;
stress_MPa = stress_Pa/1e6;

fprintf('Stress = %.1f MPa\n',stress_MPa)

%% 7. Unit conversion
length_m = 2.5;
length_mm = length_m*1000;

fprintf('%.2f m = %.0f mm\n',length_m,length_mm)

%% PART B - ENGINEERING CALCULATIONS

%% 8. Ohm's law
% V = I*R
current_A = 3.5;
resistance_ohm = 8;

voltage_V = current_A*resistance_ohm;

fprintf('Voltage = %.2f V\n',voltage_V)

%% 9. Electrical power
% P = V*I
power_W = voltage_V*current_A;

fprintf('Electrical power = %.2f W\n',power_W)

%% 10. Kinetic energy
% KE = 1/2*m*v^2
mass_kg = 1200;
velocity_m_s = 20;

KE_J = 0.5*mass_kg*velocity_m_s^2;

fprintf('Kinetic energy = %.0f J\n',KE_J)

%% 11. Gravitational potential energy
% PE = m*g*h
mass_kg = 15;
g_m_s2 = 9.81;
height_m = 8;

PE_J = mass_kg*g_m_s2*height_m;

fprintf('Potential energy = %.2f J\n',PE_J)

%% 12. Pressure
% P = F/A
force_N = 5000;
area_m2 = 0.02;

pressure_Pa = force_N/area_m2;
pressure_kPa = pressure_Pa/1000;

fprintf('Pressure = %.2f kPa\n',pressure_kPa)

%% 13. Hydrostatic pressure
% P = rho*g*h
rho_water = 1000;     % kg/m^3
g = 9.81;             % m/s^2
depth_m = 5;

hydrostatic_Pa = rho_water*g*depth_m;
hydrostatic_kPa = hydrostatic_Pa/1000;

fprintf('Hydrostatic pressure = %.2f kPa\n',hydrostatic_kPa)

%% 14. Cylinder volume
% V = pi*r^2*h
radius_m = 0.4;
height_m = 1.5;

volume_m3 = pi*radius_m^2*height_m;

fprintf('Cylinder volume = %.3f m^3\n',volume_m3)

%% 15. Force components
% Resolve a force into x and y components.
force_N = 750;
theta_deg = 42;

Fx_N = force_N*cosd(theta_deg);
Fy_N = force_N*sind(theta_deg);

fprintf('Fx = %.2f N\n',Fx_N)
fprintf('Fy = %.2f N\n',Fy_N)

%% 16. Motor speed conversion
% Convert rpm to rad/s:
% omega = rpm*(2*pi/60)
rpm = 1750;

omega_rad_s = rpm*(2*pi/60);

fprintf('Angular speed = %.2f rad/s\n',omega_rad_s)

%% 17. Mass flow rate
% mdot = rho*Q
rho_kg_m3 = 998;
Q_m3_s = 0.003;

mdot_kg_s = rho_kg_m3*Q_m3_s;

fprintf('Mass flow rate = %.3f kg/s\n',mdot_kg_s)

%% 18. Reynolds number
% Re = rho*v*D/mu
rho = 998;
velocity = 1.5;
diameter = 0.05;
mu = 0.001;

Re = rho*velocity*diameter/mu;

fprintf('Reynolds number = %.0f\n',Re)

%% 19. Engineering comparison
reading1 = 100;
reading2 = 101.5;

percent_difference = abs(reading2-reading1)/reading1*100;

fprintf('Difference = %.2f %%\n',percent_difference)

if percent_difference < 2
    disp('The readings differ by less than 2%.')
else
    disp('The readings differ by 2% or more.')
end

%% PART C - SELF-PACED PRACTICE

%% 20. Practice 1 - Density
% Complete the calculation:
% density = mass/volume
mass_kg = 12;
volume_m3 = 0.004;

density_kg_m3 = mass_kg/volume_m3;
fprintf('Density = %.2f kg/m^3\n',density_kg_m3)

%% 21. Practice 2 - Work done
% W = F*d*cos(theta)
force_N = 500;
distance_m = 6;
theta_deg = 25;

work_J = force_N*distance_m*cosd(theta_deg);
fprintf('Work = %.2f J\n',work_J)

%% 22. Practice 3 - Efficiency
input_power_W = 1200;
output_power_W = 960;

efficiency_percent = output_power_W/input_power_W*100;
fprintf('Efficiency = %.1f %%\n',efficiency_percent)

%% 23. Practice 4 - Verify a trigonometric identity
angles_deg = [0 30 45 60 90];

identity_value = sind(angles_deg).^2 + cosd(angles_deg).^2;

disp(table(angles_deg',identity_value', ...
    'VariableNames',{'Angle_deg','sin2_plus_cos2'}))

%% 24. Common mistakes
% Mistake 1: forgetting * for multiplication.
% Correct:
x = 5*3;

% Mistake 2: using ** for power.
% Correct:
y = 4^2;

% Mistake 3: forgetting units in reported results.
fprintf('Example result = %.1f N\n',x)

%% 25. Mini challenge - approximate pi
% Leibniz series:
% pi/4 = 1 - 1/3 + 1/5 - 1/7 + ...

nTerms = 1000;
sumValue = 0;

for k = 0:nTerms-1
    sumValue = sumValue + (-1)^k/(2*k+1);
end

pi_approx = 4*sumValue;
absolute_error = abs(pi-pi_approx);

fprintf('Approximate pi = %.8f\n',pi_approx)
fprintf('MATLAB pi      = %.8f\n',pi)
fprintf('Absolute error = %.8f\n',absolute_error)

%% 26. Final review
% Before finishing, make sure you can explain:
% - why descriptive variable names are useful;
% - the difference between = and ==;
% - why units must be included;
% - when to use fprintf instead of disp;
% - how MATLAB represents pi and powers;
% - how an engineering equation becomes executable code.

disp('Week 1 self-paced study complete.')

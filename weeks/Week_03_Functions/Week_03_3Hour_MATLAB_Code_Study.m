%% Week 3 - Functions for Engineering Computation
% ESC 113: Computer Aided Analysis for Engineering
% 3-Hour Self-Paced MATLAB Code Study
%
% Suggested pacing:
% Part A: function inputs, outputs, and local functions
% Part B: engineering function examples
% Part C: testing, reusable design, and practice
%
% Run one %% section at a time. Read comments before the code.

clear
clc
close all

%% PART A - FUNCTION BASICS

%% 1. Why use functions?
% A function packages one calculation into a reusable block.
% Inputs go in, the function performs a calculation, and outputs come back.

mass_kg = 10;
g_m_s2 = 9.81;

weight_N = calculateWeight(mass_kg,g_m_s2);

fprintf('Weight = %.2f N\n',weight_N)

%% 2. Function with one input
% squareValue returns x^2.

result = squareValue(6);

fprintf('6 squared = %.0f\n',result)

%% 3. Function with two inputs
% calculateForce implements F = m*a.

force_N = calculateForce(25,3.2);

fprintf('Force = %.2f N\n',force_N)

%% 4. Multiple outputs
% A MATLAB function can return more than one result.

[area_m2,circumference_m] = circleProperties(0.5);

fprintf('Circle area = %.3f m^2\n',area_m2)
fprintf('Circumference = %.3f m\n',circumference_m)

%% 5. Function using arrays
% The dot operators allow the same function to work on vectors.

velocity_m_s = [2 4 6 8 10];

KE_J = kineticEnergy(5,velocity_m_s);

disp(table(velocity_m_s',KE_J', ...
    'VariableNames',{'Velocity_m_s','KineticEnergy_J'}))

%% 6. Anonymous function
% @(x) creates a compact one-line function.

fahrenheit = @(C) (9/5).*C + 32;

C = [0 20 37 100];
F = fahrenheit(C);

disp(table(C',F','VariableNames',{'Celsius','Fahrenheit'}))

%% 7. Anonymous function with two inputs
power = @(V,I) V.*I;

P = power([12 24 48],[1 2 3]);

disp(P)

%% PART B - ENGINEERING FUNCTIONS

%% 8. Normal stress
% sigma = F/A

sigma_Pa = normalStress(12000,0.004);
sigma_MPa = sigma_Pa/1e6;

fprintf('Stress = %.3f MPa\n',sigma_MPa)

%% 9. Strain
% strain = deltaL/L0

epsilon = engineeringStrain(0.002,1.2);

fprintf('Strain = %.6f\n',epsilon)

%% 10. Density
rho = densityCalc(12,0.004);

fprintf('Density = %.2f kg/m^3\n',rho)

%% 11. Ohm's law
current_A = ohmsLaw(24,8);

fprintf('Current = %.2f A\n',current_A)

%% 12. Electrical power
power_W = electricalPower(24,3.5);

fprintf('Power = %.2f W\n',power_W)

%% 13. Cylinder properties
[volume_m3,surfaceArea_m2] = cylinderProperties(0.4,1.5);

fprintf('Cylinder volume = %.3f m^3\n',volume_m3)
fprintf('Cylinder surface area = %.3f m^2\n',surfaceArea_m2)

%% 14. Reynolds number
Re = reynoldsNumber(998,1.5,0.05,0.001);

fprintf('Reynolds number = %.0f\n',Re)

%% 15. Pump power
% Hydraulic power input estimate:
% P = rho*g*Q*H/efficiency

Ppump_W = pumpPower(998,9.81,0.02,18,0.75);

fprintf('Pump input power = %.2f W\n',Ppump_W)

%% 16. Resultant force
[FR,theta_deg] = resultantForce(300,400);

fprintf('Resultant force = %.2f N\n',FR)
fprintf('Direction = %.2f degrees\n',theta_deg)

%% 17. Sensor error
[absoluteError,percentError] = sensorError(101.8,100);

fprintf('Absolute error = %.2f\n',absoluteError)
fprintf('Percent error = %.2f %%\n',percentError)

%% PART C - FUNCTION TESTING AND DESIGN

%% 18. Test a function with several inputs
loads_N = [5000 10000 15000 20000];
area_m2 = 0.004;

stress_Pa = normalStress(loads_N,area_m2);
stress_MPa = stress_Pa/1e6;

disp(table(loads_N',stress_MPa', ...
    'VariableNames',{'Load_N','Stress_MPa'}))

%% 19. Check expected behavior
% A useful function should behave physically.
% If force doubles and area stays constant, stress should double.

s1 = normalStress(5000,0.005);
s2 = normalStress(10000,0.005);

fprintf('Stress ratio = %.2f\n',s2/s1)

%% 20. Reuse one function inside another calculation
mass_kg = 75;
g = 9.81;

bodyWeight_N = calculateWeight(mass_kg,g);
pressure_Pa = bodyWeight_N/0.02;

fprintf('Pressure under support area = %.2f kPa\n',pressure_Pa/1000)

%% 21. Function input checking concept
% This course focuses on the engineering calculation first.
% Later, functions can also validate inputs such as negative area or zero resistance.

area_m2 = 0.004;

if area_m2 <= 0
    error('Area must be positive.')
else
    sigma = normalStress(12000,area_m2);
    fprintf('Valid stress calculation = %.2f MPa\n',sigma/1e6)
end

%% 22. Guided practice - beam deflection
% Complete and test the local function beamDeflection below.
% Equation: delta = P*L^3/(3*E*I)

delta_m = beamDeflection(1000,2,200e9,8e-6);

fprintf('Beam-tip deflection = %.6f m\n',delta_m)

%% 23. Guided practice - mean and standard deviation
measurements = [10.2 10.5 10.1 10.8 10.4];

[avg,sd] = measurementStats(measurements);

fprintf('Mean = %.3f\n',avg)
fprintf('Standard deviation = %.3f\n',sd)

%% 24. Common mistakes
% Mistake: forgetting to assign the output variable inside a function.
% Mistake: storing a stand-alone function in a file with a different filename.
% Mistake: using ^ instead of .^ when an input may be a vector.
% Mistake: printing inside every function when the caller only needs a returned value.

%% 25. Mini challenge
% Build one reusable function for an engineering equation of your choice.
% Use descriptive units in the variable names.
% Test it with at least three input cases.

disp('Week 3 self-paced study complete.')

%% LOCAL FUNCTIONS
% Local functions must appear after the script code.

function weight_N = calculateWeight(mass_kg,g_m_s2)
    % Calculate weight from W = m*g.
    weight_N = mass_kg*g_m_s2;
end

function y = squareValue(x)
    % Return the square of x. .^ allows scalar or vector input.
    y = x.^2;
end

function force_N = calculateForce(mass_kg,acceleration_m_s2)
    % Newton's second law: F = m*a.
    force_N = mass_kg.*acceleration_m_s2;
end

function [area,circumference] = circleProperties(radius)
    % Return circle area and circumference.
    area = pi*radius.^2;
    circumference = 2*pi*radius;
end

function KE_J = kineticEnergy(mass_kg,velocity_m_s)
    % Calculate KE = 0.5*m*v^2 for scalar or vector velocity.
    KE_J = 0.5*mass_kg.*velocity_m_s.^2;
end

function stress_Pa = normalStress(force_N,area_m2)
    % Calculate normal stress sigma = F/A.
    stress_Pa = force_N./area_m2;
end

function strain = engineeringStrain(deltaL_m,L0_m)
    % Calculate engineering strain = change in length/original length.
    strain = deltaL_m./L0_m;
end

function rho = densityCalc(mass_kg,volume_m3)
    % Calculate density rho = m/V.
    rho = mass_kg./volume_m3;
end

function current_A = ohmsLaw(voltage_V,resistance_ohm)
    % Ohm's law rearranged as I = V/R.
    current_A = voltage_V./resistance_ohm;
end

function power_W = electricalPower(voltage_V,current_A)
    % Electrical power P = V*I.
    power_W = voltage_V.*current_A;
end

function [V,A] = cylinderProperties(r,h)
    % Cylinder volume and total surface area.
    V = pi*r.^2.*h;
    A = 2*pi*r.*h + 2*pi*r.^2;
end

function Re = reynoldsNumber(rho,v,D,mu)
    % Reynolds number Re = rho*v*D/mu.
    Re = rho.*v.*D./mu;
end

function P_W = pumpPower(rho,g,Q,H,efficiency)
    % Estimate pump input power from hydraulic power divided by efficiency.
    P_W = rho.*g.*Q.*H./efficiency;
end

function [FR,theta_deg] = resultantForce(Fx,Fy)
    % Magnitude and direction of a 2D resultant force.
    FR = sqrt(Fx.^2 + Fy.^2);
    theta_deg = atan2d(Fy,Fx);
end

function [absError,pctError] = sensorError(measured,reference)
    % Return absolute and percent error relative to a reference value.
    absError = abs(measured-reference);
    pctError = absError./abs(reference)*100;
end

function delta = beamDeflection(P,L,E,I)
    % Cantilever tip deflection under an end load.
    delta = P.*L.^3./(3.*E.*I);
end

function [avg,sd] = measurementStats(x)
    % Return two descriptive statistics.
    avg = mean(x);
    sd = std(x);
end

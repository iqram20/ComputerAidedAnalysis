%% Week 5 - Iteration and Engineering Simulations
% ESC 113: Computer Aided Analysis for Engineering
% 3-Hour Self-Paced MATLAB Code Study
%
% Part A: for loops and result storage
% Part B: while loops, break, continue, vectorization
% Part C: simple engineering simulations

clear
clc
close all

%% PART A - FOR LOOPS

%% 1. Basic for loop
for i = 1:5
    fprintf('Iteration %d\n',i)
end

%% 2. Velocity table
acceleration_m_s2 = 3;

for t = 0:10
    velocity_m_s = acceleration_m_s2*t;
    fprintf('t = %2d s, v = %5.1f m/s\n',t,velocity_m_s)
end

%% 3. Store loop results
time_s = 0:1:10;
velocity_m_s = zeros(size(time_s));  % preallocate storage

for i = 1:length(time_s)
    velocity_m_s(i) = 9.81*time_s(i);
end

disp(table(time_s',velocity_m_s', ...
    'VariableNames',{'Time_s','Velocity_m_s'}))

%% 4. Plot stored results
figure
plot(time_s,velocity_m_s,'o-')
xlabel('Time (s)')
ylabel('Velocity (m/s)')
title('Velocity from a for Loop')
grid on

%% 5. Electrical power table
R_ohm = 10;
current_A = 1:10;
power_W = zeros(size(current_A));

for i = 1:length(current_A)
    power_W(i) = current_A(i)^2*R_ohm;
end

disp(table(current_A',power_W', ...
    'VariableNames',{'Current_A','Power_W'}))

%% 6. Nested loop example
% Compute a small multiplication table to see how nested loops work.

result = zeros(3,3);

for row = 1:3
    for col = 1:3
        result(row,col) = row*col;
    end
end

disp(result)

%% PART B - WHILE, BREAK, CONTINUE

%% 7. Basic while loop
temperature_C = 20;

while temperature_C < 80
    temperature_C = temperature_C + 10;
    fprintf('Temperature = %.1f C\n',temperature_C)
end

%% 8. Tank filling
volume_L = 0;
flowRate_L_min = 12;
minutes = 0;

while volume_L < 500
    volume_L = volume_L + flowRate_L_min;
    minutes = minutes + 1;
end

fprintf('Tank reached at least 500 L after %d min.\n',minutes)
fprintf('Final discrete volume = %.1f L\n',volume_L)

%% 9. break
measurements = [20 25 30 35 105 40 45];

for i = 1:length(measurements)
    if measurements(i) > 100
        fprintf('Critical reading first found at index %d\n',i)
        break
    end
end

%% 10. continue
data = [12 NaN 15 18 NaN 20];

for i = 1:length(data)
    if isnan(data(i))
        continue
    end

    fprintf('Valid value = %.1f\n',data(i))
end

%% 11. Count threshold exceedances
pressure_kPa = [480 510 495 530 470 550 505];
countHigh = 0;

for i = 1:length(pressure_kPa)
    if pressure_kPa(i) > 500
        countHigh = countHigh + 1;
    end
end

fprintf('Number above 500 kPa = %d\n',countHigh)

%% 12. Vectorized alternative
% For simple array calculations, MATLAB can often avoid a loop.

countHigh_vectorized = sum(pressure_kPa > 500);

fprintf('Vectorized count = %d\n',countHigh_vectorized)

%% PART C - SIMPLE ENGINEERING SIMULATIONS

%% 13. Cooling by fixed amount per minute
temperature_C = 100;
minutes = 0;

while temperature_C >= 40
    temperature_C = temperature_C - 5;
    minutes = minutes + 1;
end

fprintf('Temperature fell below 40 C after %d min.\n',minutes)

%% 14. Exponential cooling with time steps
% Model: dT/dt = -k*(T-Tambient)
% Euler update: next = current + dt*rate

Tamb_C = 22;
k = 0.08;
dt_min = 0.5;
time_min = 0:dt_min:60;

T_C = zeros(size(time_min));
T_C(1) = 95;

for i = 1:length(time_min)-1
    dTdt = -k*(T_C(i)-Tamb_C);
    T_C(i+1) = T_C(i) + dt_min*dTdt;
end

figure
plot(time_min,T_C,'LineWidth',1.5)
xlabel('Time (min)')
ylabel('Temperature (C)')
title('Cooling Simulation')
grid on

%% 15. Tank volume simulation with capacity
Qin = 18;
Qout = 12;
capacity_L = 500;
dt_min = 1;
time_min = 0:dt_min:120;

volume_L = zeros(size(time_min));
volume_L(1) = 100;

for i = 1:length(time_min)-1
    volume_L(i+1) = volume_L(i) + dt_min*(Qin-Qout);

    if volume_L(i+1) >= capacity_L
        volume_L(i+1:end) = capacity_L;
        fprintf('Capacity reached at %.1f min.\n',time_min(i+1))
        break
    end
end

figure
plot(time_min,volume_L,'LineWidth',1.5)
xlabel('Time (min)')
ylabel('Volume (L)')
title('Tank Filling Simulation')
grid on

%% 16. Parameter study
% Repeat the cooling simulation for several values of k.

kValues = [0.03 0.05 0.08 0.12];

figure
hold on

for k = kValues
    T = zeros(size(time_min));
    T(1) = 95;

    for i = 1:length(time_min)-1
        T(i+1) = T(i) + dt_min*(-k*(T(i)-Tamb_C));
    end

    plot(time_min,T,'DisplayName',['k=' num2str(k)])
end

hold off
xlabel('Time (min)')
ylabel('Temperature (C)')
title('Effect of Cooling Constant')
legend
grid on

%% 17. Loop vs vectorized calculation
time_s = 0:1:10;

v_loop = zeros(size(time_s));
for i = 1:length(time_s)
    v_loop(i) = 3*time_s(i);
end

v_vector = 3*time_s;

fprintf('Maximum difference = %.3e\n',max(abs(v_loop-v_vector)))

%% 18. Common mistakes
% Infinite while loop: the condition variable must change.
% MATLAB array indices start at 1.
% Preallocate arrays when storing many loop results.
% Use loops for changing states and decisions; use vectorization when appropriate.

%% 19. Mini challenge
% Simulate battery charge starting at 20%.
% Add 7% per time step until reaching 95%.
% Print the number of steps required.

charge = 20;
steps = 0;

while charge < 95
    charge = charge + 7;
    steps = steps + 1;
end

fprintf('Battery reached at least 95%% after %d steps.\n',steps)

disp('Week 5 self-paced study complete.')

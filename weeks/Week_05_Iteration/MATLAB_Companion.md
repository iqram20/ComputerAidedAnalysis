# Week 5 MATLAB Companion — Loops and Repeated Calculations

## for loop
```matlab
for i = 1:5
    fprintf('Iteration %d\n',i)
end
```

## Repeated engineering calculation
```matlab
time = 0:1:10;            % Time from 0 to 10 s
velocity = zeros(size(time));

for i = 1:length(time)
    velocity(i) = 9.81*time(i);
end

plot(time,velocity)
xlabel('Time (s)')
ylabel('Velocity (m/s)')
grid on
```

## while loop
```matlab
temperature = 20;

while temperature < 80
    temperature = temperature + 10;
    fprintf('Temperature = %.1f C\n',temperature)
end
```

## Python → MATLAB
| Python | MATLAB |
|---|---|
| `for i in range(5):` | `for i = 1:5` |
| `while condition:` | `while condition` |
| indentation closes block | `end` closes block |
| `range(1,11)` | `1:10` |

# Week 4 MATLAB Companion — Branching and Engineering Decisions

## Comparison operators
```matlab
temperature > 80
pressure <= 200
speed == 0
temperature ~= 25       % Not equal
```

## if / elseif / else
```matlab
temperature = 95;

if temperature > 100
    status = "Critical";
elseif temperature > 80
    status = "Warning";
else
    status = "Normal";
end

disp(status)
```

## Logical operators
```matlab
if temperature > 80 && pressure > 150
    disp("Inspection required")
end
```

MATLAB uses:
- `&&` for AND
- `||` for OR
- `~` for NOT

## Engineering example
```matlab
stress = 180;            % MPa
allowable = 250;         % MPa

if stress <= allowable
    disp("Within allowable stress")
else
    disp("Unsafe condition")
end
```

This is the MATLAB equivalent of Python branching used for engineering decision logic.

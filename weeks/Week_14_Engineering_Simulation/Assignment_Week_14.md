# Week 14 Assignment — Engineering Simulation in MATLAB

## Submission

Submit one MATLAB Live Script (`.mlx`) or MATLAB script (`.m`) plus a short report describing assumptions, equations, results, plots, and interpretation.

## Part A — Simulation Concepts

1. Define engineering simulation.
2. Explain physical system vs computational model.
3. Define input, parameter, state variable, and output.
4. Explain why assumptions are necessary.
5. Explain verification.
6. Explain validation.
7. Explain sensitivity analysis.
8. Explain why time-step size matters.

## Part B — Falling Object with Drag

For:

```text
m dv/dt = mg - cv
```

9. Simulate velocity vs time using Euler's method.
10. Plot velocity vs time.
11. Change the drag coefficient and compare results.
12. Calculate analytical terminal velocity.
13. Compare simulated and analytical values.

## Part C — Cooling

For:

```text
dT/dt = -k(T-T_ambient)
```

14. Simulate temperature for 60 minutes.
15. Plot temperature vs time.
16. Repeat for at least three values of `k`.
17. Explain how `k` changes the response.
18. Determine the time required to reach within 2°C of ambient.

## Part D — RC Circuit

For:

```text
dV/dt = (V_source-V)/(RC)
```

19. Simulate capacitor voltage.
20. Plot voltage vs time.
21. Repeat for three resistance values.
22. Explain the RC time constant.
23. Compare the Euler solution with the analytical solution.

## Part E — Tank Simulation

24. Implement a volume-balance simulation.
25. Plot tank volume vs time.
26. Include a maximum-capacity rule.
27. Test at least three inflow conditions.
28. Identify when capacity is reached.

## Part F — Parameter Study

29. Choose one model parameter.
30. Run at least five parameter values.
31. Store the final output for each run.
32. Plot parameter value vs output.
33. Interpret sensitivity.

## Part G — Numerical Stability

34. Run one model with a small time step.
35. Run it again with a much larger time step.
36. Compare results.
37. Discuss stability/accuracy.
38. Explain the computation-time tradeoff.

## Final Mini-Project

Choose one system: thermal cooling, spring-mass-damper, RC circuit, tank filling/draining, projectile with drag, battery discharge, traffic flow, or structural response.

39. Define governing equations.
40. List assumptions.
41. Implement the MATLAB simulation.
42. Generate at least two plots.
43. Perform one parameter study.
44. Perform one verification check.
45. Explain how the model could be validated experimentally.
46. Write a short engineering conclusion.

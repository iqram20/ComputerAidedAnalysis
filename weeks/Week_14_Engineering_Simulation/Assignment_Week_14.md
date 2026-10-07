# Week 14 Assignment — Engineering Simulation

## Submission

Submit either:

- one Python notebook (`.ipynb`), or
- one MATLAB script (`.m`),

plus a short report describing assumptions, equations, results, plots, and interpretation.

---

## Part A — Simulation Concepts

1. Define engineering simulation.
2. Explain the difference between a physical system and a computational model.
3. Define model input, parameter, state variable, and output.
4. Explain why assumptions are necessary.
5. Explain verification.
6. Explain validation.
7. Explain sensitivity analysis.
8. Explain why time-step size matters in a dynamic simulation.

---

## Part B — Mechanical Simulation

Consider a falling object with drag:

m dv/dt = mg - cv

9. Simulate velocity vs time.
10. Plot velocity vs time.
11. Change the drag coefficient and compare results.
12. Estimate terminal velocity.
13. Compare the simulation with the analytical terminal velocity.

---

## Part C — Thermal Simulation

A cooling object follows:

dT/dt = -k(T - T_ambient)

14. Simulate temperature for 60 minutes.
15. Plot temperature vs time.
16. Repeat for at least three values of k.
17. Explain how k changes the response.
18. Determine the time required to reach within 2°C of ambient.

---

## Part D — RC Circuit Simulation

For a charging RC circuit:

dV/dt = (V_source - V)/(RC)

19. Simulate capacitor voltage.
20. Plot voltage vs time.
21. Repeat for three resistance values.
22. Explain the effect of the RC time constant.
23. Compare the simulated response with the analytical solution.

---

## Part E — Tank Simulation

A tank receives inflow Q_in and loses outflow Q_out.

24. Write a volume-balance simulation.
25. Plot tank volume vs time.
26. Include a maximum-capacity warning.
27. Test at least three inflow conditions.
28. Identify when overflow occurs.

---

## Part F — Parameter Study

Choose one of the previous systems.

29. Select one important model parameter.
30. Run the simulation for at least five parameter values.
31. Store the final output for each run.
32. Plot parameter value vs output.
33. Explain which range produces the strongest response.

---

## Part G — Numerical Stability

34. Run one model with a small time step.
35. Run the same model with a much larger time step.
36. Compare results.
37. Explain whether the solution appears stable.
38. Discuss the tradeoff between accuracy and computation time.

---

## Part H — Engineering Interpretation

39. State the assumptions used in your model.
40. State at least two limitations.
41. Identify one source of uncertainty.
42. Explain how you would validate the model experimentally.
43. Explain whether your simulation should be used for real design decisions without additional validation.

---

## Final Mini-Project

44. Choose one engineering system:
- thermal cooling;
- spring-mass-damper;
- RC circuit;
- tank filling/draining;
- projectile with drag;
- battery discharge;
- traffic flow;
- structural load response.

45. Define governing equations.
46. List assumptions.
47. Implement the simulation.
48. Generate at least two plots.
49. Perform one parameter study.
50. Write a short engineering conclusion.

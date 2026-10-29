# Week 12 Python Equivalent — Engineering Data Analysis and Numerical Methods

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import brentq

# 1. Create engineering data
data = pd.DataFrame({
    "Time_s":[0,5,10,15,20,25,30],
    "Temperature_C":[22,25,30,37,45,54,60],
    "Pressure_kPa":[101,110,125,150,185,220,260],
    "FlowRate_L_min":[10,11,12,13,14,15,16],
    "Vibration_mm_s":[1.2,1.5,1.7,2.1,2.8,3.6,4.5]
})
print(data)

# 2. Save and read data
data.to_csv("engineering_sensor_data.csv",index=False)
sensorData = pd.read_csv("engineering_sensor_data.csv")

# 3. Inspect data
print(sensorData.head())
print(sensorData.describe())
print(sensorData.columns)

# 4. Access columns
temperature = sensorData["Temperature_C"]
pressure = sensorData["Pressure_kPa"]
flow = sensorData["FlowRate_L_min"]
time = sensorData["Time_s"]

# 5. Descriptive statistics
print("Mean temperature =", temperature.mean())
print("Median temperature =", temperature.median())
print("Standard deviation =", temperature.std())
print("Minimum =", temperature.min())
print("Maximum =", temperature.max())

# 6. Logical filtering
highPressureData = sensorData[sensorData["Pressure_kPa"] > 180]
print(highPressureData)

# 7. Multiple conditions
warningData = sensorData[
    (sensorData["Temperature_C"] > 45) &
    (sensorData["Pressure_kPa"] > 200)
]
print(warningData)

# 8. Basic engineering plot
plt.figure()
plt.plot(time,temperature,"o-")
plt.xlabel("Time (s)")
plt.ylabel("Temperature (C)")
plt.title("Temperature vs Time")
plt.grid(True)
plt.show()

# 9. Multiple variables
plt.figure()
plt.plot(time,pressure,"o-",label="Pressure (kPa)")
plt.plot(time,flow*10,"s-",label="Flow Rate x 10")
plt.xlabel("Time (s)")
plt.ylabel("Scaled Values")
plt.title("Pressure and Flow Trend")
plt.legend()
plt.grid(True)
plt.show()

# 10. Linear curve fitting
voltage = np.array([0.5,1.0,1.5,2.0,2.5])
temperature_cal = np.array([10,21,31,42,52])
p = np.polyfit(voltage,temperature_cal,1)
slope, intercept = p
predicted_temperature = np.polyval(p,voltage)
print("Slope =",slope)
print("Intercept =",intercept)

plt.figure()
plt.plot(voltage,temperature_cal,"o",label="Measured Data")
plt.plot(voltage,predicted_temperature,label="Linear Fit")
plt.xlabel("Sensor Voltage (V)")
plt.ylabel("Temperature (C)")
plt.title("Sensor Calibration")
plt.legend()
plt.grid(True)
plt.show()

# 11. Predict with fitted model
new_voltage = 1.75
estimated_temperature = np.polyval(p,new_voltage)
print(f"Estimated temperature at {new_voltage:.2f} V = {estimated_temperature:.2f} C")

# 12. Polynomial fitting
x = np.array([0,1,2,3,4,5])
y = np.array([2.0,2.8,4.5,7.2,10.8,15.5])
p2 = np.polyfit(x,y,2)
x_fit = np.linspace(x.min(),x.max(),100)
y_fit = np.polyval(p2,x_fit)

plt.figure()
plt.plot(x,y,"o")
plt.plot(x_fit,y_fit)
plt.xlabel("x")
plt.ylabel("y")
plt.title("Second-Order Polynomial Fit")
plt.grid(True)
plt.show()

# 13. Numerical differentiation
t = np.arange(0,5.1,0.5)
position = np.array([0,0.6,2.4,5.4,9.6,15.0,21.6,29.4,38.4,48.6,60.0])
velocity = np.gradient(position,t)
acceleration = np.gradient(velocity,t)
motion = pd.DataFrame({
    "Time_s":t,
    "Position_m":position,
    "Velocity_m_s":velocity,
    "Acceleration_m_s2":acceleration
})
print(motion)

# 14. Position, velocity, acceleration plots
for values,label in [
    (position,"Position (m)"),
    (velocity,"Velocity (m/s)"),
    (acceleration,"Acceleration (m/s^2)")
]:
    plt.figure()
    plt.plot(t,values)
    plt.xlabel("Time (s)")
    plt.ylabel(label)
    plt.grid(True)
    plt.show()

# 15. Numerical integration
t2 = np.arange(0,11,1)
v = np.array([0,2,4,6,8,10,11,12,12,11,10])
distance = np.trapz(v,t2)
print(f"Estimated distance traveled = {distance:.2f} m")

# 18. Flow-rate integration
time_min = np.array([0,1,2,3,4,5,6])
flow_L_min = np.array([10,11,13,15,14,12,10])
total_volume_L = np.trapz(flow_L_min,time_min)
print(f"Total volume = {total_volume_L:.2f} L")

# 19. Nonlinear equation
def f(x):
    return x**3 - 4*x - 9

root = brentq(f,2,4)
print("Root =",root)
print("Check f(root) =",f(root))

# 20. Drag balance
m = 80
g = 9.81
c = 0.25
def force_balance(v):
    return c*v**2 - m*g

terminal_velocity = brentq(force_balance,0,100)
print(f"Terminal velocity = {terminal_velocity:.2f} m/s")

# 21. Linear system
A = np.array([[2,1],[1,3]],dtype=float)
b = np.array([8,9],dtype=float)
solution = np.linalg.solve(A,b)
print(solution)
print(A @ solution)
print(b)

# 23. Two unknown forces
A_force = np.array([[2,1],[1,3]],dtype=float)
b_force = np.array([100,120],dtype=float)
F = np.linalg.solve(A_force,b_force)
print(f"F1 = {F[0]:.2f} N")
print(f"F2 = {F[1]:.2f} N")

# 24. Stress-strain linear fit
strain = np.array([0,0.0005,0.0010,0.0015,0.0020,0.0025])
stress_MPa = np.array([0,100,200,295,385,465])
pE = np.polyfit(strain,stress_MPa,1)
E_MPa = pE[0]
stress_fit = np.polyval(pE,strain)
print(f"Estimated elastic modulus = {E_MPa:.2f} MPa")
print(f"Estimated elastic modulus = {E_MPa/1000:.2f} GPa")

plt.figure()
plt.plot(strain,stress_MPa,"o",label="Measured")
plt.plot(strain,stress_fit,label="Linear Fit")
plt.xlabel("Strain")
plt.ylabel("Stress (MPa)")
plt.title("Stress-Strain Linear Fit")
plt.legend()
plt.grid(True)
plt.show()

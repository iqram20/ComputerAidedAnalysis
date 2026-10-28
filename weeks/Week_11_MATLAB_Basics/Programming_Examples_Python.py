# Week 11 Python Equivalent — Engineering Programming Review and Matrix Computation

# ESC 113: Computer Aided Analysis for Engineering
# This file mirrors the Week 11 MATLAB examples in Python.

import numpy as np
import matplotlib.pyplot as plt

# 1. Programming as an engineering calculator
print(2 + 3*4)
print((2 + 3)*4)
print(2**5)
print(np.sqrt(81))
print(np.sin(np.pi/6))
print(np.log(10))
print(np.exp(2))

# 2. Variables and formatted output
mass = 25
acceleration = 3.2
force = mass * acceleration
print(f"Force = {force:.2f} N")

voltage = 24
current = 3.5
power = voltage * current
print(f"Electrical power = {power:.2f} W")

# 3. Vectors / arrays
temperature = np.array([20, 22, 24, 26, 28])
pressure = np.array([101.2, 101.8, 102.1, 101.5, 100.9])
time = np.array([0, 1, 2, 3, 4, 5])

# 4. Creating vectors
x1 = np.arange(0, 22, 2)
x2 = np.linspace(0, 10, 6)

# 5. Indexing
v = np.array([10, 20, 30, 40, 50])
first_value = v[0]
third_value = v[2]
last_value = v[-1]
middle_values = v[1:4]

# 6. Matrices
A = np.array([[1,2,3],
              [4,5,6],
              [7,8,9]])
row2 = A[1,:]
col3 = A[:,2]
value_23 = A[1,2]

# 7. Matrix size and transpose
rows, cols = A.shape
AT = A.T
print(f"Rows = {rows}, Columns = {cols}")

# 8. Element-by-element operations
x = np.array([1,2,3,4,5])
x_squared = x**2
x_times_3 = x*3
x_divided_2 = x/2

# 9. Kinetic energy at several velocities
mass = 5
velocity = np.array([2,4,6,8,10])
KE = 0.5*mass*velocity**2
print(KE)

# 10. Built-in statistics
measurements = np.array([12.5,15.8,14.2,18.6,16.1])
print("Mean =", np.mean(measurements))
print("Minimum =", np.min(measurements))
print("Maximum =", np.max(measurements))
print("Standard deviation =", np.std(measurements, ddof=1))

# 11. Logical indexing
pressures = np.array([220,310,450,510,490,540,300])
unsafe = pressures > 500
unsafe_pressures = pressures[unsafe]
print(unsafe_pressures)

# 12. if / elif / else
temperature = 85
if temperature < 70:
    status = "Normal"
elif temperature <= 90:
    status = "Warning"
else:
    status = "Critical"
print("Machine status:", status)

# 13. Battery voltage classifier
battery_voltage = 12.4
if battery_voltage < 11.5:
    battery_status = "Low"
elif battery_voltage <= 13.0:
    battery_status = "Normal"
else:
    battery_status = "High"
print("Battery status:", battery_status)

# 14. for loop - velocity table
acceleration = 3
for t in range(0,11):
    velocity = acceleration*t
    print(f"t = {t:2d} s, v = {velocity:5.1f} m/s")

# 15. for loop - electrical power
R = 10
for I in range(1,11):
    P = I**2*R
    print(f"I = {I:2d} A, P = {P:4d} W")

# 16. while loop - tank filling
volume = 0
flow_rate = 12
minutes = 0
while volume < 500:
    volume += flow_rate
    minutes += 1
print(f"Tank reaches at least 500 L after {minutes} min.")

# 17. Basic 2D plotting
t = np.arange(0,10.1,0.1)
velocity = 3*t
plt.figure()
plt.plot(t,velocity)
plt.xlabel("Time (s)")
plt.ylabel("Velocity (m/s)")
plt.title("Velocity vs Time")
plt.grid(True)
plt.show()

# 18. Projectile motion
v0 = 30
theta_deg = 40
g = 9.81
theta = np.deg2rad(theta_deg)
t_flight = 2*v0*np.sin(theta)/g
t = np.linspace(0,t_flight,100)
x = v0*np.cos(theta)*t
y = v0*np.sin(theta)*t - 0.5*g*t**2
plt.figure()
plt.plot(x,y)
plt.xlabel("Horizontal Distance (m)")
plt.ylabel("Height (m)")
plt.title("Projectile Motion")
plt.grid(True)
plt.show()

# 19. Beam normal stress
load_N = np.array([5000,10000,15000,20000,25000])
area_m2 = 0.004
stress_MPa = (load_N/area_m2)/1e6
plt.figure()
plt.plot(load_N,stress_MPa,"o-")
plt.xlabel("Load (N)")
plt.ylabel("Stress (MPa)")
plt.title("Normal Stress vs Applied Load")
plt.grid(True)
plt.show()

# 20. Fluid flow
rho = 998
mu = 0.001
D = 0.05
velocity = np.arange(0.2,3.01,0.2)
Re = rho*velocity*D/mu
plt.figure()
plt.plot(velocity,Re)
plt.xlabel("Velocity (m/s)")
plt.ylabel("Reynolds Number")
plt.title("Reynolds Number vs Velocity")
plt.grid(True)
plt.show()

# 21. Temperature sensor data
time_min = np.arange(0,31,5)
temp_C = np.array([22,25,30,37,45,54,60])
plt.figure()
plt.plot(time_min,temp_C,"s-")
plt.xlabel("Time (min)")
plt.ylabel("Temperature (°C)")
plt.title("Temperature Sensor Measurements")
plt.grid(True)
plt.show()
print(f"Average temperature = {np.mean(temp_C):.2f} °C")

# 22. Multiple responses
t = np.arange(0,5.1,0.1)
y1 = 3 + np.exp(-t)*np.sin(6*t)
y2 = 4 + np.exp(-t)*np.cos(6*t)
plt.figure()
plt.plot(t,y1,label="Response 1")
plt.plot(t,y2,label="Response 2")
plt.xlabel("Time")
plt.ylabel("Response")
plt.title("Damped Engineering Responses")
plt.legend()
plt.grid(True)
plt.show()

# 23-25. User-defined functions
def calculate_force(mass, acceleration):
    return mass*acceleration

def cylinder_volume(radius, height):
    return np.pi*radius**2*height

def temperature_status(T):
    if T < 70:
        return "Normal"
    elif T <= 90:
        return "Warning"
    return "Critical"

print(f"Calculated force = {calculate_force(12,4.5):.2f} N")
print(f"Cylinder volume = {cylinder_volume(1.5,4):.2f} m^3")
print("Temperature status =", temperature_status(95))

# Navier–Stokes (Incompressible Flow)

**Big idea:** Apply Newton’s 2nd law to a fluid and model viscous stresses as Newtonian.

## Governing equations (constant ρ, μ)

**Momentum:**  
$\frac{\partial \mathbf{u}}{\partial t} + (\mathbf{u}\cdot\nabla)\mathbf{u} = -\frac{1}{\rho}\nabla p + \nu \nabla^{2}\mathbf{u} + \mathbf{f}$

**Continuity (mass):**  
$\nabla\cdot\mathbf{u}=0$

**Symbols:** $\mathbf{u}$ = velocity, $p$ = pressure, $\rho$ = density, $\mu$ = dynamic viscosity, $\nu=\mu/\rho$ = kinematic viscosity, $\mathbf{f}$ = body force per unit mass.

---

## What the terms do
- $\partial\mathbf{u}/\partial t$: local (time) acceleration  
- $(\mathbf{u}\cdot\nabla)\mathbf{u}$: convective acceleration  
- $-\nabla p/\rho$: pressure-gradient acceleration  
- $\nu\nabla^{2}\mathbf{u}$: viscous momentum diffusion  
- $\mathbf{f}$: gravity, rotation, etc.

---

## Where it comes from (one line)
Cauchy momentum + Newtonian stress model:  
$\boldsymbol{\tau}=\mu\left[\nabla\mathbf{u}+(\nabla\mathbf{u})^{T}\right]-\tfrac{2}{3}\mu(\nabla\cdot\mathbf{u})\mathbf{I}$  
with constant $\mu$ and $\nabla\cdot\mathbf{u}=0$ ⇒ Navier–Stokes form.

---

## Dimensionless form & Reynolds number
Using velocity scale $U$ and length scale $L$:  

(∂u*/∂t* + (u*·∇*)u*)  
= −∇*p* + (1/Re)∇*²u* + f*  

where Re = UL/ν

**Limits:** $\mathrm{Re}\ll1$ (Stokes/creeping, drop convection), $\mathrm{Re}\gg1$ (inertia dominated, turbulence possible), $\nu\to0$ (Euler/inviscid).

---

## Canonical solutions
- **Steady:** $\partial/\partial t = 0$  
- **Poiseuille (pressure-driven, fully developed 1D):**  
$-\frac{1}{\rho}\frac{\mathrm{d}p}{\mathrm{d}x} = \nu \frac{\mathrm{d}^{2}u}{\mathrm{d}y^{2}} \;\Rightarrow\; u(y)\ \text{is parabolic}$  
- **Couette (top plate moves $U$, no pressure gradient):**  
$\nu\frac{\mathrm{d}^{2}u}{\mathrm{d}y^{2}}=0 \;\Rightarrow\; u(y)=U\,\frac{y}{H}$

---

## 2D component form
**Continuity:** $\dfrac{\partial u}{\partial x}+\dfrac{\partial v}{\partial y}=0$

**x-momentum:**  
$\dfrac{\partial u}{\partial t}+u\dfrac{\partial u}{\partial x}+v\dfrac{\partial u}{\partial y} = -\dfrac{1}{\rho}\dfrac{\partial p}{\partial x} + \nu\!\left(\dfrac{\partial^{2}u}{\partial x^{2}}+\dfrac{\partial^{2}u}{\partial y^{2}}\right)+f_x$

**y-momentum:**  
$\dfrac{\partial v}{\partial t}+u\dfrac{\partial v}{\partial x}+v\dfrac{\partial v}{\partial y} = -\dfrac{1}{\rho}\dfrac{\partial p}{\partial y} + \nu\!\left(\dfrac{\partial^{2}v}{\partial x^{2}}+\dfrac{\partial^{2}v}{\partial y^{2}}\right)+f_y$

---

## CFD notes (quick)

**BCs:** no-slip at solid walls; prescribe $\mathbf{u}$ at inflow; outflow: zero-gradient for $\mathbf{u}$ with fixed $p$ (or traction).  

**Pressure–velocity coupling (projection idea):**  
Predict intermediate $\tilde{\mathbf{u}}$ → solve $\nabla^{2}p^{n+1}=\frac{\rho}{\Delta t}\,\nabla\cdot\tilde{\mathbf{u}}$ → correct with $\mathbf{u}^{n+1}=\tilde{\mathbf{u}}-\frac{\Delta t}{\rho}\nabla p^{n+1}$.

**Stability (explicit schemes):**  
- Convection (CFL): $\mathrm{CFL}=\dfrac{u_{\max}\,\Delta t}{\Delta x}\lesssim 1$  
- Diffusion: $\dfrac{\nu\,\Delta t}{\Delta x^{2}}\lesssim \tfrac{1}{2}$ (FTCS)

---

*ESC 113 quick reference.*

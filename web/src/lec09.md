---
title: Lecture 9
---

In Lecture 9 we develop a numerical method
for the _heat equation_,
modeling the evolution of temperature in a solid body.

## The heat equation

Let us think about a thin rod of length 1 positioned on the x-axis
between 0 and 1. We suppose that the sides of the rod are kept at a
constant temperature $a$ and $b$, and that the temperature of the rod at
time $t = 0$ and point $x ∈ [0,1]$ is $u_0(x)$. We are interested on
the temperature of the rod at point $x ∈ [0,1]$ at a later time $t >
0$, called $u(x,t)$.

It is useful to think about the temperature $u$ as a function of
position $x ∈ [0,1]$ and time $t ≥ 0$. Then physical [Fourier's
law](https://en.wikipedia.org/wiki/Thermal_conduction#Fourier.27s_law)
implies that the function $u$ is a solution of the [heat
equation][heat-wiki], a _parabolic-type_ partial differential equation:

$$
\left\{
\begin{aligned}
u_t(x, t) &= u_{xx}(x, t),       && 0 < x < 1, t > 0,\\
  u(x, 0) &= u_0(x),           && 0 < x < 1,       \\
  u(0, t) &= a,                && 0 < t,           \\
  u(1, t) &= b,                && 0 < t.
\end{aligned}
\right.
$$

Here $u_t$ is the partial derivative of $u$ with respect to $t$, $u_t =
\frac{\partial u}{\partial t}$ and $u_{xx}$ is the second partial derivative u with respect to
$x$, $u_{xx} = \frac{\partial^2 u}{\partial x^2}$. We assume for simplicity that the heat
conductivity is 1.

We need to prescribe:

- _initial condition_: $u(x, 0) = u_0(x)$, the value of the temperature
  at the initial time $t = 0$. Here $u_0$ is a given function.

- _boundary condition_: $u(0, t) = a$, $u(1, t) = b$, where $a$, $b$ are
  given constants, prescribe what the temperature $u$ is at the boundary
  of the domain $(0, 1)$. This is also called the __Dirichlet boundary
  condition__.

[heat-wiki]: https://en.wikipedia.org/wiki/Heat_equation

_Example_: Assume that $a = b = 0$ and $u_0(x) = \sin(\pi  x)$. Then $u(x,t)
= \sin(\pi x) \exp(-\pi ^2t)$ is a solution of the heat equation. We see that the
solution becomes very close to 0 rather fast. This is an important
feature of the heat equation. In fact, with general boundary data $a$,
$b$, the solutions exponentially fast converges to the _stationary
solution_, the function $(1 - x)a + x b$.

## Numerical method: explicit finite difference method

In contrast to ordinary differential equations, we need to discretize
derivatives both in time and in space. For the discretization of $u_t$,
we use the same idea as for the Euler method: the Taylor series at $t$.
Let $\tau  > 0$ and write:

$$
u(x, t + \tau ) = u(x, t) + \tau  u_t(x, t) + O(\tau^2),
$$
where $O(\tau^2)$ stands for _higher order terms_ proportional to $\tau^2$.

We will therefore approximate

$$
u_t(x, t) \sim  \frac{u(x, t + \tau ) - u(x, t)}\tau.
$$

For the second derivative in $x$, we will use a similar idea. Let $h >
0$ and express

$$
\begin{aligned}
u(x + h, t) &= u(x, t) + h u_x(x, t) + \frac{h^2}2 u_{xx}(x,t) + O(h^3),\\
u(x - h, t) &= u(x, t) - h u_x(x, t) + \frac{h^2}2 u_{xx}(x,t) + O(h^3).
\end{aligned}
$$

Note the opposite sign in front of the first derivative. By adding
these two equalities and subtracting $2 u(x,t)$, we can approximate
$u_{xx}(x,t)$ as

$$
u_{xx}(x,t) \sim  \frac{u(x + h, t) - 2u(x, t) + u(x - h, t)}{h^2}.
$$

We now select an integer $M ≥ 1$ and subdivide the domain $(0,1)$ into
$M$ intervals $(x_k, x_{k+1})$ of length $h = 1 / M$ for $k = 1, ...,
M$. In particular, $x_k = (k - 1) h$, $k = 1, ... M + 1$.

Similarly, we choose time step $\tau  > 0$ and introduce the discrete times
$t_i = i \tau$ for $i = 0, ...$. Let $u_{i, k}$ denote the value of a
numerical approximation of $u(x_k, t_i)$. From the formulas for the
approximation of $u_t$ and $u_{xx}$ and the heat equation, we get the
following numerical scheme

$$
\frac{u_{i+1, k} - u_{i, k}} \tau = \frac{u_{i, k + 1} - 2 u_{i, k} +
u_{i, k - 1}}{h^2}, \qquad i = 0, ..., \quad k = 2, ..., M.
$$

The values $u_{0, k}$ are given by the
initial data $u_0(x_k)$, and the values $u_{i, 1}$, $u_{i, M + 1}$ are given
by the boundary data $a$ and $b$.

We can express $u_{i+1, k}$ in terms of $u_{i, k - 1}$, $u_{i, k}$ and
$u_{i, k + 1}$. Therefore we can advance the solution from time $t_i$ to
time $t_{i + 1}$. This gives us the explicit finite difference method

$$
\left\{
\begin{aligned}
u_{i+1, 1} &= a, && i = 0, \ldots,\\
u_{i+1, k} &= u_{i, k} + \frac\tau{h^2} (u_{i, k + 1} - 2 u_{i, k} +
u_{i, k - 1}), && k = 2, \ldots, M, \ i = 0, \ldots,\\
u_{i+1, M +1} &= b, && i = 0, \ldots,\\
\end{aligned}
\right.
$$

with the initial data

$$
\begin{aligned}
u_{0, k} &= u_0(x_k), && k = 1, \ldots, M + 1.
\end{aligned}
$$

This method is illustrated in the following figure.

![The finite difference method for the heat equation. Diamonds ◆ represent
the initial data while squares ■ represent the boundary data. The value at
a point $(x_i, t_{i+1})$ is computed from the values at points
$(x_{i-1}, t_i)$, $(x_{i}, t_i)$, $(x_{i+1}, t_i)$.](img/fdm.svg)

An example Fortran code for the case $a = b = 0$ and $u_0(x) = \sin(\pi
x)$, $M = 10$ and $\tau  = h^2 / 2$, is
given in the file
[heat.f90][heat-code].

_Exercise:_ Run the code in [heat.f90][heat-code] and plot the result
using gnuplot. To plot two dimensional data (space dimension and time
dimension), we use `splot` instead of `plot`:

```gnuplot
splot 'sol.dat'
```

`splot` stands for _surface plot_.
To connect the data points with lines, add `w l` (`with lines`):
```gnuplot
splot 'sol.dat' w l
```

![Sample gnuplot output](img/heat.svg)

_Exercise:_ Solve the heat equation with the following data:

- $u_0(x) = \sin(\pi x)$, $a = b = 0$
- $u_0(x) = \sin(\pi x) + \sin(3\pi x)$, $a = b = 0$
- $u_0(x) = x(1 - x) + x$, $a = 0$,  $b = 1$
- $u_0(x) = \frac 12 - |x- \frac 12|$, $a = b = 0$

_Exercise:_ Solve the heat equation with the source $f = 1$, initial
data $u_0(x) = 0$, boundary data $a = b = 0$. In this case
$u_t = u_{xx} + f$ and the finite difference scheme is

$$
u_{i+1, k} = u_{i, k} + \frac\tau{h^2} (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}) + f(x_k, t_i).
$$

[heat-code]: https://github.com/rekka/intro-fortran-2016/blob/master/lec09/heat.f90

## Stability of the explicit finite difference scheme

As in the Euler method for ordinary differential equations, the time
step cannot be taken arbitrarily large. In fact, it must be chosen in
relationship to the space discretization parameter $h$:

$$
\tau  ≤ \frac{h^2}2
$$

See [von Neumann stability
analysis](https://en.wikipedia.org/wiki/Von_Neumann_stability_analysis)
for details.

Therefore if we want to have a good space resolution of our method, $h$
small, the number of time steps that we need to take becomes quickly
prohibitively large. In such a case we should use a better numerical
method, for instance implicit methods; see [lecture 10](lec10.html) for
more details.

_Exercise:_ Try to change `tau = h * h / 2.` to `tau = h * h` in
[heat.f90][heat-code] and observe what happens to the numerical
solution.


## Neumann boundary condition

Now instead of prescribing the value of $u$ at $x = 0$ and $x = 1$, we prescribe
the value of the derivative $u_x = \frac{\partial u}{\partial x}$:

$$
\left\{
\begin{aligned}
u_t(x, t) &= u_{xx}(x, t),       && 0 < x < 1, t > 0,\\
  u(x, 0) &= u_0(x),             && 0 < x < 1,       \\
  u_x(0, t) &= a,                && 0 < t,           \\
  u_x(1, t) &= b,                && 0 < t.
\end{aligned}
\right.
$$

This type of boundary condition is called the __Neumann boundary
condition__. We prescribe the value of the derivatives $u_x(0, t) =
\frac{\partial u}{\partial x}(0, t)$ and $u_x(1, t) = \frac{\partial
u}{\partial x}(1, t)$ on the boundary of the domain, instead of the
value of the solution as in the case of the Dirichlet boundary condition.

We have to modify the numerical method at the boundary since now the
values $u_{i, 1}$ and $u_{i, M + 1}$ are unknown. We use the difference
scheme as before:

$$
\begin{equation}
\label{diffscheme}
u_{i+1, k} = u_{i, k} + \frac\tau{h^2} (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}).
\end{equation}
$$

However, when $k = 1$, we need something in place of $u_{i, 0}$ since
$u_{i, 0}$ is a value outside of the domain. We use the second order
symmetric finite difference

$$
\begin{equation}
\label{2nd}
u_x(x, t) = \frac{u(x + h, t) - u(x - h, t)}{2 h} + O(h^2).
\end{equation}
$$

Therefore we can use the value of the derivative $u_x$ on the boundary
to estimate the value of the solution outside of the domain.
From $\eqref{2nd}$ we have $u_{i, 0} \sim u_{i, 2} - 2 h a$.
Similarly, at $x = 1$ we use $u_{i, M + 2} \sim u_{i, M} + 2 h b$.
After substituting this into $\eqref{diffscheme}$, we get for $k = 1$
and $k = M + 1$ the modified scheme

$$
\begin{aligned}
u_{i+1, 1} &= u_{i, 1} + \frac{2\tau}{h^2} ( u_{i, 2} -  u_{i, 1} -  h a),\\
u_{i+1, M + 1} &= u_{i, M + 1} + \frac{2\tau}{h^2} (u_{i, M} - u_{i, M
+ 1} + h b).
\end{aligned}
$$

_Exercise:_ Implement the finite difference method for the heat equation
with initial data $u_0(x) = x (1 - x)$ and Neumann boundary data $u_x(0,
t) = 1$, $u_x(1, t) = 1$.

What is the exact solution?

In Lecture 9 we develop a numerical method
for the _heat equation_,
modeling the evolution of temperature in a solid body.

## The heat equation

Let us think about a thin rod of length 1 positioned on the x-axis
between 0 and 1. We suppose that the sides of the rod are kept at a
constant temperature `a` and `b`, and that the temperature of the rod at
time `t = 0` and point `x ∈ [0,1]` is `u_0(x)`. We are interested on
the temperature of the rod at point `x ∈ [0,1]` at a later time `t >
0`, called `u(x,t)`.

It is useful to think about the temperature `u` as a function of
position `x ∈ [0,1]` and time `t ≥ 0`. Then physical [Fourier's
law](https://en.wikipedia.org/wiki/Thermal_conduction#Fourier.27s_law)
implies that the function `u` is a solution of the [heat
equation](heat-wiki), a _parabolic-type_ partial differential equation:

```
u_t(x, t) = u_xx(x, t),        0 < x < 1, t > 0,
  u(x, 0) = u_0(x),            0 < x < 1,
  u(0, t) = a,                 0 < t,
  u(1, t) = b,                 0 < t.
```

Here `u_t` is the partial derivative of `u` with respect to `t`, `u_t =
∂u/∂t` and `u_xx` is the second partial derivative u with respect to
`x`, `u_xx = ∂²u/∂x²`. We assume for simplicity that the heat
conductivity is 1.

[heat-wiki]: https://en.wikipedia.org/wiki/Heat_equation

_Example_: Assume that `a = b = 0` and `u_0(x) = sin(π x)`. Then `u(x,t)
= sin(πx) exp(-π²t)` is a solution of the heat equation. We see that the
solution becomes very close to 0 rather fast. This is an important
feature of the heat equation. In fact, we general boundary data `a`,
`b`, the solutions exponentially fast converges to the _stationary
solution_, the function `(1 - x)a + x b`.

## Numerical method: explicit finite difference method

In contrast to ordinary differential equations, we need to discretize
derivatives both in time and in space. For the discretization of `u_t`,
we use the same idea as for the Euler method: the Taylor series at `t`.
Let `τ > 0` and write:

```
u(x, t + τ) = u(x, t) + τ u_t(x, t) + higher order terms.
```

We will therefore approximate

```
τ u_t(x, t) ∼ u(x, t + τ) - u(x, t).
```

For the second derivative in `x`, we will use a similar idea. Let `h >
0` and express

```
u(x + h, t) = u(x, t) + h u_x(x, t) + h²/2 u_xx(x,t) + higher order terms.
u(x - h, t) = u(x, t) - h u_x(x, t) + h²/2 u_xx(x,t) + higher order terms.
```

Note the opposite sign in front of the first derivative. By adding
these two equalities and subtracting `2 u(x,t)`, we can approximate
`u_xx(x,t)` as

```
h²/2 u_xx(x,t) ∼ u(x + h, t) - 2u(x, t) + u(x - h, t).
```

We now select an integer `M ≥ 1` and subdivide the domain `(0,1)` into
`M` intervals `(x_k, x_{k+1})` of length `h = 1 / M` for `k = 1, ...,
M`. In particular, `x_k = (k - 1) h`, `k = 0, ... M`.

Similarly, we choose time step `τ > 0` and introduce the discrete times
`t_i = i τ` for `i = 0, ...`. Let `u_{i, k}` denote the value of a
numerical approximation of `u(x_k, t_i)`. From the formulas for the
approximation of `u_t` and `u_xx` and the heat equation, we get the
following numerical scheme

```
(u_{i+1, k} - u_{i, k}) / τ = (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}) / h²,
```

`i = 1, ...`, `k = 2, ..., M`. The values `u_{0, k}` are given by the
initial data `u_0(x_k)`, and the values `u_{i, 1}`, `u_{i, M + 1}` are given
by the boundary data `a` and `b`.

We can express `u_{i+1, k}` in terms of `u_{i, k - 1}`, `u_{i, k}` and
`u_{i, k + 1}`. Therefore we can advance the solution from time `t_i` to
time `t_{i + 1}`. This gives us the explicit finite difference method

```
u_{i+1, k} = u_{i, k} + τ / h² * (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}).
```

An example Fortran code for the case `a = b = 0` and `u_0(x) = sin(π
x)`, `M = 10` and `τ = h² / 2`, is
given in the file
[`heat.f90`](heat-code).

_Exercise:_ Run the code in [`heat.f90`](heat-code) and plot the result
using gnuplot. To plot two dimensional data (space dimension and time
dimension), we use `splot` instead of `plot`:

```gnuplot
> splot 'sol.dat'
```

To connect the data points with lines, add `w l` (`with lines`):
```gnuplot
> splot 'sol.dat' w l
```

_Exercise:_ Solve the heat equation with the following data:

- `u_0(x) = sin(πx)`, `a = b = 0`
- `u_0(x) = sin(πx) + sin(3πx)`, `a = b = 0`
- `u_0(x) = x(1 - x) + x`, `a = 0`,  `b = 1`
- `u_0(x) = 1/2 - |x- 1/2|`, `a = b = 0`

_Exercise:_ Solve the heat equation with the source `f = 1`, initial
data `u_0(x) = 0`, boundary data `a = b = 0`. In this case
`u_t = u_xx + f` and the finite difference scheme is

```
u_{i+1, k} = u_{i, k} + τ / h² * (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}) + f(x_k, t_i).
```

[heat-code]: https://github.com/rekka/intro-fortran-2016/blob/master/lec08/heat.f90

## Stability of the explicit finite difference scheme

As in the Euler method for ordinary differential equations, the time
step cannot be taken arbitrarily large. In fact, it must be chosen in
relationship to space discretization `h`:

```
τ ≤ h²/2
```

See [von Neumann stability
analysis](https://en.wikipedia.org/wiki/Von_Neumann_stability_analysis)
for details.

Therefore if we want to have a good space resolution of our method, `h`
small, the number of time steps that we need to take becomes quickly
prohibitively large. In such a case we should use a better numerical
method, for instance implicit methods.

_Exercise:_ Try to change `tau = h * h / 2.` to `tau = h * h` in
[`heat.f90`](heat-code) and observe what happens to the numerical
solution.


## Neumann boundary condition

Now instead of prescribing the value of `u` at `x = 0` and `x = 1`, we prescribe
the value of the derivatives:

```
    u_t(x, t) = u_xx(x, t),        0 < x < 1, t > 0,
      u(x, 0) = u_0(x),            0 < x < 1,
    u_x(0, t) = a,                 0 < t,
    u_x(1, t) = b,                 0 < t.
```

We have the modify the numerical method at the boundary since now the
values `u_{i, 1}` and `u_{i, M + 1}` are unknown. We use the difference
scheme as before:

```
u_{i+1, k} = u_{i, k} + τ / h² * (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}).
```

However, when `k = 1`, we need something in place of `u_{i, 0}`. We use
the value of the derivative at `x = 0`: `u_{i, 1} = u_{i, 2} - h * a`.
Similarly, at `x = 1` we use `u_{i, M + 2} = u_{i, M + 1} + h * b`.
Therefore for `k = 1` and at `k = M + 1` we get the modified scheme

```
u_{i+1, 1} = u_{i, 1} + τ / h² * (u_{i, 2} - u_{i, 1} - h * a).
u_{i+1, M + 1} = u_{i, M + 1} + τ / h² * (u_{i, M} - u_{i, M + 1} + h * b).
```

_Exercise:_ Implement the finite difference method for the heat equation
with initial data `u_0(x) = x (1 - x)` and Neumann boundary data `u_x(0)
= 1`, `u_x(1) = 1`.

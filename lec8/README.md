In lecture 8 we will start to learn about numerical methods for
_partial differential equations_. Our first stop is the _heat equation_,
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
`M` intervals `(x_{k-1}, x_k)` of length `h = 1 / M` for `k = 1, ...,
M`. In particular, `x_k = k h`, `k = 0, ... M`.

Similarly, we choose time step `τ > 0` and introduce the discrete times
`t_i = i τ` for `i = 0, ...`. Let `u_{i, k}` denote the value of a
numerical approximation of `u(x_k, t_i)`. From the formulas for the
approximation of `u_t` and `u_xx` and the heat equation, we get the
following numerical scheme

```
(u_{i+1, k} - u_{i, k}) / τ = (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}) / h²,
```

`i = 1, ...`, `k = 1, ..., M-1`. The values `u_{0, k}` are given by the
initial data `u_0(x_k)`, and the values `u_{i, 0}`, `u_{i, M}` are given
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



[heat-code]: https://github.com/rekka/intro-fortran-2016/blob/master/lec8/heat.f90

## Arrays in Fortran

The variables in Fortran that we have see so far store exactly 1 value.
To store multiple values in one variable, we can use arrays. An array is
a data structure that stores a given number of _indexed_ values of the same type.
See [Lecture 5, Arrays in Fortran](https://github.com/rekka/intro-fortran-2016/tree/master/lec5#arrays-in-fortran).

To declare an array of `N` elements in Fortran, where `N`, we use the
statement `dimension(N)` when declaring a variable. For example, to
introduce an array `x` of `5` real values, we declare `x` as

```fortran
real, dimension(5) :: x
```

The variable `x` now stores 5 values denoted as: `x(1)`, `x(2)`, ..., `x(5)`.

___Note___: Trying to access other elements, such as `x(0)`, `x(6)` is
an error. Fortran might not complain, but accessing this values will
likely crash your program and not give correct results.

To initialize an array, we can use the notation

```fortran
x = (/ 1., 2., 3., 4., 5. /)
```

This is equivalent to

```fortran
do i=1,5
    x(i) = i
end do
```

Printing the all the values of the array on one line, separated by spaces, is as
simple as

```fortran
write(*,*) x
```

The _size_ of the array is the number of its elements. You can use the
function `size` to find it in your code:

```fortran
write(*,*) size(x)
```

_Example:_ Suppose that we want to compute the sum of array `x`. We can
use the `do` loop:

```fortran
real :: s

s = 0.
do i=1,size(x)
    s = s + x(i)
end do
write(*,*) s
```

_Exercise:_ Suppose that `x` is an array with 11 elements, the values of
function `t(1 - t)` at points `t = 0., 0.1, 0.2,
..., 1.0`. Write the code for computing the sum, average, product, maximum and
minimum value of values in array `x` (using `do` loop).

_Exercise:_ Let `x` be an array of size `N`. Find the `l²`-norm of `x`: `|x| =
(x(1)² + x(2)² + ... + x(N)²)^(1/2)`.

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
values `u_{i, 0}` and `u_{i, M}` are unknown. We use the difference
scheme as before:

```
u_{i+1, k} = u_{i, k} + τ / h² * (u_{i, k + 1} - 2 u_{i, k} + u_{i, k - 1}).
```

However, when `k = 0`, we need something in place of `u_{i, -1}`. We use
the value of the derivative at `x = 0`: `u_{i, -1} = u_{i, 0} - h * a`.
Similarly, at `x = 1` we use `u_{i, M + 1} = u_{i, M} + h * b`.
Therefore for `k = 0` and at `k = M` we get the modified scheme

```
u_{i+1, 0} = u_{i, 0} + τ / h² * (u_{i, k + 1} - u_{i, k} - h * a).
u_{i+1, M} = u_{i, M} + τ / h² * (u_{i, k - 1} - u_{i, k} + h * b).
```

_Exercise:_ Implement the finite difference method for the heat equation
with initial data `u_0(x) = x (1 - x)` and Neumann boundary data `u_x(0)
= 1`, `u_x(0) = 1`.

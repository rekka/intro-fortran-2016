Lecture 10: writing code for heat equation and preparing for a
presentation

## Presentation: The heat equation

Implement the explicit finite difference method for solving the heat
equation on the domain `x ∈ (0, 1)`, `t ∈ (0, ½)` as explained in
[lecture 9](https://github.com/rekka/intro-fortran-2016/tree/master/lec09).

Parameters are `M = 10`, `τ = ½h²`. Use the following initial and boundary data:

1. Dirichlet boundary condition `u(0, t) = a`, `u(1, t) = b`:

    - `u_0(x) = sin(πx)`, `a = b = 0`
    - `u_0(x) = sin(πx) + sin(3πx)`, `a = b = 0`

2. Neumann boundary condition `u_x(0, t) = a`, `u_x(1, t) = b`:

    - `u_0(x) = x(1 - x) + x`, `a = 0`,  `b = 0`
    - `u_0(x) = 1/2 - |x- 1/2|`, `a = 1`, `b = -1`

Plot the solutions using gnuplot. To store the plot as an image file, you can
use the gnuplot commands:

```gnuplot
set terminal pngcairo size 800,600
set output 'graph.png'
splot 'sol.dat' w l
```

- `graph.png` is the image file name; you can use anything you want
  (with extension `.png`)
- `800,600` is the size of the image in pixels


Test the order of the method by comparing the numerical solution to the
exact solution for the problem with the Dirichlet boundary condition and
data: `u_0(x) = sin(πx)`, `a = b = 0`.
Recall that the exact solution is `u(x,t) = exp(-π²t) sin(πx)`. Compare
the exact solution `u` and the numerical solution `u_{i, k}` using the
maximum norm at `t = 0.1`: Set `i = 0.1 / τ` and compute

```
max {|u(x_k, t_i) - u_{i, k}|: k=1, ..., M+1}.
```

Use `M = 10, 20, 40`, `τ = ½h²`. If your code is correct, the norm
should get approximately 4 times smaller whenever M is taken 2 times bigger.

___Bonus:___

Implement the implicit methods explained below to solve the heat
equation with the data above.

## Implicit method: removing the stability restriction

The stability restriction `τ ≤ h²/2` can be quite limiting in practice
if `h` is small. In such a case, we might want to consider an implicit
method that is unconditionally stable. To obtain this method, we
approximate `u_t(x_k, t_i)` by the backwards difference `(u_{i,k} -
u_{i-1,k})/τ`. This yields the following difference scheme:

```
u_{i+1, k} = u_{i, k} + τ / h² * (u_{i + 1, k + 1} - 2 u_{i + 1, k} + u_{i + 1, k - 1}).
```

for `k = 2, ..., M`.
We consider Dirichlet boundary condition `u_{i, 1} = a`, `u_{i, M + 1} =
b` for any `i ≥ 0`.

Now to find the solution at `t = t_{i+1}` we need to solve a system of
`M - 1` linear equations for `M - 1` variables `u_{i + 1, 2}, ..., u_{i + 1, M}`.

Let us fix `i` and simplify the notation by writing `u_k = u_{i,k}`,
`v_k = u_{i + 1,k}`. Let us set `c = τ / h²`. Then the linear system is

```
...
-c v_{k - 1} + (1 + 2 c) v_{k} - c v_{k + 1} = u_k
...
```

This system can be efficiently solved using the [tridiagonal matrix
algorithm](https://en.wikipedia.org/wiki/Tridiagonal_matrix_algorithm).

## Higher order method

So far we have covered only methods that whose error of time
discretization is `O(τ)`. To improve the accuracy, we can use the
[Crank-Nicolson
method](https://en.wikipedia.org/wiki/Crank%E2%80%93Nicolson_method). It
is the "average" of explicit and implicit methods that we have covered
so far:

```
u_{i+1, k} = u_{i, k} + τ / (2h²) * (u_{i + 1, k + 1} - 2 u_{i + 1, k} + u_{i + 1, k - 1})
                      + τ / (2h²) * (u_{i, k + 1} - 2 u_{i, k} + u_{i,  k - 1})
```

This again leads to a system of linear equations to find the solution at
time `t = t_{i+1}`. Again, the solution can be found using the
tridiagonal matrix algorithm.



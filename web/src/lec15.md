---
title: Lecture 15
---

Today we introduce Poisson's equation in one dimension and a numerical
method to find a solution.

## Poisson's equation

Poisson's equation is the differential equation

$$
-u'' = f
$$
for an unknown function $u = u(x)$. It states that the negative second derivative
of $u$ is equal to the given function $f = f(x)$.
We will consider the boundary value problem for this equation.

Let $f$ be a given continuous function of the interval
$[0,1]$. Given the boundary data given by real numbers $a, b$, find the continuous
function $u$ on the interval $[0,1]$,
twice continuously differentiable in $(0,1)$ that satisfies

$$
\begin{align*}
\left\{
\begin{aligned}
-u''(x) &= f(x), && x \in (0,1),\\
u(0) &= a,\\
u(1) &= b.
\end{aligned}
\right.
\end{align*}
$$

This problem appears in many fields of science. For example, the
trajectory of objects in a gravitational field, the
stationary distribution of temperature, pressure, etc.
It is therefore important to numerically solve this problem efficiently.

__Example.__ Suppose that $f \equiv 1$. Then the general solution of
$-u'' = f$ is $u(x) = -\frac 12 x(1 - x) + (b - a) x + a$. The constants
$a$ and $b$ are then given by the boundary data.
The graph of $u$ in this case is the trajectory of an object in a
uniform gravitational field with acceleration $1$ pointing down,
traveling with horizontal velocity $1$ m/s, starting from the point $(0,
a)$ and arriving at point $(1, b)$ at time $t = 1$s.

__Example.__ Suppose that $f(x) = 5x$, $a = 0$, $b = 2$. Then the exact
solution can be written as $u(x) = - \frac 56 x^3 + \frac 56 x + 2x$.
See the following figure. Note that the graph of $u$ is fairly straight
when $|f|$ is small, but gets progressively more bent as $|f|$
increases.

![Graph of the solution of Poisson's equation for $f(x) = 5x$, $a = 0$,
$b = 1$](img/simple_poisson.svg)

## Numerical scheme for Poisson's equation

As before, we split the interval $[0,1]$ into $K \geq 1$ subintervals $[x_{k-1},
x_k]$ with $k = 1, \ldots, K$ of equal length $h = \frac 1K$, $x_k := k
h$.
Using Taylor's series, we can approximate $u''(x_k)$ using the values
$u$ at the neighboring points:

$$
-f(x_k) = u''(x_k) \sim \frac{u(x_{k-1}) - 2 u(x_k) + u(x_{k+1})}{h^2} + O(h^2).
$$

We thus seek an approximate solution $u_k \sim u(x_k)$. This function
should satisfy

$$
- \frac{u_{k-1} - 2 u_k + u_{k+1}}{h^2} = f(x_k), \qquad k = 1, \ldots,
  K- 1,
$$
where we set $u_0 = a$ and $u_K = b$ from the boundary condition.
This leads to a system of $K-1$ equations for $K-1$ variables $u_1,
\ldots, u_{K-1}$:

$$
\begin{align*}
2 u_{1} - u_{2} &= h^2 f(x_1) + a\\
- u_{1} + 2 u_{2} - u_{3} &= h^2 f(x_2)\\
&\vdots\\
- u_{k-1} + 2 u_{k} - u_{k+1} &= h^2 f(x_2)\\
&\vdots\\
-u_{K-2} + 2 u_{K-1} &= h^2 f(x_2) + b.
\end{align*}
$$

The matrix of this system is tridiagonal, as so it can be
efficiently solved using the [tridiagonal matrix
algorithm](#gaussian-elimination-for-tridiagonal-systems).

__Exercise.__

 1. Use the above method to find the numerical solutions with the following
parameters:

    1. $f(x) = 1$, $a = 1$, $b = 2$.
    1. $f(x) = \sin x$, $a = -1$, $b = 1$.
    1. $f(x) = \cos (\pi x) + 10 \sin(3 \pi x)$, $a = -1$, $b = -1$.

    Use $K = 10$, $h = 1 / K = 0.1$.
    Plot the graph of each solution using gnuplot and compare with the exact
    solution.

    __Upload the code for (iii) to Acanthus portal under the name
    `poisson_iii.f90`.__ The code should compile, and when run, it should
    print the values of the numerical solution in the following form:

    ```
    0.      -1.
    0.1     ...
    ... 8 lines omitted
    1.      -1.
    ```

 2. Estimate the order of the method: Solve 1(ii) above for
    a sequence of $K = 10, 20, 40, 80, 160, 320, 640$.
    For each $K$, you will obtain a solution that we will denote as
    $u^K = (u^K_1, \ldots, u^K_{K-1})$. Let $u(x)$ be the exact solution
    of Poisson's equation with the given data^[Note that $u(x) = \sin x
     + 2x - 1$]. For each $K$, compute the
    following two errors:
    $$
    \begin{align*}
        e_2(K) &:= \sqrt{\frac 1K\sum_{k=1}^{K-1} |u^K_k - u(x_k)|^2},\\
        e_\infty(K) &:= \max_{1 \leq k \leq K-1} |u^K_k - u(x_k)|.
    \end{align*}
    $$

    Plot the graphs $e_2(K)$ as a function of $K$ and $e_\infty(K)$ as a
    function of $K$ using gnuplot. Use the logarithmic scale. What is
    the order of the method^[Estimate an integer $p$ such that $e_2(K) \sim K^{-p} =
    h^p$.]?

    __Upload the code to Acanthus portal under the name `error.f90`.__
    The code should compile, and when run it should print the value of
    the errors $e_2$ and $e_\infty$ for each $K$ on a line:
    ```
    10      error2      error_inf
    20      ...         ...
    ...
    640     ...         ...
    ```

    _Hint._
    Write a Fortran function that for given $K$ computes the solution of
    Poisson's equation and returns the error. The signature might be

    ```fortran
    function error2(K)
        implicit none
        integer, intent(in) :: K
        real, dimension(K - 1) :: u, b      ! arrays for computation
        real :: error2

        ! compute u for given K
        ! compute error2
        error2 = ...
    end function
    ```

    Then call this function in a loop to get values of $e_2(K)$ for all
    $K$.

 3. Repeat 2. for 1(i). What is the error?




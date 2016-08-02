---
title: 'Lecture 16: Final report problems'
---

Write a Fortran code for the following problems, and upload the requested files to
the Acanthus portal in __`テスト・アンケート　→　Final report`__.

The submission deadline is __Thursday, August 4th, 14:45__.

When preparing the final report, you can use any resources provided by
these lecture notes, including code examples. However, do not discuss the
solution or the code with other students, and do not use other students'
code.

The maximum score is 50 points.

## Problem 1 (20 points)

Use Newton's method to find the numerical solution $x$ of the following
equation^[The solution of this equation $y(x)$ is called the [Lambert
W-function](https://en.wikipedia.org/wiki/Lambert_W_function).] for given $y$:

$$
y = x e^x.
$$

Use $5$ iterations of Newton's method with initial guess $x_0 = \ln
y$ (function `log` in Fortran).

Set
$$
y_0 = 1 + (\text{the last 2 digits of your student ID number
(学籍番号)}).
$$

Compute the values of $x(y_i)$ for $y_i = y_0 + i$, $i = 0, \ldots, 100$.
Plot the values $x(y)$ as a function of $y$ using the values above.

__Upload the code as `newton.f90`.__ The code should compile, and when run, it should
print the values $y_i$, $x(y_i)$ one pair per line in the following form:

```
   1.00000000      0.567143321
   2.00000000      0.852605522
   3.00000000       1.04990888
    ...
```

__Upload the plot as `newton.png`.__
Use __your name in romaji__ as the plot title.
You can use the following code to generate the plot (save the output of
the Fortran program to `sol.dat` first):

```gnuplot
set term pngcairo size 1024,768
set output 'newton.png'
set title 'your name'

plot 'sol.dat' with lines

set output
```

## Problem 2 (10 points)

Compute the discrete $l^2$-distance and the maximum distance between the values of $\sin \pi x$ and
$\cos \pi x$ at points $x_1, \ldots, x_N$, defined as $x_k = k h$,
where $h = 1/N$. The _discrete $l^2$-distance_ is defined as

$$
d_2 := \sqrt{\frac 1N \sum_{k = 1}^N |\sin(\pi x_k) - \cos(\pi x_k)|^2}.
$$

The _maximum distance_ is defined as

$$
d_\infty := \max \{|\sin(\pi x_k) - \cos(\pi x_k)|: 1 \leq k \leq N\}.
$$

Use

$$
N = 100 + (\text{the last 3 digits of your student ID number (学籍番号)}).
$$

__Upload the code as `dist.f90`.__ The code should compile, and when run, it should
print the value of the discrete $l^2$ distance $d_2$ and the maximum
distance $d_\infty$ in the following form ($d_2$ on the first line, the
actual numbers are different):

```
4.2341
0.5234
```

## Problem 3 (20 points)

Solve the Dirichlet problem for the heat equation

$$
\begin{align}
\left\{
\begin{aligned}
u_t(x, t) &= u_{xx}(x, t),       && 0 < x < 1, 0 < t < t_1,\\
  u(x, 0) &= u_0(x),           && 0 < x < 1,       \\
  u(0, t) &= a_0,                && 0 < t < t_1,           \\
  u(1, t) &= a_1,                && 0 < t < t_1,
\end{aligned}
\right.
\label{heat}
\end{align}
$$

using the
Crank-Nicholson method

$$
\begin{align*}
u_{i+1, k} = u_{i, k} &+ \frac \tau {2h^2} (u_{i + 1, k + 1} - 2 u_{i + 1, k} + u_{i + 1, k - 1})\\
                      &+ \frac \tau {2h^2} (u_{i, k + 1} - 2 u_{i, k} + u_{i,  k - 1})
\end{align*}
$$

Let us for simplicity denote $v_k = u_{i+1,k}$ and $u_k = u_{i,k}$.
Fix parameters $h > 0$, $\tau > 0$, $x_k = (k - 1) h$, $t_i = \tau i$,
$1 \leq k \leq M+1$, $0 \leq i \leq N$.
To find the approximate solution at time $t_{i+1}$ (the unknown values $v_2,
\ldots, v_M$), we need to
find the solution of the linear system:

$$
\begin{align*}
(1 + 2 c) v_{2} - c v_{3} &= 2 c a_0 + (1- 2c) u_2 + c u_3\\
-c v_{2} + (1 + 2 c) v_{3} - c v_{4} &=  c u_2 + (1 - 2c) u_3 + c u_4\\
&\vdots\\
-c v_{k - 1} + (1 + 2 c) v_{k} - c v_{k + 1} &= c u_{k-1} + (1 - 2c) u_k
 + c u_{k+1}\\
&\vdots\\
-c v_{M - 2} + (1 + 2 c) v_{M - 1} - c v_{M} &= c u_{M-2} + (1 - 2c)
 u_{M-1}
 + c u_M\\
-c v_{M - 1} + (1 + 2 c) v_{M} &= c u_{M-1} + (1 - 2c) u_M + 2 c a_1
\end{align*}
$$
where $c := \frac{\tau}{2h^2}$, and $a_0, a_1$ are given boundary data in
$\eqref{heat}$.

Once you compute the right-hand side and store it in an array, you
can use the function `tridial_solve` that we already implemented in
[`implicit_heat.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec14/implicit_heat.f90)
to
find the array $v$ since the matrix of the system is tridiagonal.

Use the following parameters: $M = 64$, $h = 1/M$, $t_1 = 0.1$,
$\tau = h$, $N = t_1 / \tau$, $a_0 = -1$, $a_1 = 2$,

$$
u_0(x) = -\cos (3 \pi x) + x.
$$

__Upload the code as `crank.f90`.__ The code should compile, and when run, it should
print the values of the solution, one point per line, with
individual time steps separated by empty lines:

```
t_0   x_1       u_{0, 1}
t_0   x_2       u_{0, 2}
...
t_0   x_{M+1}   u_{0, M+1}


t_1   x_1       u_{1, 1}
t_1   x_2       u_{1, 2}
...
t_1   x_{M+1}   u_{1, M+1}

t_2   ...
...

```

__Plot the graph of the solution using gnuplot and upload it as
`crank.png`.__

Use __your name in romaji__ as the title.
You can use the following gnuplot commands to produce a 3D plot.

```gnuplot
set term pngcairo size 1024,768
set output 'crank.png'
set title 'your name'

splot 'sol.dat' with lines

set output
```

Here `sol.dat` is a file where you stored the output of your program.


_Hint._ This is a simple modification of
[`implicit_heat.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec14/implicit_heat.f90).




---
title: Lecture 14
---

Today we introduce the implicit method for the heat equation.

## Submitting files through the Acanthus portal

 1. Use the code that you wrote in
    [lecture 13](lec13.html#gaussian-elimination-for-tridiagonal-systems)
    to find the solution $x$ of the system $A x = b$, where $A$ is the
    matrix
    $$
    A =
    \begin{pmatrix}
    -3 & 1 & 0\\
    1 & -3 & 1\\
    0 & 1 &-3
    \end{pmatrix},
    $$
    and $b$ is the vector of the last 3 digits of your student number
    (学籍番号). For
    example, if your student number is `0123456789`, use $b = (7., 8., 9.)$.

    Name the file `solver.f90`.
    The code should use the tridiagonal matrix solver to find $x$, and print
    it as the output:

    ```
    $ gfortran solver.f90 -o a.exe && ./a.exe
      -4.23809528      -5.71428537      -4.90476179
    ```

    (Your output $x$ will be most likely different :).)

 2. Upload this code as the answer to the Acanthus portal:

    - __数値解析序論１＞コースメニュー＞テスト・アンケート＞Lecture 14__

    Click _`Browse...`_, select your file, and then click _`レポート提出`_. Make
    sure that the file is uploaded, and click _`終了`_.

## Implicit method for the heat equation: removing the stability restriction

The [stability
restriction](lec09.html#stability-of-the-explicit-finite-difference-scheme) $\tau ≤ h^2/2$ for the explicit method for the
cheat equation an be quite limiting in practice
if $h$ is small. In such a case, we might want to consider an __implicit
method__ that is unconditionally stable. To obtain this method, we
approximate $u_t(x_k, t_i)$ by the backwards difference $(u_{i,k} -
u_{i-1,k})/\tau$. This yields the following difference scheme:

$$
u_{i+1, k} = u_{i, k} + \frac \tau{h^2} (u_{i + 1, k + 1} - 2 u_{i + 1, k} + u_{i + 1, k - 1}).
$$

for $k = 2, \ldots, M$.
We consider Dirichlet boundary condition $u_{i, 1} = a$, $u_{i, M + 1} =
b$ for any $i ≥ 0$.

Now to find the solution at $t = t_{i+1}$ we need to solve a system of
$M - 1$ linear equations for $M - 1$ variables $u_{i + 1, 2}, \ldots, u_{i + 1, M}$.

Let us fix $i$ and simplify the notation by writing $u_k = u_{i,k}$,
$v_k = u_{i + 1,k}$. Let us set $c = \tau / h^2$. Then the linear system is

$$
\begin{align*}
(1 + 2 c) v_{2} - c v_{3} &= u_2 + c a\\
-c v_{2} + (1 + 2 c) v_{3} - c v_{4} &= u_3\\
&\vdots\\
-c v_{k - 1} + (1 + 2 c) v_{k} - c v_{k + 1} &= u_k\\
&\vdots\\
-c v_{M - 2} + (1 + 2 c) v_{M - 1} - c v_{M} &= u_{M - 1}\\
-c v_{M - 1} + (1 + 2 c) v_{M} &= u_M + c b
\end{align*}
$$

This system can be efficiently solved using the [tridiagonal matrix
algorithm](#gaussian-elimination-for-tridiagonal-systems).

__Exercise.__ Use the implicit method to solve the heat equation with
initial data $u_0(x) = \sin(\pi x)$, and boundary data $u(0) = u(1) =
0$, on the domain $(0,1)$ using $h = 0.1$ and $\tau  = 0.1$.

A sample solution is in
[`implicit_heat.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec14/implicit_heat.f90).
You can run the code, save the data in `sol.dat` and plot the graph by
running:

```bash
gfortran implicit_heat.f90 -o a.exe && ./a.exe > sol.dat && gnuplot implicit_heat.plt
```

Here is a sample output. Note that the space and time resolution is the
same, in contrast to the explicit method.

![Solution of the heat equation using the implicit method with $u_0(x) =
\sin \pi x$.](img/implicit_heat.svg)

## Higher order method

So far we have covered only methods that whose error of time
discretization is $O(\tau)$. To improve the accuracy, we can use the
[Crank-Nicolson
method](https://en.wikipedia.org/wiki/Crank%E2%80%93Nicolson_method). It
is the "average" of explicit and implicit methods that we have covered
so far:

$$
\begin{align*}
u_{i+1, k} = u_{i, k} &+ \frac \tau {2h^2} (u_{i + 1, k + 1} - 2 u_{i + 1, k} + u_{i + 1, k - 1})\\
                      &+ \frac \tau {2h^2} (u_{i, k + 1} - 2 u_{i, k} + u_{i,  k - 1})
\end{align*}
$$

This again leads to a system of linear equations to find the solution at
time $t = t_{i+1}$. Again, the solution can be found using the
tridiagonal matrix algorithm.

__Exercise.__ Use the implicit method to solve the heat equation with
initial data $u_0(x) = \sin(\pi x)$, and boundary data $u(0) = u(1) =
0$, on the domain $(0,1)$ using $h = 0.1$ and $\tau  = 0.1$.

Find the order of convergence by taking $h = \tau = 0.1, 0.05, 0.025,
0.0125$. In particular, does the error decrease $4$ times when the step
  sizes $h = \tau$ decrease $2$ times?

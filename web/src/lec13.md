---
title: Lecture 13
---

In today's class we cover some methods to solve linear systems $Ax = b$
and introduce the implicit method for the heat equation.

## Solving linear systems $Ax = b$

Consider the system of $n$ linear equations for $n$ unknowns $x_1,
\ldots, x_n$ of the form

$$
\begin{equation}
\left\{
\begin{aligned}
a_{11} x_1 + a_{12} x_2 + \cdots + a_{1n} &= b_1,\\
a_{21} x_1 + a_{22} x_2 + \cdots + a_{2n} &= b_2,\\
&\vdots\\
a_{n1} x_1 + a_{n2} x_2 + \cdots + a_{nn} &= b_n,
\end{aligned}
\right.
\label{system}
\end{equation}
$$
where $a_{ij}$, $b_i$, $1 \leq i, j \leq n$, are given constants.

If we define the matrix $A$ as

$$
A :=\begin{pmatrix}
a_{11} & a_{12} & \cdots & a_{1n}\\
a_{21} & a_{22} & \cdots & a_{2n}\\
\vdots &\vdots &\ddots & \vdots\\
a_{n1} & a_{n2} x_2 & \cdots & a_{nn}
\end{pmatrix}
$$

and the column vectors

$$
b:= \begin{pmatrix}
b_1\\
b_2\\
\vdots\\
b_n
\end{pmatrix},
\qquad
x:= \begin{pmatrix}
x_1\\
x_2\\
\vdots\\
x_n
\end{pmatrix},
$$
we can write the system $\eqref{system}$ in a compact form
$$
Ax = b.
$$
Here $Ax$ is the matrix product of the $n\times n$-matrix $A$ and the
column vector $x$.

To solve the system $\eqref{system}$, we can use the [Gaussian
elimination](https://en.wikipedia.org/wiki/Gaussian_elimination). In
this method, we write the system as
$$
\left(
\begin{array}{cccc|c}
a_{11} & a_{12} & \cdots & a_{1n} & b_1\\
a_{21} & a_{22} & \cdots & a_{2n} & b_2\\
\vdots &\vdots &\ddots & \vdots & \vdots\\
a_{n1} & a_{n2} & \cdots & a_{nn} & b_n
\end{array}
\right)
$$
repeatedly add some multiple of rows to the rows below to make the
matrix upper-triangular. Thus we start with adding the $-a_{21}/a_{11}$
multiple of the first row to the second row, $-a_{31}/a_{11}$ multiple of
the first row to the third row, etc.

In the end, we should arrive at the form
$$
\left(
\begin{array}{cccc|c}
a_{11} & a_{12} & \cdots & a_{1n} & b_1\\
0 & \tilde a_{22} & \cdots & \tilde a_{2n} & \tilde b_2\\
\vdots &\vdots &\ddots & \vdots & \vdots\\
0 & 0 & \cdots & \tilde a_{nn} & \tilde b_n
\end{array}
\right).
$$
The solution $x_1, \ldots, x_n$ can be found by _backsubstitution_ as
$$
\begin{align*}
x_n &= \tilde b_n/\tilde a_{nn},\\
x_{n-1} &= (\tilde b_{n-1} - \tilde a_{n-1,n} x_n)/\tilde a_{n-1, n-1},\\
&\vdots\\
x_{1} &= (\tilde b_{1} - a_{12} x_2 - \cdots - a_{1,n} x_n)/a_{1, 1}.\\
\end{align*}
$$

Of course, all these computations assume that the diagonal elements are
not zero. If they ever become zero, the method must be modified.

### Gaussian elimination for tridiagonal systems

In general, the Gaussian elimination is computationally very expensive
for large systems of equations. Unfortunately, this is typically the
case for solving partial differential equations numerically. However,
when the linear system has a nice structure, it can be very efficient.
One such case is a tridiagonal system, where the matrix is of the form

$$
\begin{pmatrix}
d_1 & r_1 & & & 0\\
l_2 & d_2 & r_2& &  \\
&l_3 &d_3 & \ddots\\
&& \ddots & \ddots &r_{n-1}\\
0 & && l_n & d_n
\end{pmatrix},
$$
that is, all elements but the ones on the main diagonal and right above
and below it are zero.

The system is then of the form

$$
l_k x_{k -1} + d_k x_k + r_k x_{k+1} = b_k, \qquad 1 \leq k \leq n,
$$
where we set $l_1 = 0$ and $r_n = 0$.

To solve the system, starting with

$$
\left(
\begin{array}{ccccc|c}
d_1 & r_1 & & & 0 & b_1\\
l_2 & d_2 & r_2& &  & b_2 \\
&l_3 &d_3 & \ddots && b_3\\
&& \ddots & \ddots &r_{n-1}&\vdots\\
0 & && l_n & d_n & b_n
\end{array}
\right),
$$

we first multiply the first equation by $1/d_1$ and then add it multiplied by
$-l_2$ to the second equation and we get

$$
\left(
\begin{array}{ccccc|c}
1 & \frac{r_1}{d_1} & & & 0 & \frac{b_1}{d_1}\\
0 & d_2 - \frac{l_2}{d_1} r_1 & r_2& &  & b_2 - \frac{l_2}{d_1} b_1 \\
&l_3 &d_3 & \ddots && b_3\\
&& \ddots & \ddots &r_{n-1}&\vdots\\
0 & && l_n & d_n & b_n
\end{array}
\right).
$$

Then we multiply the second row by add $1 / (d_2 - \frac{l_2}{d_1}
r_1)$, and its $-l_3$ multiple
the third, and so on. This way we eliminate all $l_i$ and
get an upper diagonal matrix, with only $1$ on the diagonal of the form

$$
\left(
\begin{array}{ccccc|c}
1 & \tilde r_1 & & & 0 & \tilde b_1\\
0 & 1 & \tilde r_2& &  & \tilde b_2\\
& 0 &1 & \ddots && \tilde b_3\\
&& \ddots & \ddots &\tilde r_{n-1}&\vdots\\
0 & && 0 & 1 & \tilde b_n
\end{array}
\right).
$$

The coefficients $\tilde r_i$ and $\tilde b_i$ can be computed as

$$
\tilde r_i =
\begin{cases}
\frac{r_1}{d_1}, & i = 1,\\
\frac{r_i}{d_i - l_i \tilde r_{i-1}}, & \text{otherwise},
\end{cases}
\qquad
\tilde b_i =
\begin{cases}
\frac{b_1}{d_1}, & i = 1,\\
\frac{b_i - l_i \tilde b_{i-1}}{d_i - l_i \tilde r_{i-1}}, & \text{otherwise}.
\end{cases}
$$

The solution then can be found as
$$
\begin{align*}
x_n &= \tilde b_n,\\
x_i &= \tilde b_i - \tilde r_i x_{i+1}, \qquad i = n-1, n-2, \ldots, 1.
\end{align*}
$$

__Exercise.__ Use this method to find the solution $x = (x_1, x_2, x_3)$ of the system $Ax =
b$ where

$$
A =
\begin{pmatrix}
-2 & 1 & 0\\
1 & -2 & 1\\
0 & 1 &-2
\end{pmatrix},
\qquad
b =
\begin{pmatrix}
1\\
2\\
3\\
\end{pmatrix}.
$$

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

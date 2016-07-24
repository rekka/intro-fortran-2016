---
title: Lecture 13
---

In today's class we cover some methods to solve linear systems $Ax = b$.

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
0 & \hat a_{22} & \cdots & \hat a_{2n} & \hat b_2\\
\vdots &\vdots &\ddots & \vdots & \vdots\\
0 & 0 & \cdots & \hat a_{nn} & \hat b_n
\end{array}
\right).
$$
The solution $x_1, \ldots, x_n$ can be found by _backsubstitution_ as
$$
\begin{align*}
x_n &= \hat b_n/\hat a_{nn},\\
x_{n-1} &= (\hat b_{n-1} - \hat a_{n-1,n} x_n)/\hat a_{n-1, n-1},\\
&\vdots\\
x_{1} &= (\hat b_{1} - a_{12} x_2 - \cdots - a_{1,n} x_n)/a_{1, 1}.\\
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
1 & \hat r_1 & & & 0 & \hat b_1\\
0 & 1 & \hat r_2& &  & \hat b_2\\
& 0 &1 & \ddots && \hat b_3\\
&& \ddots & \ddots &\hat r_{n-1}&\vdots\\
0 & && 0 & 1 & \hat b_n
\end{array}
\right).
$$

The coefficients $\hat r_i$ and $\hat b_i$ can be computed as

$$
\hat r_i =
\begin{cases}
\frac{r_1}{d_1}, & i = 1,\\
\frac{r_i}{d_i - l_i \hat r_{i-1}}, & \text{otherwise},
\end{cases}
\qquad
\hat b_i =
\begin{cases}
\frac{b_1}{d_1}, & i = 1,\\
\frac{b_i - l_i \hat b_{i-1}}{d_i - l_i \hat r_{i-1}}, & \text{otherwise}.
\end{cases}
$$

The solution then can be found as
$$
\begin{align*}
x_n &= \hat b_n,\\
x_i &= \hat b_i - \hat r_i x_{i+1}, \qquad i = n-1, n-2, \ldots, 1.
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

__Exercise.__ Implement the tridiagonal matrix algorithm in Fortran for systems
with $l_i = l$, $r_i = r$ and $d_i = d$ (constants independent of $i$).

In particular, write a Fortran function

```fortran
function tridiag_solve(l, d, r, b, n)
    implicit none
    integer, intent(in) :: n
    real, intent(in), dimension(n) :: b
    real, intent(in) :: l, d, r
    real, dimension(n) :: tridiag_solve

    ! your code here
end function
```

that accepts the numbers $l$, $d$ and $r$ as parameters and the
right-hand side $b = (b_1, \ldots, b_n)$ as a vector with length $n$, and returns the
solution vector $x = (x_1, \ldots, x_n)$.

Check that this function works by applying it to the problem from the
previous exercise.

A sample code can be found in
[`tridiag.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec13/tridiag.f90).

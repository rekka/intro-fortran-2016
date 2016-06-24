# Lecture 6

We cover the following topics:

1. [Backward Euler method](#backward-euler-method)

### Stability of the Euler method

Now take the file `euler.f90` and modify it to solve the ODE

$$
\left\{
\begin{aligned}
x' &= -100x + 100t + 101, && t > 0,\\
x(0) &= 1
\end{aligned}
\right.
$$

with time step $h = 0.1$.

- What is the exact solution?
- What numerical solution do you get?
- What is the plot of the solution?
- How about with initial data $x(0) = 1.01$ or $x(0) = 0.99$?

Now try to set the time step to $h = 0.01$. Does the solution improve?

_Conclusion:_ If $h$ is chosen too big, the Euler method becomes
**unstable**. See more on
 [wikipedia](https://en.wikipedia.org/wiki/Euler_method#Numerical_stability).
The intuitive reason is that the Euler method easily "overshoots" the
solution. See the following figure for the illustration of this with the
equation $x' = - x, x(0) = 1$.

![Overshooting of the Euler method for $x'(t) = -x, x(0) =
1$.](img/instability_euler.svg)

We need to choose $h$ small enough to satisfy a stability condition: for
the Euler method it is

$$
|1 + h d| < 1
$$

where $d = -100$ in this case.

## Backward Euler method

The **backward** Euler method is derived similarly to [the Euler
method](lec03.html#euler-method),
but we do the Taylor expansion at $t + h$ instead of $t$:

$$
\begin{aligned}
x(t)  &= x(t + h) - h x'(t + h) + O(h^2)\\
      &= x(t + h) - h f(x(t + h), t + h) + O(h^2)
\end{aligned}
$$

Therefore if we neglect the term $O(h^2)$, we can approximate the value
$x(t + h)$ using the value $x(t) + h f(x(t + h), t + h)$. This leads by
iteration to a sequence of values $x_0, x_1, x_2, \ldots$ with $x_0$ being
the initial condition and the we can iteratively compute $x_i$ from

$$
x_i = x_{i - 1} + h f(x_i, i h), \qquad i = 1, \ldots
$$

This is the **backward Euler method**. See more on
[wikipedia](https://en.wikipedia.org/wiki/Backward_Euler_method).
Since $x_i$ is on the right-hand side, we need to solve an
algebraic equation, which makes it more difficult to compute the value
$x_i$ at each time step than in the case of the Euler method. Because of
this, we call this method **implicit**.

The main advantage of this method is that it is **unconditionally
stable**. That is, there is no restriction on how big $h$ we can take,
only the global truncation error. To illustrate this, the following
figure shows how the backward Euler method deals with $x' = -x, x(0) =
1$ that was problematic for the Euler method.

![The backward Euler method does not overshoot the solution of $x' = -x,
x(0) = 1$.](img/implicit_euler.svg)

_Exercise:_ Apply the backward Euler method to the ODE in the previous
section. Since $f(x,t) = - 100 x + 100 t + 101$, we can easily solve the
algebraic equation.

 - Implement the code and find the solution with $h = 0.1$ and initial
   condition $x(0) = 1.01$.
 - What result do you get?
 - What is the order of the method?

## General right-hand side $f(x,t)$

In the case of a general right-hand side $f$, the solution $x_i$ in the
backward Euler method cannot be found analytically. We therefore use
iterative numerical methods, such as [Newton's method](https://en.wikipedia.org/wiki/Newton's_method):

Suppose we want to find a solution $y$ of the equation $g(y) = 0$. Given
a guess $y_0$, we try to improve the solution by finding the
intersection of the tangent line to the graph of $g$ at $(y_0, g(y_0))$
and the $y$ axis. This gives a new $y_1$:

$$
y_1 = y_0 - \frac{g(y_0)}{g'(y_0)}.
$$

Quite often $y_1$ is a much better approximation of the solution than
$y_0$. We can do this iteratively.

_Exercise:_ Implement a backward Euler method with Newton's method for
finding the new value $x_i$ for general $f$. You will need to provide
the derivative $f_x$.

Note that in this case $g(y) = y - h f(y, t_i) - x_{i-1}$.

See
[`backward-newton.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec06/backward-newton.f90)
for a Fortran code using the backward Euler method with Newton's method
to solve the ODE

$$
\left\{
\begin{aligned}
x' &= \sin(x),      && t > 0,\\
x(0) &= 1
\end{aligned}
\right.
$$

with $h = 0.1$ and $N = 100$. The solution should look like:

![](img/lec06-ode-sinx.svg)

[gnuplot]: http://www.gnuplot.info/

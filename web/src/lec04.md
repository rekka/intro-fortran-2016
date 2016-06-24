---
title: Lecture 4
---

In today's lecture we will look at [Runge--Kutta
methods](https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods):

- [midpoint method](#midpoint-method)
- [classical fourth order Runge-Kutta method](#classical-fourth-order-runge-kutta-method)

## Runge-Kutta methods

We consider the ODE

$$
\left\{
\begin{aligned}
x'(t) &= f(x(t), t), && t > 0,\\
x(0) &= x_0.
\end{aligned}
\right.
$$


The Euler method that we covered in the previous lecture has a very slow
convergence: the global truncation error is proportional to $h$, the
time-step. We can improve this significantly by using more function
evaluations of the right-hand side $f(x,t)$ to approximate the value of
the solution $x$ at time $t + h$ from the value at $t$.

This is the idea of Runge-Kutta methods. The extra work that these
function evaluations require is usually worth the improved convergence
rate and smaller error achieved with fewer time steps (larger $h$).

### Midpoint method

Let us set $t_i = ih$.  In the Euler method we use the value of the
right-hand side $f(x,t)$ at $(x_{i-1}, t_{i-1})$ to find the approximate
solution $x_i$. However, the function $f(x(t),t)$ changes with time and
therefore this is not very optimal. Instead, we should try to use the
value of $f(x,t)$ at the middle of the time step $f(x(t_{i-1} + \frac h2),
t_{i-1} + \frac h2)$. Unfortunately, we do not know the value $x(t_{i-1} +
\frac h2)$.
But we can approximate it by using the Euler method for time step of
length $\frac h2$. This gives us $x(t_{i-1} + \frac h2) \sim x_{i-1} + \frac h2
f(x_{i-1}, t_{i-1})$ and we obtain the formula for the **midpoint
method**

$$
x_i = x_{i-1} + h f(x_{i-1} + \frac h2 f(x_{i-1}, t_{i-1}), t_{i-1} +
\frac h2)
$$

See [wikipedia](https://en.wikipedia.org/wiki/Midpoint_method) for more
details.
This is an explicit method of **order 2**.

_Exercise_: Apply the midpoint method to the ODE

$$
\left\{
\begin{aligned}
x' &= x(1+t), && t > 0,\\
x(0) &= 1.
\end{aligned}
\right.
$$

The exact solution is $x(t) = \exp(t (t + 2) / 2)$.

The code is implemented in the file
[`midpoint.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec04/midpoint.f90).

_Exercise:_ Run the code in
[`midpoint.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec04/midpoint.f90) and use gnuplot to plot the
resulting solution. Compare it to the exact solution $\exp(x)$.

_Exercise:_ Use the code in
[`midpoint-error.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec04/midpoint-error.f90) to find the global
truncation error at $t = 1$ for various $h$. Use gnuplot to estimate the
order of the midpoint method. (Recall the logarithmic scale from last
lecture.)

### Classical fourth order Runge-Kutta method

If we perform 4 functional evaluations for each time step, we can
increase the order of the method to 4. This leads to the classical
_fourth order Runge-Kutta method_:

$$
\begin{aligned}
k_1 &= f(x_{i-1}, t),\\
k_2 &= f(x_{i-1} + \frac h2 k_1, t + \frac h2),\\
k_3 &= f(x_{i-1} + \frac h2 k_2, t + \frac h2),\\
k_4 &= f(x_{i-1} + h k_3, t + h),\\
x_i &=   x_{i-1} + \frac h6 (k_1 + 2 k_2 + 2 k_3 + k_4).
\end{aligned}
$$

See more details about this method on
[wikipedia](https://en.wikipedia.org/wiki/Runge%E2%80%93Kutta_methods#The_Runge.E2.80.93Kutta_method).

_Exercise:_ Implement the fourth order Runge-Kutta method to solve the
same ODE as in the case of the midpoint method. Estimate its order using
gnuplot as before.

## Higher accuracy floating point numbers

We have been so far using only _single-precision_ floating point
numbers. Therefore we have not been able to obtain errors smaller than
around 10^-7. To increase the accuracy of floating point computation, we
can use the _double-precision_ floating point numbers by defining the
variables as:

```
to be figured out...
```



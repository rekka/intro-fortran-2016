In today's lecture we will learn how to find a numerical solution of
second order ordinary differential equations.

Find the solution of

```
x''(t) + x(t) = 0, t > 0,
x(0) = 1,
x'(0) = 0
```

The exact solution of this second order differential equation is `x(t) =
cos(t)`.

We can use the already developed methods to solve this ODE by converting
it to a first order system. Let us introduce two functions `x_1` and
`x_2` by setting

```
x_1(t) = x(t),
x_2(t) = x'(t).
```

Note that we then have the following first order system:

```
x_1' = x_2,
x_2' = -x_1,
x_1(0) = 1,
x_2(0) = 0.
```

We will solve this system using the _midpoint method_ (the Runge-Kutta
method of second order).

We first need to learn how to store efficiently multiple values in
fortran like `x_1`, `x_2`.

We declare `x` as an _array_ of dimension 2:

```fortran
real, dimension(2) :: x
```

Then we can access the values in `x` as `x(1)` and `x(2)`.

Fortran also supports array operation. That is, we can efficiently
perform operations on a per-element basis.

```fortran
real, dimension(2) :: x, y, z
z = x + y
```

In this case `z` will be an array with values `z(1) = x(1) + y(1)` and
`z(2) = x(2) + y(2)`.


## 4th order Runge-Kutta method

This time implement the 4th order Runge-Kutta method to solve the second
order differential equation

```
x''(t) + x(t) = 0, t > 0,
x(0) = 1,
x'(0) = 0
```

Use gnuplot to estimate the order of the method.

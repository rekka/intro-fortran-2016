In today's lecture we will learn how to find a numerical solution of
second order ordinary differential equations.

## 2nd order ordinary differential equations

Find the solution of

```
y''(t) + y(t) = 0,           for t > 0,
y(0) = 1,
y'(0) = 0
```

The exact solution of this second order differential equation is `x(t) =
cos(t)`.

We can use the already developed methods to solve this ODE by converting
it to a first order system. Let us introduce two functions `x_1` and
`x_2` by setting

```
x_1(t) = y(t),
x_2(t) = y'(t).
```

Note that we then have the following first order system:

```
x_1' = x_2,
x_2' = -x_1,
x_1(0) = 1,
x_2(0) = 0.
```

We will solve this system using the _midpoint method_ from lecture 4 (the Runge-Kutta
method of second order).

### Arrays in fortran

We first need to learn how to store efficiently multiple values in
fortran like `x_1`, `x_2`.

We declare `x` as an _array_ of dimension 2:

```fortran
real, dimension(2) :: x
```

Then we can access the values in `x` as `x(1)` and `x(2)`.

Fortran also supports array operation. That is, we can efficiently
perform operations on a per-element basis. For example,

```fortran
real, dimension(2) :: x, y, z
! ... initialize x, y
...
z = x + y
```

In this case `z` will be an array with values `z(1) = x(1) + y(1)` and
`z(2) = x(2) + y(2)`.

### Midpoint method for systems

Thanks to Fortran's handling of arrays, we can reuse the code for the
midpoint method from lecture 2 with minimal modifications. The only
important changes are declaration of relevant variables as array of size
2.

We also move the definition of the function `f` into the body of the
program into to the `contains` section. This way we do not have to
declare `f` as `external`:

```fortran
program name
   ...
contains
    real function f(x,t)
        ...
    end function
end program
```

The resulting code is in file `midpoint2.f90`. Run the code and plot the
result in gnuplot. Estimate the error of the method.

## 4th order Runge-Kutta method

This time implement the 4th order Runge-Kutta method to solve the second
order differential equation

```
y''(t) + y(t) = 0,      for  t > 0,
y(0) = 1,
y'(0) = 0
```

Use gnuplot to estimate the order of the method.

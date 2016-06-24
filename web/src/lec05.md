---
title: Lecture 5
---

In today's lecture we will learn how to find a numerical solution of
second order ordinary differential equations.

## 2nd order ordinary differential equations

Find the solution of

$$
\begin{equation}
\left\{
\begin{aligned}
y''(t) + y(t) &= 0, && t > 0,\\
y(0) &= 1,\\
y'(0) &= 0.
\end{aligned}
\right.
\label{ode}
\end{equation}
$$


The exact solution of this second order differential equation is $y(t) =
\cos(t)$.

We can use the already developed methods to solve this ODE by converting
it to a first order system. Let us introduce two functions $x_1$ and
$x_2$ by setting

$$
\begin{aligned}
x_1(t) &= y(t),\\
x_2(t) &= y'(t).
\end{aligned}
$$

Note that we then have the following first order system:

$$
\left\{
\begin{aligned}
x_1' &= x_2, && t > 0,\\
x_2' &= -x_1, && t > 0,\\
x_1(0) &= 1,\\
x_2(0) &= 0.
\end{aligned}
\right.
$$


We will solve this system using the _midpoint method_ from lecture 4 (the Runge-Kutta
method of second order).

### Arrays in Fortran

We first need to learn how to store efficiently multiple values in
Fortran like $x_1$, $x_2$.

We declare `x` as an _array_ of dimension 2:

```fortran
real, dimension(2) :: x
```

Then we can access the values in `x` as `x(1)` and `x(2)`.
Arrays can be initialized as

```fortran
x(1) = 1.
x(2) = 0.
```

or using the shorthand notation

```fortran
x = (/ 1., 0. /)
```

Fortran also supports _array operations_. That is, we can efficiently
perform operations on a per-element basis. For example,

```fortran
real, dimension(2) :: x, y, z
x = (/ 0., 1. /)
y = (/ 3., 5. /)
z = x + y
write(*,*) z
```

In this case `z` will be an array with values `z(1) = x(1) + y(1)` and
`z(2) = x(2) + y(2)`, so the printed result is `3.  6.`.

To declare a function that returns an array, we need to move the type
declaration into the body to be able to specify the dimension:

```fortran
function f(x, t)
    implicit none
    real, intent(in), dimension(2) :: x
    real, intent(in) :: t
    real, dimension(2) :: f

    f(1) = x(2)
    f(2) = - x(1)
end function
```


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
    function f(x,t)
        ...
    end function
end program
```

The resulting code is in file
[`midpoint.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec05/midpoint.f90). Run the code and plot the
result in gnuplot. However, now for each time $t$ we have values $x_1(t)$
and $x_2(t)$:

Running the code

```
$ gfortran midpoint.f90 -o a.exe && ./a.exe
```

yields the output

```
  0.00000000       1.00000000       0.00000000
  0.100000001      0.995000005     -0.100000001
  0.200000003      0.980024993     -0.199000001
  0.300000012      0.955224872     -0.296007514
  0.400000006      0.920848012     -0.390049964
  0.500000000      0.877238750     -0.480184525
  0.600000024      0.824834108     -0.565507472
  0.699999988      0.764159203     -0.645163357
  0.800000012      0.695822060     -0.718353450
  0.900000036      0.620507598     -0.784343898
  ...
```

To plot the graphs of both functions $x_1$ and $x_2$ in gnuplot into one graph, we specify
which data to plot by adding `using 1:2` to the `plot` command to plot
1^st^ vs. 2^nd^ column, and `using 1:3` to plot 1^st^ vs. 3^rd^ column:

```bash
$ gfortran midpoint.f90 -o a.exe
$ ./a.exe > sol.dat
```

and in gnuplot

```gnuplot
plot 'sol.dat' using 1:2, 'sol.dat' using 1:3
```

![Sample output](img/lec05-x1-x2.svg)

_Exercise:_ Estimate the error of the method.

## 4th order Runge-Kutta method

This time implement the 4th order Runge-Kutta method to solve the second
order differential equation $\eqref{ode}$.

Use gnuplot to estimate the order of the method.

### Numerical precision

By default, variables declared as `real` are _single precision_
floating point numbers. Single precision stores only about 7 decimal places.
To increase the precision, we can request _double precision_ floating
point numbers by declaring the variables as `real(8)`. Here 8 is the
number of bytes used to store the number, which implies double
precision since double precision variables can store about 15 decimal
places. Single precision uses 4 bytes, and is therefore more memory
efficient.

Fortran functions like `cos`, `exp` and `abs` work with single precision
numbers. The double precision equivalents are `dcos`, `dexp`, `dabs`,
etc.

Constants like `1.` are single precision by default. To under double
precision constants, we can use the scientific notation `1.0d0` or `1d0`
for short.

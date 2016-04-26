# Lecture 3

We cover the following topics:

1. Fortran `function`
1. explicit Euler method
1. plotting with gnuplot using scripts
1. implicit Euler method

## Fortran `function`

In Fortran it is possible to define a `function`, a piece of code that
produces a value depending on the inputs. It is analogous to a function
in mathematics. For instance, if we want to define a function `f(x, t) =
sin(x - t)`, we would use the following code:

```fortran
real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = sin(x - t)
end function
```

Explanation of the above code:

- `real function f(x, t)` defines a function `f` with two arguments `x`
  and `t`, which returns a `real` value.
- `intent(in)` indicated that `x` and `t` are input arguments that will
  not be modified inside the function.
- `f = sin(x - t)` assigns the value of `sin(x - t)` to `f`, and this
  value is then the result of the function.

You can then use this function in your code as any other Fortran
function:

```fortran
program fnc
    implicit none
    real :: x, y
    real, external :: f
    x = 0.1
    y = f(x, 0.5)

    write(*,*)y
end program
```

- `external` indicates that `f` is a function, not a variable.
- `f(x, 0.5)` evaluates function with arguments `x` and `0.5`.

See the file `function.f90` for the complete code.


## Explicit Euler method

Suppose that we want to solve an ordinary differential equation

```
x'(t) = f(x(t), t),
x(0) = x_0.
```

Knowing the value of the solution of `x` at time `t`, we might want to
find the solution at `t + h` for some `h > 0`.


We use the Taylor series

```
x(t + h) = x(t) + h x'(t) + o(h) = x(t) + h f(x(t), t) + o(h).
```

Here `o(h)` is the _discretization error_, and we indicate that it is
asymptotically smaller than than `h`.

If we neglect `o(h)` then we can approximate `x(t + h)` by `x(t) + h
f(x(t), t)`. Doing this iteratively, we get a sequence `x_0, x_1, x_2, ...`
such that `x_0` is the initial condition, and then to get `x_{i+1}` from
`x_i` we use the relation

```
x_{i+1} = x_i + h f(x_i, i h).
```

This is the ___explicit Euler method___ for solving an ordinary differential
equation.

This simple relation can be expressed in Fortran using the `do` loop and
one variable `x` that represents the value `x_i` and is iteratively
updated.

The Fortran code is in the file `explicit-euler.f90`. In that code we use the right-hand side
`f(x, t) = x` and initial data `x(0) = 1.`.

### Error of the explicit Euler method

The value `x_i` is an approximation of `x(i h)`, the exact solution.
Since we neglected the higher order terms `o(h)` in the Taylor
expansion, in general `x_i` differs from `x(i h)`. This difference is
called the error of the numerical method. However, we expect
that when we take `h` smaller, the error will decrease. It is important
to estimate how exactly the error depends on the choice of `h`.

To find this estimate, we shall apply the explicit Euler method with
various `h` and compare the result with the value of the exact solution.
We again consider `f(x, t) = x` with initial data `x(0) = 1.` since we
know the exact solution `x(t) = exp(t)`.

We take a sequence `N = 1, 2, 4, 8, ..., 2^10 = 1024` and set `h = 1. /
N`.  Using the Euler method, we find `x_N` which approximates the value
`x(N h) = x(1.) = exp(1.) = e`.

We can implement this in Fortran using two nested `do` loops: the outer
one iterates over the values of `N` and the inner one is the explicit
Euler method.

The full code is in the file `explicit-euler-error.f90`. When running
this, the code prints out the table of values of `h` and the error `|x_N - x(N
h)|`.

Save the output in a file `error.dat` by redirecting the output to a
file:

```bash
$ gfortran explicit-euler-error.f90 -o a.exe
$ ./a.exe > error.dat
```

### Plotting the errors in gnuplot

Open gnuplot and run the following command.

```gnuplot
plot 'error.dat'
```

However, this plot is not very good since the scale of the values varies
so much. It is difficult to see what is happening for small values of
`h`. We therefore use a _logarithmic scale_. This way we can represent
vastly different scales of our variables. This can be done in gnuplot
using

```gnuplot
set logscale xy
plot 'error.dat'
```

Now the points are distributed uniformly, but the labels on the axes
indicate a logarithmic scale.

To find the order of the method, we need to find `k` such that the error
behaves like `h^k`. To do this, we plot the functions `x`, `x^2` and
`x^3` together with the data points. We now need to set the range of the
plot.


```gnuplot
set logscale xy
set xrange [0.001:1.]
plot 'error.dat', x, x**2, x**3
```

From this plot we should see that the error points form a line parallel
to the graph of `x`. Therefore we observe that the explicit Euler
method is of order **1**.

We can add labels to make a nicer picture:
```gnuplot
set title "Error of the explicit Euler method"
set xlabel "h"
set ylabel "err"
set logscale xy
set xrange [0.001:1.]
plot 'error.dat', x, x**2, x**3
```

To not have to repeat the above commands all the time, we can save them
in a file, for instance `error.plt`. Then we can run all of them at once
by using

```bash
gnuplot error.plt
```



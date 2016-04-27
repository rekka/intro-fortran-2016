# Lecture 3

We cover the following topics:

1. [Fortran `function`](#fortran-function)
1. [Euler method](#euler-method)
1. [plotting with gnuplot using scripts]
1. [Backward Euler method](#backward-euler-method)

## Fortran `function`

In Fortran it is possible to define a
[`function`](https://en.wikibooks.org/wiki/Fortran/Fortran_procedures_and_functions#Function),
a piece of code that produces a value depending on the inputs. It is
analogous to a function
in mathematics.

For instance, if we want to define a function `f(x, t) =
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


## Euler method

Suppose that we want to solve an ordinary differential equation

```
x'(t) = f(x(t), t),
x(0) = x_0.
```

Knowing the value of the solution of `x` at time `t`, we want to
find the solution at `t + h` for some `h > 0`.


We use the Taylor series

```
x(t + h) = x(t) + h x'(t) + O(h^2) = x(t) + h f(x(t), t) + O(h^2).
```

Here `O(h^2)` is the _discretization error_, and we indicate that it is
proportional to `h^2` for small `h`.

If we neglect `O(h^2)` then we can approximate `x(t + h)` by `x(t) + h
f(x(t), t)`. Doing this iteratively, we get a sequence `x_0, x_1, x_2, ...`
such that `x_0` is the initial condition, and then to obtain `x_i` from
`x_{i - 1}` we use the relation

```
x_i = x_{i - 1} + h f(x_{i - 1}, (i - 1) h).
```

Such `x_i` is a numerical approximation of the exact solution `x` at
time `t = ih`.
This is the ___Euler method___ for solving an ordinary differential
equation. See the [wikipedia article](https://en.wikipedia.org/wiki/Euler_method) for more
information.

This simple relation can be expressed in Fortran using the `do` loop and
one variable `x` that represents the value `x_i` as it is iteratively
updated.

The Fortran code is in the file `euler.f90`. In that code we use the right-hand side
`f(x, t) = x` and initial data `x(0) = 1.`, the time step `h = 0.1` and
find the numerical solution for
`N = 10` time steps.

### Error of the Euler method

The value `x_i` is an approximation of `x(i h)`, the exact solution.
Since we neglected the higher order terms `O(h^2)` in the Taylor
expansion, in general `x_i` differs from `x(i h)`. At a fixed time `t`,
this difference is called the [global truncation error](https://en.wikipedia.org/wiki/Euler_method#Global_truncation_error)
of the numerical method. However, we expect that when we take `h`
smaller, the error will decrease. It is important to estimate how
exactly the error depends on the choice of `h`.

To find this estimate, we shall apply the Euler method with
various `h` and compare the result with the value of the exact solution.
We again consider `f(x, t) = x` with initial data `x(0) = 1.` since we
know the exact solution `x(t) = exp(t)`.

We take a sequence `N = 1, 2, 4, 8, ..., 2^10 = 1024` and set `h = 1. /
N`.  Using the Euler method, we find `x_N` which approximates the value
`x(N h) = x(1.) = exp(1.) = e`.

We can implement this in Fortran using two nested `do` loops: the outer
one iterates over the values of `N` and the inner one is the
Euler method.

The full code is in the file `euler-error.f90`. When running
this, the code prints out the table of values of `h` and the error `|x_N - x(N
h)|` which is the global truncation error at time `t = 1`.

Save the output in a file `error.dat` by redirecting the output to a
file:

```bash
$ gfortran euler-error.f90 -o a.exe
$ ./a.exe > error.dat
```

### Plotting the errors in gnuplot

Open gnuplot and run the following command.

```gnuplot
plot 'error.dat'
```

This is the graph of the dependence of the error of the method on `h`.
However, this plot is not very useful since the scale of the values varies
so much. It is difficult to see what is happening for small values of
`h`, and those are the interesting values. We therefore use the
_logarithmic scale_ instead. This way we can represent vastly different scales
of our variables. This can be done in gnuplot using

```gnuplot
set logscale xy
plot 'error.dat'
```

Now the points are distributed uniformly, but the labels on the axes
indicate a logarithmic scale.

To find the order of the method, we need to find `k` such that the error
behaves like `h^k`. To do this, we plot the functions `x`, `x^2` and
`x^3` together with the data points.

```gnuplot
set logscale xy
plot 'error.dat', x, x**2, x**3
```

From this plot we should see that the error points form a line parallel
to the graph of `x`. Therefore we deduce that the Euler
method is of **order 1**, that is, the error at a given time is
proportional to `h`. (This is not very good, by the way. We will later
see how to improve this significantly.)

We can add labels to make a nicer picture:
```gnuplot
set title "Error of the Euler method"
set xlabel "h"
set ylabel "err"
set key right bottom
set logscale xy
plot 'error.dat', x, x**2, x**3
```

To not have to repeat the above commands every time, we can save them
in a file, for instance `error.plt`. In the script, you can use `#` for
comments. See the `error.plt` file for the explanation of each line.
Then we can run all of them at once
by using

```bash
$ gnuplot error.plt
```

### Stability of the Euler method

Now take the file `euler.f90` and modify it to solve the ODE

```
x' = -100x + 100t + 101
x(0) = 1
```

with time step `h = 0.1`.

- What is the exact solution?
- What numerical solution do you get?
- What is the plot of the solution?
- How about with initial data `x(0) = 1.01` or `x(0) = 0.99`?

Now try to set the time step to `h = 0.01`. Does the solution improve?

_Conclusion:_ If `h` is chosen too big, the Euler method becomes
**unstable**. See more on
 [wikipedia](https://en.wikipedia.org/wiki/Euler_method#Numerical_stability).

We need to choose `h` small enough to satisfy a stability condition: for
the Euler method it is

```
|1 + h d| < 1
```

where `d = -100` in this case.

## Backward Euler method

The **backward** Euler method is derived similarly to [the Euler method],
but we do the Taylor expansion at `t + h` instead of `t`:

```
x(t)  = x(t + h) - h x'(t + h) + O(h^2)
      = x(t + h) - h f(x(t + h), t + h) + O(h^2)
```

Therefore if we neglect the term `O(h^2)`, we can approximate the value
`x(t + h)` using the value `x(t) + h f(x(t + h), t + h)`. This leads by
iteration to a sequence of values `x_0, x_1, x_2, ...` with `x_0` being
the initial condition and the we can iteratively compute `x_i` from

```
x_i = x_{i - 1} + h f(x_i, i h)
```

This is the **backward Euler method**. See more on
[wikipedia](https://en.wikipedia.org/wiki/Backward_Euler_method).
Since `x_i` is on the right-hand side, we need to solve an
algebraic equation, which makes it more difficult to compute the value
`x_i` at each time step than in the case of the Euler method. Because of
this, we call this method **implicit**.

The main advantage of this method is that it is **unconditionally
stable**. That is, there is no restriction on how big `h` we can take,
only the global truncation error.

_Exercise:_ Apply the backward Euler method to the ODE in the previous
section. Since `f(x,t) = - 100 x + 100 t + 101`, we can easily solve the
algebraic equation.

 - Implement the code and find the solution with `h =
0.1` and initial condition `x(0) = 1.01`.
 - What result do you get?
 - What is the order of the method?


[gnuplot]: http://www.gnuplot.info/

# Lecture 3

We cover the following topics:

- Fortran `function`
- explicit Euler method
- implicit Euler method
- plotting with gnuplot using scripts

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
program main
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

See `function.f90` for the complete code.


## Explicit Euler method

Suppose that we want to solve an ordinary differential equation

```
x'(t) = f(x(t), t),
x(t0) = x0.
```

Knowing the value of the solution of `x` at time `t`, we might want to
find the solution at `t + h` for some `h > 0`.

We have covered 3 examples in the 2nd lecture.

## `basic.f90`

This is a basic example of a Fortran program, showing the program
structure:

- Opening and closing statements:

    ```fortran
    program name
    implicit none
    ...
    end program
    ```

- Code comments:

    ```fortran
    ! comment
    ```

    The text following `!` is ignored by the compiler. Use it to write
    comments and notes in your code.

- Declaration of variables:

    ```fortran
    real :: x
    ```

    This declares a `real` variable `x`: a single-precision floating point number.

- The assignment operator `=`:

    ```fortran
    x = 1.
    ```

- Output to the console (standard output):

    ```fortran
    write (*,*) 'Hello: ',x
    ```
## `sum.f90`

This code illustrates how to evaluate the [Leibniz formula for
π](https://en.wikipedia.org/wiki/Leibniz_formula_for_%CF%80).

It illustrates the following Fortran features:

- `do` statement:

    ```formula
    do i=1,N
    ...
    end do
    ```

    The `do` statement executes the code `...` with variable `i` taking
    on the values `1`, `2`, `3`, ..., `N - 1`, `N`.

- `if` statement:

    ```formula
    if (condition) then
        ! true
    else
        ! false
    end if
    ```

    The `if` statement evaluates the expression `condition`, and decides
    which code to execute depending on the result. If `condition`
    evaluates to `true`, then the first code block is executed,
    otherwise the second code block executes.

    Condition can be expressions like

     - `x > 3.`
     - `i == 2`

    Note that equality is checked by `==`, not by `=`!

- Function `mod(i, 2)` that computes the remainder of `i` after division
  by `2`. We use this to test if `i` is an odd integer or an even integer.

- Integer vs. floating point division:

    Note that `1 / 2` evaluates to `0` since this is calculated as an
    integer division.

    You can force floating point division by writing the constants with
    a decimal point, `1. / 2. = 0.5`.

    This is easy to miss.

## `integral.f90`

This code illustrates how to approximate a definite integral using the
[trapezoidal rule](https://en.wikipedia.org/wiki/Trapezoidal_rule). We
are computing the integral of `sin(x)` over the interval `[0, π]` using
the trapezoidal rule over `N = 32` subintervals.

- `sin`, `atan` are Fortran's builtin function that compute sin and
  arctan for floating point values.

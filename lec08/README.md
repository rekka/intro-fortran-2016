In lecture 8 we will start to learn about numerical methods for
_partial differential equations_. We will need to use the _array_ data
structure in Fortran to store the values of the solution at different
points in space.

## Arrays in Fortran

The variables in Fortran that we have see so far store exactly 1 value.
To store multiple values in one variable, we can use arrays. An array is
a data structure that stores a given number of _indexed_ values of the same type.
See also [Lecture 5, Arrays in Fortran](https://github.com/rekka/intro-fortran-2016/tree/master/lec05#arrays-in-fortran).

To declare an array of `N` elements in Fortran, where `N` is a positive
integer, we use the statement `dimension(N)` when declaring a variable.
For example, to introduce an array `x` of `5` real values, we declare
`x` as

```fortran
real, dimension(5) :: x
```

The variable `x` now stores 5 values denoted as: `x(1)`, `x(2)`, ..., `x(5)`.

___Note___: Trying to access other elements, such as `x(0)`, `x(6)` is
an error. Fortran might not complain, but accessing these values will
likely crash your program and/or will give incorrect results.

To initialize an array, we can use the notation

```fortran
x = (/ 1., 2., 3., 4., 5. /)
```

This is equivalent to

```fortran
do i=1,5
    x(i) = i
end do
```

Printing all values of the array on one line, separated by spaces, is as
simple as

```fortran
write(*,*) x
```

The _size_ of the array is the number of its elements. You can use the
function `size` to find it in your code:

```fortran
write(*,*) size(x)
```

See file
[`array.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec08/array.f90) for some examples of working with arrays.

_Example:_ Suppose that we want to compute the sum of array `x`: `x(1) +
x(2) + ... + x(5)`. We can
use the `do` loop:

```fortran
real :: s

s = 0.
do i=1,size(x)
    s = s + x(i)
end do
write(*,*) s
```

_Exercise:_ Suppose that `x` is an array with 5 elements `1., 2., ...,
5.`.  Compute the following using the `do` loop:

- average
- product `x(1) * x(2) * ... * x(5)`
- maximum value
- minimum value
- `l²`-norm of `x`: `|x| = (x(1)² + x(2)² + ... + x(N)²)^(1/2)`.
- second larges value

A sample answer is in
[`arrayops.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec08/arrayops.f90).

_Exercise:_ Sort the array `x` of 5 elements `sin(1), sin(2), ...,
sin(5)`.

A sample answer is in
[`sort.f90`](https://github.com/rekka/intro-fortran-2016/blob/master/lec08/sort.f90).


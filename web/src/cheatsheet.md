---
title: Fortran cheatsheet
---

## Basics

### Compiling

To run program, it must be compiled first. For example, save the
following in `helloworld.f90`:

```gfortran
program helloworld
    write(*,*)'Hello, world!'
end program
```

Then compile it and run it:

```bash
$ gfortran helloworld.f90 -o a.exe
$ ./a.exe
Hello, world!
```

Or on one line:

```bash
$ gfortran helloworld.f90 -o a.exe && ./a.exe
Hello, world!
```

### Comments

```gfortran
! comment
```

## Program structure

```gfortran
program name                    ! `name` can be any name
    implicit none               ! no implicit variables (this is better)
    integer :: i                ! variable declarations
    ! your code here
contains                        ! this section is optional
    ! function definitions here
end program
```

## Variables

```gfortran
integer :: i                    ! integer
real :: x                       ! real number
real, dimension(5) :: y         ! array of 5 real numbers

i = 1                           ! assignment
x = 2.
y = (/ 1., 2., 3., 4., 5. /)
```

## `do` loop

```gfortran
integer :: i
real, dimension(5) :: y         ! array of 5 real numbers

do i=1,5
    y(i) = 2 * i                ! perform this code for i taking values
                                ! 1, 2, 3, 4, 5
end do

## `if` condition

```gfortran
if (2 > 1) ` then
    write(*,*)'2 is bigger than 1!'
else

```

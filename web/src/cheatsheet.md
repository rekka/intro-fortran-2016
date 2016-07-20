---
title: Fortran cheatsheet
---

## Basics

### Compiling

To run program, it must be compiled first. For example, save the
following in `helloworld.f90`:

```fortran
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

```fortran
! comment
```

## Program structure

```fortran
program name                    ! `name` can be any name
    implicit none               ! no implicit variables (this is better)
    integer :: i                ! variable declarations
    ! your code here
contains                        ! this section is optional
    ! function definitions here
end program
```

## Variables

```fortran
integer :: i                    ! integer
real :: x                       ! real number
real, dimension(5) :: y         ! array of 5 real numbers

i = 1                           ! assignment
x = 2.
y = (/ 1., 2., 3., 4., 5. /)
```

## `do` loop

```fortran
integer :: i
real, dimension(5) :: y         ! array of 5 real numbers

do i=1,5
    y(i) = 2 * i                ! perform this code for i taking values
                                ! 1, 2, 3, 4, 5
end do
```

## `if` condition

```fortran
if (2 > 1) then                         ! (2 > 1) is any condition
    write(*,*)'2 is bigger than 1!'     ! executed if condition is true
else
    write(*,*)'Math is wrong!'          ! executed if condition is false
end if
```

- `==` equal
- `/=` not equal
- `<=`, `>=` less than or equal, greater than or equal
- `<`, `>` less than, greater than

The `else` part can be omitted:

```fortran
if (2 * 2 /= 4) then
    write(*,*)'Math is wrong!'
end if
```

program main
    implicit none
    real :: x, y
    real, external :: f
    x = 0.1
    y = f(x, 0.5)

    write(*,*)y
end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = sin(x - t)
end function

program explicit_euler
    implicit none
    integer :: i, N
    real :: x, h
    real, external :: f
    h = 1.
    x = 1.
    N = 10. / h

    do i=1,N
        x = x + h * f(x, i * h)
        write(*,*)x
    end do
end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = x
end function

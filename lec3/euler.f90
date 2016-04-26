program explicit_euler
    implicit none
    integer :: i, N
    real :: x, h
    real, external :: f

    h = 0.1
    N = 1. / h

    ! Euler method
    x = 1.
    do i=1,N
        x = x + h * f(x, i * h)
        write(*,*)i * h, x
    end do

end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = x
end function

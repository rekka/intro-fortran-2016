program euler_stability
    implicit none
    integer :: i, N
    real :: x, h
    real, external :: f

    h = 0.1
    N = 1. / h

    ! Euler method
    x = 1.01
    write(*,*)0., x
    do i=1,N
        x = x + h * f(x, (i - 1) * h)
        write(*,*)i * h, x
    end do

end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = -100. * x + 100. * t + 101.
end function

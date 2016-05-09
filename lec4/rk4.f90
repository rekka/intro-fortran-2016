program rk4
    implicit none
    integer :: i, N
    real :: x, t, h, k1, k2, k3, k4
    real, external :: f

    h = 1. / 1
    N = 1. / h

    ! Runge-Kutta 4th order method
    x = 1.
    write(*,*)0., x
    do i=1,N
        t = (i - 1) * h
        k1 = f(x, t)
        k2 = f(x + h / 2. * k1, t + h / 2.)
        k3 = f(x + h / 2. * k2, t + h / 2.)
        k4 = f(x + h * k3, t + h)
        x = x + h /6. * (k1 + 2. * k2 + 2. * k3 + k4)
        write(*,*)i * h, x
    end do

end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = x * (1 + t)
end function

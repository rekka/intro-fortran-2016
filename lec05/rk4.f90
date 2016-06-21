program rk4
    implicit none
    integer :: i, N
    real :: t, h
    real, dimension(2) :: x, k1, k2, k3, k4

    h = 1. / 1
    N = 1. / h

    ! Runge-Kutta 4th order method
    x = (/ 1., 0. /)
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

contains

    function f(x, t)
        implicit none
        real, intent(in), dimension(2) :: x
        real, intent(in) :: t
        real, dimension(2) :: f

        f(1) = x(2)
        f(2) = - x(1)
    end function
end program


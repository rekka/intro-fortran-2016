program rk4_error
    implicit none
    integer :: i, N, k
    real(8) :: t, h
    real(8), dimension(2) :: x, k1, k2, k3, k4

    do k=0,10
        N = 2**k
        h = 1. / N

        ! Runge-Kutta 4th order method
        x = (/ 1., 0. /)
        do i=1,N
            t = (i - 1) * h
            k1 = f(x, t)
            k2 = f(x + h / 2. * k1, t + h / 2.)
            k3 = f(x + h / 2. * k2, t + h / 2.)
            k4 = f(x + h * k3, t + h)
            x = x + h /6. * (k1 + 2. * k2 + 2. * k3 + k4)
        end do
        write(*,*)h,abs(x - dcos(1d0))
    end do

contains

    function f(x, t)
        implicit none
        real(8), intent(in), dimension(2) :: x
        real(8), intent(in) :: t
        real(8), dimension(2) :: f

        f(1) = x(2)
        f(2) = - x(1)
    end function
end program


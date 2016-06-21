program rk4_error
    implicit none
    integer :: i, N, k
    real :: x, t, h, k1, k2, k3, k4
    real, external :: f

    do k=0,10 
        N = 2**k
        h = 1. / N

        x = 1.
        do i=1,N
            t = (i - 1) * h
            k1 = f(x, t)
            k2 = f(x + h / 2. * k1, t + h / 2.)
            k3 = f(x + h / 2. * k2, t + h / 2.)
            k4 = f(x + h * k3, t + h)
            x = x + h /6. * (k1 + 2. * k2 + 2. * k3 + k4)
        end do
        write(*,*)h,abs(x - exp(1. * (1. + 2) / 2))
    end do
end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = x * (1 + t)
end function

program midpoint_error
    implicit none
    integer :: i, N, k
    real :: x, t, h, k1
    real, external :: f

    do k=0,10 
        N = 2**k
        h = 1. / N

        x = 1.
        do i=1,N
            t = (i - 1) * h
            k1 = f(x, t)
            x = x + h * f(x + k1 * h / 2, t + h / 2)
        end do
        write(*,*)h,abs(x - exp(1. * (1. + 2.) / 2))
    end do
end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = x * (1 + t)
end function

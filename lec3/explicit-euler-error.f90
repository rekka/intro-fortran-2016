program explicit_euler
    implicit none
    integer :: i, N, k
    real :: x, h
    real, external :: f

    do k=0,10 
        N = 2**k
        h = 1. / N

        x = 1.
        do i=1,N
            x = x + h * f(x, i * h)
        end do
        write(*,*)h,abs(x - exp(1.))
    end do
end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = x
end function

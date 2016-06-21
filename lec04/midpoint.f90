program midpoint
    implicit none
    integer :: i, N
    real :: x, t, h, k1
    real, external :: f

    h = 1.
    N = 1. / h

    ! Midpoint method
    x = 1.
    write(*,*)0., x
    do i=1,N
        t = (i - 1) * h
        k1 = f(x, t)
        x = x + h * f(x + k1 * h / 2, t + h / 2)
        write(*,*)i * h, x
    end do

end program

real function f(x, t)
    implicit none
    real, intent(in) :: x, t

    f = x * (1 + t)
end function

program short_test
    implicit none
    integer :: i, N, k
    real :: x, h, y

    h = 0.1
    N = 10. / h

    ! method for the ODE x'(t) = f(x,t) = sin(x) + sin(t)
    x = 1
    write(*,*)0., x
    do i=1,N
        ! Use 5 iterations of Newton's method to find x_i
        ! for method
        ! x_i = x_{i-1} + h/2 * f(x_i, t_i) + h/2 * f(x_{i-1}, t_{i-1})
        y = x ! y = x_{i-1}
        do k = 1,5
            x = x - (x - 0.5 * h * f(x, i * h) - y - 0.5 * h * f(y, (i - 1) * h)) / (1. - 0.5 * h * df(x, i * h))
        end do
        write(*,*)i * h, x
    end do

contains
    function f(x,t)
        implicit none
        real, intent(in) :: x, t
        real :: f
        f = sin(x) + sin(t)
    end function

    ! the partial derivative of f with respect to x
    function df(x,t)
        implicit none
        real, intent(in) :: x, t
        real :: df
        df = cos(x)
    end function
end program

program backward_newton
    implicit none
    integer :: i, N, k
    real :: x, h, y

    h = 0.1
    N = 10. / h

    ! backward Euler method for the ODE x'(t) = f(x,t) = sin(x)
    x = 1
    write(*,*)0., x
    do i=1,N
        ! Use 5 iterations of Newton's method to find the solution x_i of
        ! x_i = x_{i-1} + h f(x_i, t_i)
        y = x ! y = x_{i-1}
        do k = 1,5
            x = x - (x - h * f(x, i * h) - y) / (1. - h * df(x, i * h))
        end do
        write(*,*)i * h, x
    end do

contains
    function f(x,t)
        implicit none
        real, intent(in) :: x, t
        real :: f
        f = sin(x)
    end function

    ! the partial derivative of f with respect to x
    function df(x,t)
        implicit none
        real, intent(in) :: x, t
        real :: df
        df = cos(x)
    end function
end program

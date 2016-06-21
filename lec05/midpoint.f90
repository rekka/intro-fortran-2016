program midpoint
    implicit none
    integer :: i, N
    real :: t, h, pi = 4. * atan(1.)
    real, dimension(2) :: x, k1

    h = 0.1
    N = 2. * pi / h

    ! Midpoint method
    x(1) = 1.
    x(2) = 0.
    write(*,*)0., x
    do i=1,N
        t = (i - 1) * h
        k1 = f(x, t)
        x = x + h * f(x + k1 * h / 2, t + h / 2)
        write(*,*)i * h, x
    end do

contains

    function f(x, t)
        implicit none
        real, intent(in) :: t
        real, dimension(2), intent(in) :: x
        real, dimension(2) :: f

        f(1) = x(2) 
        f(2) = -x(1) 
    end function
end program


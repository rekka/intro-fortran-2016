program heat
    implicit none
    ! introduce a constants M and pi
    integer, parameter :: M = 10
    real, parameter :: pi = 4. * atan(1.)
    integer :: i, k, N
    real :: h, tau,  x
    real, dimension(M + 1) :: u, v

    h = 1. / M
    tau = h * h / 2.
    N = 1. / tau

    ! initialize the initial data and print the values
    do k=1,M + 1
        x = (k - 1) * h
        u(k) = sin(pi * x)
        write(*,*)0., x, u(k)
    end do
    ! print empty line
    write(*,*)

    do i=1,N

        ! one step of explicit finite difference method
        do k = 2,M
            v(k) = u(k) + (tau / (h * h)) * (u(k - 1) - 2 * u(k) + u(k + 1))
        end do

        ! can be also written as
        ! v(2:M) = u(2:M) + (tau / (h * h)) * (u(1:M-1) - 2 * u(2:M) + u(3:M+1))

        ! print solution values
        do k = 1, M + 1
            write(*,*)i * tau, (k - 1) * h, v(k)
        end do
        ! print empty line
        write(*,*)

        u = v
    end do

end program

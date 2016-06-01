program heat
    implicit none
    integer, parameter :: M = 10
    integer :: i, k, N
    real :: h, tau, pi = 4. * atan(1.)
    real, dimension(M + 1) :: u, v

    h = 1. / M
    tau = h * h / 2.
    N = 1. / tau

    ! u_0
    do k=1,M + 1
        u(k) = sin((k - 1) * h * pi)
        write(*,*)0., (k - 1) * h, u(k)
    end do
    write(*,*)

    do i=1,N
        write(*,*)i * tau, 0 * h, v(1)
        do k = 2,M
            v(k) = u(k) + (tau / (h * h)) * (u(k - 1) - 2 * u(k) + u(k + 1))
            write(*,*)i * tau, (k - 1) * h, v(k)
        end do
        write(*,*)i * tau, M * h, v(M + 1)
        write(*,*)
        u = v
    end do

end program

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
    do k=0,M 
        u(k) = sin(k * h * pi)
    end do

    write(*,*)0., u
    do i=1,N
        do k = 1,M-1
            v(k) = u(k) + (tau / (h * h)) * (u(k - 1) - 2 * u(k) + u(k + 1))
        end do
        u = v
        write(*,*)i * tau, u
    end do

end program

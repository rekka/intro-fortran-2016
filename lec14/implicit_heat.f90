program implict_heat
    implicit none
    integer :: i, k
    integer, parameter :: M = 10
    real, dimension(M - 1) :: u, b
    real :: h, c, tau, pi = 4. * atan(1.), x, t
    real :: a0, a1

    a0 = 0.
    a1 = 0.
    h = 1. / M
    tau = h

    c = tau / (h * h)

    ! initialize
    do k = 1, M - 1
        x = k * h
        u(k) = sin(pi * x)
    end do

    ! print
    write(*,*)0., 0., a0
    do k = 1, M - 1
        write(*,*)i * tau, k * h, u(k)
    end do
    write(*,*)0., 1., a1
    write(*,*)

    do i = 1, M
        b = u
        b(1) = b(1) + c * a0;
        b(M - 1) = b(M - 1) + c * a1;

        u = tridiag_solve(-c, 1. + 2. * c, -c, b, size(b))

        ! print
        write(*,*)i * tau, 0., a0
        do k = 1, M - 1
            write(*,*)i * tau, k * h, u(k)
        end do
        write(*,*)i * tau, 1., a1
        write(*,*)

    end do

contains
function tridiag_solve(l, d, r, b, n)
    implicit none
    integer, intent(in) :: n
    real,  dimension(n) :: b
    real, intent(in) :: l, d, r
    real, dimension(n) :: tridiag_solve

    real,  dimension(n) :: bhat, rhat
    integer :: i

    ! your code here
    rhat(1) = r / d
    bhat(1) = b(1) / d
    do i=2,n
        rhat(i) = r / (d - l * rhat(i - 1))
        bhat(i) = (b(i) - l * bhat(i-1)) / (d - l * rhat(i-1))
    enddo

    tridiag_solve(n) = bhat(n)
    do i=n-1,1,-1
        tridiag_solve(i) = bhat(i) - rhat(i) * tridiag_solve(i + 1)
    end do

end function
end program

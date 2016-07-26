program implict_heat
    implicit none
    integer :: i, k
    integer, parameter :: M = 10
    ! we store only values at x_2, ..., x_M
    real, dimension(M - 1) :: u, b
    real :: h, c, tau, pi = 4. * atan(1.), x, t
    real :: a0, a1

    ! set boundary data
    a0 = 0.
    a1 = 0.
    ! initiialize parameters
    h = 1. / M      ! space resolution
    tau = h         ! time step

    c = tau / (h * h)

    ! initial data
    do k = 1, M - 1
        x = k * h
        u(k) = sin(pi * x)
    end do
    ! now u = u_0

    ! print initial data u_0
    write(*,*)0., 0., a0
    do k = 1, M - 1
        write(*,*)0., k * h, u(k)
    end do
    write(*,*)0., 1., a1
    write(*,*)

    do i = 1, M
        ! now u = u_{i-1}
        ! set up the right-hand side of the linear system
        b = u
        ! adjust for boundary data
        b(1) = b(1) + c * a0;
        b(M - 1) = b(M - 1) + c * a1;

        ! find the solution of the linear system
        u = tridiag_solve(-c, 1. + 2. * c, -c, b, size(b))
        ! now u = u_i

        ! print u_i
        write(*,*)i * tau, 0., a0
        do k = 1, M - 1
            write(*,*)i * tau, k * h, u(k)
        end do
        write(*,*)i * tau, 1., a1
        write(*,*)
    end do

contains
    ! this function returns the solution x of the system Ax = b
    ! where A is a tridiagonal matrix with entries l, d, r on
    ! the three diagonals
function tridiag_solve(l, d, r, b, n)
    implicit none
    integer, intent(in) :: n
    ! input array
    real,  dimension(n), intent(in) :: b
    real, intent(in) :: l, d, r
    ! return value will be stored in this array
    real, dimension(n) :: tridiag_solve

    real,  dimension(n) :: bhat, rhat
    integer :: i

    rhat(1) = r / d
    bhat(1) = b(1) / d
    do i=2,n
        rhat(i) = r / (d - l * rhat(i - 1))
        bhat(i) = (b(i) - l * bhat(i-1)) / (d - l * rhat(i-1))
    enddo

    ! compute the solution, starting from n, then n-1, n-2, ...
    tridiag_solve(n) = bhat(n)
    do i=1,n-1
        tridiag_solve(n - i) = bhat(n - i) - rhat(n - i) * tridiag_solve(n - i + 1)
    end do

end function
end program

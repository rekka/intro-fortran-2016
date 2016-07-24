program tridiag_solver
    implicit none
    write(*,*)tridiag_solve(1., -3., 1., (/ 7., 8., 9. /), 3 )
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

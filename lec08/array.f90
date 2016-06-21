program array
    implicit none
    integer :: i
    real, dimension(5) :: x, y
    real, dimension(4) :: z

    x = (/ 1., 2., 3., 4., 5. /)

    write(*,*) x

    do i=1,5
        y(i) = i
    end do
    write(*,*) y

    ! array operations
    write(*,*) sum(abs(x - y)) ! sum all abs. values of differences
    write(*,*) sqrt(sum(x * x)) ! norm

    ! number of elements
    write(*,*) size(x)

    ! array slicing
    z = y(2:5) - x(1:4)
    write(*,*) z
end program

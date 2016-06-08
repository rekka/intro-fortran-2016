program sort
    implicit none
    integer :: i, j
    integer, parameter :: M = 5
    real, dimension(M) :: x
    real :: s

    ! initialize the array
    do i=1, M
        x(i) = sin(real(i))
    end do

    ! sort the array
    do i=1, M-1
        do j=i+1, M
            if (x(i) > x(j)) then
                s = x(j)
                x(j) = x(i)
                x(i) = s
            end if
        end do
    end do
    write(*,*) x
end program


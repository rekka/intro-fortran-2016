program sort
    implicit none
    integer :: i, j
    integer, parameter :: M = 5
    real, dimension(M) :: x
    real :: s, t

    ! initialize the array
    do i=1, M
        x(i) = i
    end do

    ! sum
    s = 0.
    do i=1,M
        s = s + x(i)
    end do
    write(*,*)"sum = ",s

    ! average (mean)
    write(*,*)"average = ",s/M

    ! product
    s = 1.
    do i=1,M
        s = s * x(i)
    end do
    write(*,*)"product = ",s

    ! maximum value
    s = x(1)
    do i=2,M
        if (x(i) > s) then
            s = x(i)
        end if
    end do
    write(*,*)"max = ",s

    ! minimum value
    s = x(1)
    do i=2,M
        if (x(i) < s) then
            s = x(i)
        end if
    end do
    write(*,*)"min = ",s

    ! norm
    s = 0.
    do i=1,M
        s = s + x(i) * x(i)
    end do
    write(*,*)"norm = ",sqrt(s)

    ! second largest value
    if (x(1) > x(2)) then
        s = x(2)
        t = x(1)
    else
        s = x(2)
        t = x(1)
    end if
    do i=3,M
        if (x(i) > s) then
            if (x(i) > t) then
               s = t
               t = x(i)
            else
                s =x(i)
            end if
        end if
    end do
    write(*,*)"second largest value = ", s

end program


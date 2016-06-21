! compute pi using the sum in Leibniz formula
program sum
    implicit none
    real :: s
    integer :: i,N

    N = 100000
    s = 0.

    do i = 1,N
        if (mod(i, 2) == 0) then
            s = s - 1. / (2. * i - 1.)
        else
            s = s + 1. / (2. * i - 1.)
        end if
    end do

    write (*,*) s * 4.

end program

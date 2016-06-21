program backward
    implicit none
    integer :: i, N, k
    real :: x, h
    real, external :: f

    h = 0.5
    N = 1. / h

    ! backward Euler method for f(x,t) = -100x + 100t + 101
    x = 1.01
    write(*,*)0., x
    do i=1,N
        x = (x + h * (100. * i * h + 101.)) / (1. + 100. * h)
        write(*,*)i * h, x
    end do

end program

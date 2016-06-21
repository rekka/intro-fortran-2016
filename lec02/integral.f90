! compute integral of sin(x) from 0 to pi using the trapezoidal rule
program integral
    implicit none

    real :: sum,x,pi,h
    integer :: i,N

    N = 32
    pi = 4. * atan(1.)
    h = (pi - 0.) / N
    sum = 0.

    do i = 1,N
        x = i * h
        sum = sum + h * (sin(x - h) + sin(x)) / 2
    end do

    write (*,*) sum

end program

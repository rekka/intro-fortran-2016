program mandel
    implicit none
    !file
    real :: x,y,h,a,b,atemp
    integer :: i,j,k,n,m
    n = 500
    m = 100
    h = 4. / n
    do i=0,n
        do j=0,n
            x = j * h - 2.
            y = i * h - 2.

            a = 0.
            b = 0.

            do k = 1,m
                if (a * a + b * b > 4.) exit
                atemp = a * a - b * b + x
                b = 2 * a * b + y
                a = atemp
            end do
            write (*,'(I4)',advance='no') k
        end do
        write (*,*) ''
    end do
end program

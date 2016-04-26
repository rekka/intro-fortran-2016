set title "Error of the explicit Euler method"
set xlabel "h"
set ylabel "err"
set logscale xy
set xrange [0.001:1.]
plot 'error.dat', x, x**2, x**3

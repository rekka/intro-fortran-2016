set title "Error of the Euler method"  # set the title of the plot
set xlabel "h"                         # set the label for the x axis
set ylabel "err"                       # set the label for the y axis
set key right bottom                   # set the position of the legend
set logscale xy                        # set axes x and y to use the logarithmic scale
plot 'error.dat', x, x**2, x**3

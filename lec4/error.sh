#!/bin/sh

gfortran $1.f90 -o $1.out && ./$1.out > error.dat && gnuplot error.plt

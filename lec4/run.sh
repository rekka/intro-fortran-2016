#!/bin/sh

gfortran $1.f90 -o $1 && ./$1

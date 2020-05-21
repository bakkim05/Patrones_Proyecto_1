## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica
##
## usage w = w_gen (filas, columnas)
## 
## This function generates a matriz of dimension filas xcolumnas
## that varies in the range of minum for minimum and maxim for maximum.
## 
## Inputs:
##   filas: number of rows
##   columnas: number of columns
##   minum: minimum random value. Default value is -1.
##   maxim: maximum random value. Default value is 1.
##
## Outputs:
##   w: matrix of "filas" rows and "columnas" columns with random values
function w = w_gen (filas, columnas, minum = -1, maxim = 1)
  
  w = minum + (maxim - minum).*rand(filas,columnas);
  
endfunction
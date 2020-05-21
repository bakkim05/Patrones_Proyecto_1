## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducci�n al Reconocimiento de Patrones
## Escuela de Ingenier�a Electr�nica
## Tecnol�gico de Costa Rica


## usage [Mn]=normMatrix(mat)
## 
## This function normalizes the input matrix
## 
## Inputs:
##   mat: matrix to be normalized
##
## Outputs:
##   mn: normalized matrix

function [Mn]=normMatrix(mat)
  Mn=floor(mat./max(mat,[],2));  
  
endfunction

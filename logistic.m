## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducci�n al Reconocimiento de Patrones
## Escuela de Ingenier�a Electr�nica
## Tecnol�gico de Costa Rica


## usage l=logistic(x)
## 
## This function applies the sigmoid function to the input value.
## 
## Inputs:
##   x: numeric variable. 
##
## Outputs:
##   l: Result of applying x to the sigmoid function.

function l=logistic(x)
  l=1./(1+exp(-x));
endfunction

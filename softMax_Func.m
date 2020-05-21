## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica


## usage f=softMax_Func(x)
## 
## This function applies the soft max function to the input value.
## 
## Inputs:
##   x: numeric variable. 
##
## Outputs:
##   f: Result of applying x to the soft max function.

function f=softMax_Func(x)
  f = (exp(x-max(x,[],2)))./(sum(exp(x-max(x,[],2)),2));
endfunction


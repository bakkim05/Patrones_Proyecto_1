## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica


## usage [theta,vt,st] = adam (alpha, theta, gradiente, vt, st)
## 
## This function aplies the optimization technique ADAM.
## 
## Inputs:
##   alpha: Learning rate used in the artificial neural network.
##   theta: Weights used in the artificial neural network.
##   gradiente: Gradients of the artificial neural network.
##   vt: exponentially weighted average of gradients.
##   st: exponentially weighted average of the square of the gradients.
##   beta1: Beta value utilized in the calculation of vt. Default value is 0.9.
##   beta2: Beta value utilized in the calculation of st. Default value is 0.99.
##   epsilon: Mathematical constant with value 1e-9.
##
## Outputs:
##   theta: new weight for the artificial neural network
##   vt: new exponentially weighted average of gradients
##   st: new exponentially weighted average of the square of the gradients.

function [theta,vt,st] = adam (alpha, theta, gradiente, vt, st, beta1 = 0.9, beta2 = 0.99, epsilon = 10^-8)
  #New vt calculation given current vt and "gradiente".
  vt = beta1*vt + (1-beta1)*gradiente;
  #New st calculation given current st and "gradiente".
  st = beta2*st + (1-beta2)*(gradiente).^2;
  #New weight calculation given previous weights, vt and st.
  theta = theta - alpha*(st+e).^-1.*vt;
endfunction
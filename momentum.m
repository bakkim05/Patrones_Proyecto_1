## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica


## usage [vr,wr]=momentum(v,w,gradW)
## 
## This function aplies the optimization technique MOMENTUM.
## 
## Inputs:
##   v: exponentially weighted average of gradients.
##   w: Weights used in the artificial neural network.
##   gradW: Gradients of the artificial neural network.
##   alpha: Learning rate used in the artificial neural network. Default value is 0.15
##   bet: Beta value utilized in the calculation of vt. Default value is 0.56.
##
## Outputs:
##   vr: new exponentially weighted average of gradients
##   wr: new weight for the artificial neural network

    function [vr,wr]=momentum(v,w,gradW,alpha=0.15,bet=0.56)
      
      vr = bet*v + (1-bet)*gradW;
      
      wr = w - alpha*vr;
      
    endfunction

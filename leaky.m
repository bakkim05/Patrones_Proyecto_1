## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica
## 
## This class generates an object utilized for the activation function of Leaky Rectified
## Linear Unit (Leaky ReLU).
classdef leaky < handle
  properties    
    ## Resultados despuÃ©s de la propagaciÃ³n hacia adelante
    outputs=[];
    ## Resultados despuÃ©s de la propagaciÃ³n hacia atrÃ¡s
    gradient=[];
    ## Alpha
    alpha=0;
  endproperties

  methods
    ## This functions generates the object Leaky ReLU.
    function s=leaky(alph=0.01)
      s.outputs=[];
      s.gradient=[];
      s.alpha=alph;
    endfunction

    ## usage y=forward(s,a)
    ## 
    ## This function does the forward propagation for Leaky ReLU
    ##
    ## Inputs:
    ##   s: self
    ##   a: input values for the activation function
    ##
    ## Outputs:
    ##   y: activation value for the activation function
    function y=forward(s,a)
      s.outputs = max(s.alpha * a, a);
      y=s.outputs;
      s.gradient = [];
    endfunction

    ## usage backward(s,dLds)
    ## 
    ## This function does the backward propagation for Leaky ReLU
    ##
    ## Inputs:
    ##   s: self
    ##   dLds: Loss gradient.
    function backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de sigmoide no compatible con forward previo");
      endif
      localGrad = heaviside(s.outputs)+s.alpha*(1-heaviside(s.outputs));
      s.gradient = localGrad.*dLds;
    endfunction
  endmethods
endclassdef

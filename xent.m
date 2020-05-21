## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica
## 
## This class generates an object utilized to calculate the loss
## function Cross Entropy.

classdef xent < handle
  properties    
    outputs=[];
    gradient=[];
  endproperties

  methods
    ## This functions generates the object Cross Entropy.
    function s=xent()
      s.outputs=[];
      s.gradient=[];
    endfunction
    
    ## usage y=error(s,pnet,ytrain)
    ## 
    ## This function calculates the error utilizing Cross Entropy.
    ##
    ## Inputs:
    ##   s: self
    ##   pnet: Result from the Artificial Neural Network.
    ##   ytrain: Desired value  for the result.
    ##
    ## Outputs:
    ##   y: Calculated error from the loss function Cross Entropy.
    function y=error(s,pnet,ytrain)
      s.outputs = sum(sum(-ytrain.*log(pnet),2))/rows(ytrain);
      y=s.outputs;
      s.gradient = pnet-ytrain;
    endfunction

  endmethods
endclassdef

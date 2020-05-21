## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica
## 
## This class generates an object utilized to calculate the loss
## function Mean Squared Error (MSE)

classdef mse < handle
  properties    
    ## Calculated error from the loss function MSE.
    outputs=[];
    ## Gradient needed for proper backward propagation.
    gradient=[];
  endproperties

  methods
    ## This functions generates the object Mean Squared Error.
    function s=mse()    
      s.outputs=[];
      s.gradient=[];
    endfunction
    
    ## usage y=error(s,ynet,ytrain)
    ##
    ## This function calculates the error utilizing Mean Squared Error
    ##
    ## Inputs:
    ##   s: self
    ##   ynet: Result from the Artificial Neural Network.
    ##   ytrain: Desired value  for the result.
    ##
    ## Outputs:
    ##   y: Calculated error from the loss function MSE.
    function y=error(s,ynet,ytrain)
      s.outputs = norm((ynet-ytrain),'fro')^2/(rows(ytrain));
      y=s.outputs;
      s.gradient = (2*((ynet-ytrain))/(rows(ytrain)));
    endfunction

  endmethods
endclassdef


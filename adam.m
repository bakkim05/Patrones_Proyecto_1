#!/usr/bin/octave-cli

classdef adam < handle
  properties
    vdW = [];
    sdW = [];
    weight = []
  endproperties
  
  methods
    function w = adam()
      w.vdW = [];
      w.sdW = [];
      w.weight = [];
    endfunction
    
    function f = WeightedAvgPrevW (Beta, gradientW)
      w.vdW = Beta*w.vdW + (1-Beta)*gradientW;
      f = w.vdW;
    endfunction
    
    function f = WeightedAvgSqrPrevW (Beta, gradientW);    
      w.sdW = Beta*w.sdW + (1-Beta)*(gradientW.*gradientW);
      f = w.sdW;
    endfunction
    
    function f = theta(alfa)  #falta implementar esta funcion correctamente.
      w.weight = w.weight - alfa /
    endfunction
    
    function h = compute(alfa, gradiente, beta1 = 0.9, beta2 = 0.99)
      w.WeightedAvgPrevW (beta1, gradient);
      w.WeightedAvgSqrPrevW (beta2, gradient);
      w.theta(alfa);
    endfunction
    
  endmethods
  
  
  
  
  
endclassdef

#!/usr/bin/octave-cli

## "Capa" sigmoide, que aplica la función logística
classdef leaky < handle
  properties    
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
    ## Alpha
    alpha=0;
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=leaky(alph=0.01)
      s.outputs=[];
      s.gradient=[];
      s.alpha=alph;
    endfunction

    ## Propagación hacia adelante
    function y=forward(s,a)
      s.outputs = max(s.alpha * a, a);
      y=s.outputs;
      s.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de sigmoide no compatible con forward previo");
      endif
      localGrad = heaviside(s.outputs)+s.alpha*(1-heaviside(s.outputs));
      s.gradient = localGrad.*dLds;
    endfunction
  endmethods
endclassdef

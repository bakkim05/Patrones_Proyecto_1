#!/usr/bin/octave-cli
## "Capa" softMax, que aplica la función logística
classdef softMax < handle
  properties    
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=softMax()
      s.outputs=[];
      s.gradient=[];
    endfunction

    ## Propagación hacia adelante
    function y=forward(s,a)
      s.outputs = softMax_Func(a);
      y=s.outputs;
      s.gradient = [];
    endfunction

    function backward(s,dLds)
      if (size(dLds) != size(s.outputs))
        error("backward de softMax no compatible con forward previo");
      endif
      #localGrad = diag(s.outputs) - (s.outputs.*(s.outputs)');
      localGrad = s.outputs.*dLds-s.outputs*(s.outputs'*dLds);
      s.gradient = localGrad;
    endfunction
  endmethods
endclassdef

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

##    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
##    function backward(s,dLds)
##      if (size(dLds)!=size(s.outputs))
##        error("backward de sigmoide no compatible con forward previo");
##      endif
##      localGrad = s.outputs.*(1-s.outputs);
##      s.gradient = localGrad.*dLds;
##    endfunction
    
    
    function backward(s,dLds)
      if (size(dLds) != size(s.outputs))
        error("backward de softMax no compatible con forward previo");
      endif
      localGrad = diag(s.outputs) - (s.outputs.*(s.outputs)');
      s.gradient = localGrad.*dLds;
    endfunction
  endmethods
endclassdef

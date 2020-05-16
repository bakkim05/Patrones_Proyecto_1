#Entropia Cruzada


classdef xent < handle
  properties    
    outputs=[];
    gradient=[];
  endproperties

  methods
    function s=xent()
      s.outputs=[];
      s.gradient=[];
    endfunction

    function y=error(s,pnet,ytrain)
      s.outputs = -ytrain'*ln(pnet);
      y=s.outputs;
      s.gradient = pnet-ytrain;
    endfunction

  endmethods
endclassdef

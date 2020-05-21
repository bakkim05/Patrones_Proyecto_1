#funcion MSE


classdef mse < handle
  properties    
    outputs=[];
    gradient=[];
  endproperties

  methods
    function s=mse()
      s.outputs=[];
      s.gradient=[];
    endfunction

    function y=error(s,ynet,ytrain)
      s.outputs = norm((ynet-ytrain),'fro')^2/(rows(ytrain));
      y=s.outputs;
      s.gradient = (2*((ynet-ytrain))/(rows(ytrain)));
    endfunction

  endmethods
endclassdef


## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducci�n al Reconocimiento de Patrones
## Escuela de Ingenier�a Electr�nica
## Tecnol�gico de Costa Rica
## 
## This class generates an object that contains the confusion matrix.
classdef confusionMatrix < handle
  
  properties
    matc=[];
    pre=0;
    rec=0;
    yfone=0;
  endproperties
 
  methods
       
    ## usage y=buildMatrix(s,yt,ynet)
    ## 
    ## Constructs the confusion matrix
    ##
    ## Inputs:
    ##   s: self
    ##   yt: 
    ##   ynet: 
    ##
    ## Outputs:
    ##   y: confusion matrix
    function y=buildMatrix(s,yt,ynet)
    s.matc=yt'*ynet;
    y=s.matc;    
    endfunction

    ## usage y=recall(s)
    ## 
    ## Calculates the recall of the confusion matrix
    ##
    ## Inputs:
    ##   s: self
    ##
    ## Outputs:
    ##   y: recall of the confusion matrix
    function y=recall(s)
      s.rec = diag(s.matc)./sum(s.matc,2);
      y=s.rec;
    endfunction
    
    ## usage y=precision(s)
    ## 
    ## Calculates the Presicion of the confusion matrix
    ##
    ## Inputs:
    ##   s: self
    ##
    ## Outputs:
    ##   y: Presicion of the confucion matrix
    function y=precision(s)
      s.pre = (diag(s.matc)'./sum(s.matc,1))';
      y=s.pre;
    endfunction
    
    ## usage y=fone(s)
    ## 
    ## Calculates the F1 value of the confusion matrix
    ##
    ## Inputs:
    ##   s: self
    ##
    ## Outputs:
    ##   y: F1 value of the confusion matrix
    function y=fone(s)
      s.yfone = 2*(s.pre.*s.rec)./(s.pre+s.rec);
      y=s.yfone;
    endfunction
 
  endmethods
endclassdef
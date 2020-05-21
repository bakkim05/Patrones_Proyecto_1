
classdef confusionMatrix < handle
  
  properties
    matc=[];
    pre=0;
    rec=0;
    yfone=0;
  endproperties
 
  methods
    function y=buildMatrix(s,yt,ynet)
    s.matc=yt'*ynet;
    y=s.matc;    
    endfunction

    function y=recall(s)
      s.rec = diag(s.matc)'./sum(s.matc,1);
      y=s.rec;
    endfunction
    
    function y=precision(s)
      s.pre = diag(s.matc)./sum(s.matc,2);
      y=s.pre;
    endfunction
    
    function y=fone(s)
      s.yfone = 2*(s.pre*s.rec)/(s.pre+s.rec);
      y=s.yfone;
    endfunction
 
  endmethods
endclassdef
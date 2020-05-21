
classdef confusionMatrix < handle
  
  properties    

    predictedTrue=[];
    predictedFalse=[];
    actualTrue=[];
    actualFalse=[];
    tn=[];
    fn=[];
    fp=[];
    tp=[];
  endproperties
 
  methods
    function y=buildMatrix(s,yt,ynet)
      s.predictedTrue=nnz(ynet);
      s.predictedFalse=numel(ynet)-nnz(ynet);
      s.actualTrue=nnz(yt);
      s.actualFalse=numel(yt)- nnz(yt);
      s.tp=nnz(yt.*ynet);
      s.fn=s.actualTrue-s.tp;
      s.tn=s.predictedFalse-s.fn;
      s.fp=s.actualFalse-s.tn;
      y=[numel(yt) s.predictedFalse s.predictedTrue; s.actualFalse s.tn s.fp; s.actualTrue s.fn s.tp];
    endfunction

    function y=recall(s)
      y = s.tp/(s.tp+s.fn)
    endfunction
    
    function y=precision(s)
      y = s.tp/(s.tp+s.fp)
    endfunction
    
    function y=fone(s)
      y = 2*(s.tp*s.fp)/(s.tp+s.fp)
    endfunction
 
  endmethods
endclassdef
function [Mn]=normMatrix(mat)
  Mn=floor(mat./max(mat,[],2));  
  
endfunction

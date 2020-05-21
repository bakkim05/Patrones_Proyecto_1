function [Mn]=normMatrix(mat)
  Mn=[];
  
  for i=1:rows(mat)
  row=[zeros(1,columns(mat))];
  [num,ind]=max(mat(i,:));  
  row(ind)=1;    
  Mn=[Mn;row];  
    end
  
endfunction

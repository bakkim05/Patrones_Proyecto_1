function [aciertos,errores,failindex]=comparar(correct,approx)
  aciertos=0;
  errores=0;
  filas=length(correct);
  act=1;
  failindex=[];
  while act<filas+1
  [q,A]=max(correct(act,:));
  [q,B]=max(approx(act,:));
  if [A==B]
    aciertos+=1;
  else
    errores+=1;
    failindex=[failindex act];
  end
  act+=1;
  
  end
endfunction

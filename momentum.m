#funcion MSE

    function [vr,wr]=momentum(v,w,gradW,alpha=0.15,bet=0.56)
      
      vr = bet*v + (1-bet)*gradW;
      
      wr = w - alpha*vr;
      
    endfunction

function w = w_gen (filas, columnas, minum = -1, maxim = 1)
  
  w = minum + (maxim - minum).*rand(filas,columnas);
  
endfunction




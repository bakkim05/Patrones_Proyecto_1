function n = normalizar(matriz)
  n = matriz - min(matriz(:));
  n = n ./ max(n(:));
endfunction
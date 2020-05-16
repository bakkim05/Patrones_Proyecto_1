function f=softMax_Func(x)
  f = exp(x-max(x))./sum(exp(x-max(x).*(ones(size(x),1))));
endfunction


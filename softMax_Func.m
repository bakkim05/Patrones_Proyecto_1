function f=softMax_Func(x)
  f = (exp(x-max(x,[],2)))./(sum(exp(x-max(x,[],2)),2));
endfunction


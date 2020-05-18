#!/usr/bin/octave-cli
function [theta,vt,st] = adam (alfa, theta, gradiente, vt, st, beta1 = 0.9, beta2 = 0.99, epsilon = 10^-8)
  vt = beta1*vt + (1-beta1)*gradiente;
  st = beta2*st + (1-beta2)*(gradiente.*gradiente);
  theta = theta - (alfa ./ diag(sqrt(st + epsilon*eye(size(st)))))*vt;
endfunction

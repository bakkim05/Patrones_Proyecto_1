## Copyright (C) 2020 Pablo Alvarado
##
## Este archivo forma parte del material del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

1;

## Capas:
l1a=fullyconnected();
l1b=sigmoide();
l2a=fullyconnected();
l2b=sigmoide();

## Forward prop

[x,ytrain]=create_data(4,3,"radial");
x=x(:,1)
x=[1 x']'
W1=[0.1 0.3 -0.1 0;-0.2 0.5 0.2 0.1; 1 0 0.1 -0.3; 0.5 0.6 0.8 -0.9];
W2=[0.1 -0.1 0.2 0.3;-0.4 -0.5 0.1 0.2];

y1a=l1a.forward(W1,x);
y1b=l1b.forward(y1a);
y2a=l2a.forward(W2,y1b);
y2b=l2b.forward(y2a);

## FALTA calcular ||y2b-ytn||^2

## Backprop.

l2b.backward([1 1]'); # asumiendo que esto es el final
l2a.backward(l2b.gradient);
l1b.backward(l2a.gradientX);
l1a.backward(l1b.gradient);

l1a.gradientW
l1a.gradientX

alpha = 0.1; ################################
W1 = W1 + alpha*l1a.gradientW;
W2 = W2 + alpha*l2a.gradientW;

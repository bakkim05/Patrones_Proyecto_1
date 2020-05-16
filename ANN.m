## Copyright (C) 2020 Pablo Alvarado
##
## Este archivo forma parte del material del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica


## Capas:
l1a=fullyconnected();
l1b=sigmoide();

l2a=fullyconnected();
l2b=leaky();

l3a=fullyconnected();
l3b=ReLU();

l4a=fullyconnected();
l4b=softMax();


## Forward prop

x=[1 2 3 4]';
W1=[0.1  0.3 -0.1 0;-0.2 0.5 0.2 0.1; 1 0 0.1 -0.3; 0.5 0.6 0.8 -0.9];
W2=[0.1  0.3 -0.1 0;-0.2 0.5 0.2 0.1; 1 0 0.1 -0.3; 0.5 0.6 0.8 -0.9;  0.5 0.6 0.8 -0.9];
W3=[0.1  0.3 -0.1 0 2;-0.2 0.5 0.2 1 3;0 0.1 -0.3 0 1];
W4=[0.1  0.3 -0.1;-0.2 0.5 0.2 ;0 0.1 -0.3];
yt = [5 6 7]';

y1a=l1a.forward(W1,x);
y1b=l1b.forward(y1a);

y2a=l2a.forward(W2,y1b);
y2b=l2b.forward(y2a);

y3a=l3a.forward(W3,y2b);
y3b=l3b.forward(y3a);

y4a=l4a.forward(W4,y3b);
y4b=l4b.forward(y4a);


J = xent();
error = J.error(y4b,yt);
gradJ = J.gradient;


## Backprop.


l4b.backward(gradJ); # asumiendo que esto es el final
l4a.backward(l4b.gradient);
l3b.backward(l4a.gradientX);
l3a.backward(l3b.gradient);
l2b.backward(l3a.gradientX);
l2a.backward(l2b.gradient);
l1b.backward(l2a.gradientX);
l1a.backward(l1b.gradient);



alpha = 0.05; ################################
W1 = W1 + alpha*l1a.gradientW;
W2 = W2 + alpha*l2a.gradientW;
W3 = W3 + alpha*l3a.gradientW;
W4 = W4 + alpha*l4a.gradientW;

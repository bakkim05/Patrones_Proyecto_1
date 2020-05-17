## Copyright (C) 2020 Pablo Alvarado
##
## Este archivo forma parte del material del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

1;
pkg load specfun;
pkg load statistics;
[X,Y] = create_data(3,2, "vertical")

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
x  = X;
#x  = [1 x]';
W1 = [0.1  0.3 ;-0.2 0.5 ; 1 0 ; 0.5 0.6 ];
W2 = [0.1  0.3 -0.1 0.5;-0.2 0.5 0.2 0.2; 0 0.1 1 0.3; 0.5 0.8 -0.9 0.3];
W3 = [0.1  0.3 0 1;-0.2 0.5 0.1 1; 1 0 -0.3 1; 0.5 0.6 -0.9 1];
W4 = [0.1  0.3 -0.1 0.5;-0.2 0.5 1 0.3];
yt = Y(:,2);

counter =0;
while counter < 1500
y1a=l1a.forward(W1,x);
y1b=l1b.forward(y1a);

#y1b=[1;y1b];
y2a=l2a.forward(W2,y1b);
y2b=l2b.forward(y2a);

#y2b=[1;y2b];
y3a=l3a.forward(W3,y2b);
y3b=l3b.forward(y3a);

#y3b=[1;y3b];
y4a=l4a.forward(W4,y3b);
y4b=l4b.forward(y4a);

J = xent();
y4b
yt

error = J.error(y4b,yt);
gradJ = J.gradient;
## Backprop.

l4b.backward(gradJ); # asumiendo que esto es el final
l4a.backward(l4b.gradient);

l3b.backward(l4a.gradientX(2:end));
l3a.backward(l3b.gradient);

l2b.backward(l3a.gradientX(2:end));
l2a.backward(l2b.gradient);

l1b.backward(l2a.gradientX(2:end));
l1a.backward(l1b.gradient);

alpha = 0.08; ################################
W1 = W1 - alpha*l1a.gradientW;
W2 = W2 - alpha*l2a.gradientW;
W3 = W3 - alpha*l3a.gradientW;
W4 = W4 - alpha*l4a.gradientW;
counter =counter +1;
counter
end
y4b
yt
## Copyright (C) 2020 Pablo Alvarado
##
## Este archivo forma parte del material del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica
pkg load statistics;
pkg load specfun;
n=3; #muestras
nw1 = 5; #peso capa 1
nw2 = 10;#peso capa 2
nw3 = 10;#peso capa 3
c=2; #clases


[X,Y] = create_data(n,c, "vertical");

## Capas:
l1a=fullyconnected();
l1b=sigmoide();

l2a=fullyconnected();
l2b=leaky();

l3a=fullyconnected();
l3b=ReLU();

l4a=fullyconnected();
l4b=sigmoide();
#l4b=sigmoide();


## Forward prop

yt = Y(1,1:c)';
#yt = [Y(1:2,1); Y(1:2,2); Y(1:2,3)];
x  = [X(:)];
x  = [1; x];
W1 = w_gen(rows(x),nw1)';
W2 = w_gen(nw1+1,nw2)';
W3 = w_gen(nw2+1,nw3)';
W4 = w_gen(nw3+1,c)';


counter =0;
while counter < 1000
y1a=l1a.forward(W1,x);
y1b=l1b.forward(y1a);
y1b=[1;y1b];
y2a=l2a.forward(W2,y1b);
y2b=l2b.forward(y2a);
y2b=[1;y2b];
y3a=l3a.forward(W3,y2b);
y3b=l3b.forward(y3a);
y3b=[1;y3b];
y4a=l4a.forward(W4,y3b);
y4b=l4b.forward(y4a);

J = mse();
#J = mse();
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







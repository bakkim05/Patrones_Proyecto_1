## Copyright (C) 2020 Pablo Alvarado
##
## Este archivo forma parte del material del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

1;
pkg load specfun;
pkg load statistics;
n=1000; #muestras
nEpocas=1000;
MLSize=10;
nML=ceil(n/MLSize);


nw1 = 10; #peso capa 1
nw2 = 6;#peso capa 2
nw3 = 5;#peso capa 3
c=5; #clases
[X,Y] = create_data(n,c, "radial");

## Capas:
l1a=fullyconnected();
l1b=leaky();
#l1b=RelU();
#l1b=sigmoide();
l2a=fullyconnected();
l2b=leaky();
#l2b=RelU();
#l2b=sigmoide();
l3a=fullyconnected();
l3b=leaky();
#l3b=RelU();
#l3b=sigmoide();
l4a=fullyconnected();
l4b=sigmoide();
#l4b=softMax();

## Forward prop
x  = X;
x = [ones(rows(x),1) x];
W1 = w_gen(columns(x),nw1)';
W2 = w_gen(nw1+1,nw2)';
W3 = w_gen(nw2+1,nw3)';
W4 = w_gen(nw3+1,c)';
yt = Y;

counter =1;
v1=0;
v2=0;
v3=0;
v4=0;
s1=0;
s2=0;
s3=0;
s4=0;
alpha = 0.26;
bet=0.06;
val_saved=[];

EpocaActual=1;
while EpocaActual <= nEpocas
  EpocaActual
  RandIndx=randperm(rows(X));
  MLActual=1;
  yEpoca=[];
  while MLActual <= nML
    MLIndx=RandIndx((MLActual-1)*MLSize+1:min(rows(X),MLActual*MLSize));
    MLx=x(MLIndx,:);
    MLy=yt(MLIndx,:);
    y1a=l1a.forward(W1,MLx);
    y1b=l1b.forward(y1a);

    y1b=[ones(rows(y1b),1) y1b];
    
    y2a=l2a.forward(W2,y1b);
    y2b=l2b.forward(y2a);
    
    y2b=[ones(rows(y2b),1) y2b];
    
    y3a=l3a.forward(W3,y2b);
    y3b=l3b.forward(y3a);

    y3b=[ones(rows(y3b),1) y3b];
    
    y4a=l4a.forward(W4,y3b);
    y4b=l4b.forward(y4a);
    
    yEpoca=[yEpoca;y4b];
    
    J = mse();
    #J = xent();
    errorML = J.error(y4b,MLy);
    gradJ = J.gradient;
    
    
    ## Backprop.
    
    l4b.backward(gradJ); # asumiendo que esto es el final
    l4a.backward(l4b.gradient);
    
    l3b.backward(l4a.gradientX(:,2:end));
    l3a.backward(l3b.gradient);
    
    l2b.backward(l3a.gradientX(:,2:end));
    l2a.backward(l2b.gradient);
    
    l1b.backward(l2a.gradientX(:,2:end));
    l1a.backward(l1b.gradient);
    
    #W1 = W1 - alpha*l1a.gradientW;
    #W2 = W2 - alpha*l2a.gradientW;
    #W3 = W3 - alpha*l3a.gradientW;
    #W4 = W4 - alpha*l4a.gradientW;

    [v1,W1]=momentum(v1,W1,l1a.gradientW,alpha,bet);
    [v2,W2]=momentum(v2,W2,l2a.gradientW,alpha,bet);
    [v3,W3]=momentum(v3,W3,l3a.gradientW,alpha,bet);
    [v4,W4]=momentum(v4,W4,l4a.gradientW,alpha,bet);
    
    #[W1,v1,s1]=adam(alpha,W1,l1a.gradientW,v1,s1);
    #[W2,v2,s2]=adam(alpha,W2,l2a.gradientW,v2,s2);
    #[W3,v3,s3]=adam(alpha,W3,l3a.gradientW,v3,s3);
    #[W4,v4,s4]=adam(alpha,W4,l4a.gradientW,v4,s4);
    
    val_saved(counter,1) = counter;
    val_saved(counter,2) = error;
    
    MLActual += 1;

    
  end
  errorEpoca = J.error(yEpoca,yt(RandIndx,:));
  if mod(EpocaActual,1)==0
    errorEpoca
  end
  if errorEpoca<0.00015
    EpocaActual
    errorEpoca
    break
  end
  
    EpocaActual += 1;
end

[C,E,fails]=comparar(yt(RandIndx,:),yEpoca)

classdef model < handle
## Modelo
##
## Esta clase encapsula una red neuronal, con m�todos para
## almacenar, cargar, entrenar y predecir.
properties
## Constantes:
numInputs=2;
hiddenNeurons1 =16;
hiddenNeurons2 =16;
hiddenNeurons3 =16;
clases=5;

## ...
## Training parameters
nEpochs =2000;
MLSize=10;
alpha = 0.01;
bet=0.06;

##
errXepoc=[];
##

## ...
## Capas :
l1a=fullyconnected();
##l1b=sigmoide();
##l1b=ReLU();
l1b=leaky();
l2a=fullyconnected();
##l2b=sigmoide();
##l2b=ReLU();
l2b=leaky();
l3a=fullyconnected();
##l3b=sigmoide();
##l3b=ReLU();
l3b=leaky();
l4a=fullyconnected();
l4b=sigmoide();
#l4b=softMax();

J = mse();
#J = xent();


## DATA
W1 = [];
W2 = [];
W3 = [];
W4 = [];

v1=0;
v2=0;
v3=0;
v4=0;
s1=0;
s2=0;
s3=0;
s4=0;

endproperties
methods
function s=model ()
s.init()
endfunction
function init (s)
## I n i c i a l i c e e l modelo con v a l o r e s a l a z a r
## . . .
s.W1 = w_gen((s.numInputs)+1,s.hiddenNeurons1)';
s.W2 = w_gen(s.hiddenNeurons1+1,s.hiddenNeurons2)';
s.W3 = w_gen(s.hiddenNeurons2+1,s.hiddenNeurons3)';
s.W4 = w_gen(s.hiddenNeurons3+1,s.clases)';




endfunction
function [yp]=train ( s,x,yt , valSetX =[] , valSetY =[] )
## Entrene el modelo
## X: matriz de dise�no (datos de entrenamiento en filas)
## y : matriz de salida, cada fila codificada one?hot
## valSetX : set de validaci�n (opcional) (entradas en filas)
## valSetY : set de validaci�n (opcional) (salidas en filas)
## loss log : protocolo con p�rdida por �poca, para set de
## entrenamiento y opci�n almente el set de validaci�n
## . . .
    n=rows(x)
    nML=ceil(n/s.MLSize);
  for ep=1:s.nEpochs
    RandIndx=randperm(rows(x));
    MLActual=1;
    yEpoca=[];
    
    while MLActual <= nML
    MLIndx=RandIndx((MLActual-1)*s.MLSize+1:min(rows(x),MLActual*s.MLSize));
    MLx=x(MLIndx,:);
    MLy=yt(MLIndx,:);
    
    y1a=s.l1a.forward(s.W1,MLx);
    y1b=s.l1b.forward(y1a);
  
    y1b=[ones(rows(y1b),1) y1b];
  
    y2a=s.l2a.forward(s.W2,y1b);
    y2b=s.l2b.forward(y2a);
  
    y2b=[ones(rows(y2b),1) y2b];
  
    y3a=s.l3a.forward(s.W3,y2b);
    y3b=s.l3b.forward(y3a);
  
    y3b=[ones(rows(y3b),1) y3b];
  
    y4a=s.l4a.forward(s.W4,y3b);
    y4b=s.l4b.forward(y4a);

    yEpoca=[yEpoca;y4b];
    
    error = s.J.error(y4b,MLy);
    gradJ = s.J.gradient;
  ##############QUITAR########

  ################################
  ## Backprop.
  
    s.l4b.backward(gradJ); # asumiendo que esto es el final
    s.l4a.backward(s.l4b.gradient);
  
    s.l3b.backward(s.l4a.gradientX(:,2:end));
    s.l3a.backward(s.l3b.gradient);
  
    s.l2b.backward(s.l3a.gradientX(:,2:end));
    s.l2a.backward(s.l2b.gradient);
  
    s.l1b.backward(s.l2a.gradientX(:,2:end));
    s.l1a.backward(s.l1b.gradient);
  
    #s.W1 = s.W1 - s.alpha*s.l1a.gradientW;
    #s.W2 = s.W2 - s.alpha*s.l2a.gradientW;
    #s.W3 = s.W3 - s.alpha*s.l3a.gradientW;
    #s.W4 = s.W4 - s.alpha*s.l4a.gradientW;
  
    [s.v1,s.W1]=momentum(s.v1,s.W1,s.l1a.gradientW,s.alpha,s.bet);
    [s.v2,s.W2]=momentum(s.v2,s.W2,s.l2a.gradientW,s.alpha,s.bet);
    [s.v3,s.W3]=momentum(s.v3,s.W3,s.l3a.gradientW,s.alpha,s.bet);
    [s.v4,s.W4]=momentum(s.v4,s.W4,s.l4a.gradientW,s.alpha,s.bet);
  
    #[s.W1,s.v1,s.s1]=adam(s.alpha,s.W1,s.l1a.gradientW,s.v1,s.s1);
    #[s.W2,s.v2,s.s2]=adam(s.alpha,s.W2,s.l2a.gradientW,s.v2,s.s2);
    #[s.W3,s.v3,s.s3]=adam(s.alpha,s.W3,s.l3a.gradientW,s.v3,s.s3);
    #[s.W4,s.v4,s.s4]=adam(s.alpha,s.W4,s.l4a.gradientW,s.v4,s.s4);
    MLActual+=1;
    endwhile
  
 
 
################################# 
    errorEpoca = s.J.error(yEpoca,yt(RandIndx,:));
    s.errXepoc = [s.errXepoc;[ep errorEpoca]];
    ep
    errorEpoca
    if errorEpoca<0.03
      break
    end
##################################  

end
  ep
  errorEpoca
  yp(RandIndx,:)=yEpoca;
endfunction



function yv4b=test (s,Xv)
## P r e d i c c i �on con modelo p r e e n t r e n a d o
## . . .
    yv1a=s.l1a.forward(s.W1,Xv);
    yv1b=s.l1b.forward(yv1a);
  
    yv1b=[ones(rows(yv1b),1) yv1b];
  
    yv2a=s.l2a.forward(s.W2,yv1b);
    yv2b=s.l2b.forward(yv2a);
  
    yv2b=[ones(rows(yv2b),1) yv2b];
  
    yv3a=s.l3a.forward(s.W3,yv2b);
    yv3b=s.l3b.forward(yv3a);
  
    yv3b=[ones(rows(yv3b),1) yv3b];
  
    yv4a=s.l4a.forward(s.W4,yv3b);
    yv4b=s.l4b.forward(yv4a);

    



endfunction



function save (s,file)
## Trucos para s a l v a r l a s m a t ri c e s
#W1 = s.W1;
#W2 = s.W2;
#W3 = s.W3;
#save (file , �W1� , �W2� , �W3� );
W1 = w_gen(s.miniBatch+1,hiddenNeurons1)';
W2 = w_gen(hiddenNeurons1+1,hiddenNeurons2)';
W3 = w_gen(hiddenNeurons2+1,hiddenNeurons3)';
W4 = w_gen(hiddenNeurons3+1,clases)';
endfunction
function o=load (s,file)
## Cargue l a s m a t ri c e s s al v a d a s a n t e ri o rm e n t e y a s e g u r e c o n s i s t e n c i a
## de para metros
load (file) ;
s.W1=W1;
s.W2=W2;
s.W3=W3;
s.numInputs=columns(s.W1)-1;
s.hiddenNeurons1=rows (s.W1) ;
s.hiddenNeurons2=rows (s.W2) ;
s.numClasses=rows (s.W3) ;
endfunction

endmethods
endclassdef
## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica
## 
## This class encapsulates the neural network as an object

classdef model < handle

properties
## Neural Network Properties:
## Number of data's dimensions.
numInputs=2;
## Number of neurons per layer.
hiddenNeurons1 =16;
hiddenNeurons2 =16;
hiddenNeurons3 =16;
## Number of data's clases 
clases=5;
## Number of trainig epochs.
nEpochs =2000;
## Number of samples per minibatch.
MLSize=10;
## Learning ratio.
alpha = 0.01;
## inertia parameter.
bet=0.06;

##
## Store error values for each epoch.
errXepoc=[];
##

## Layers.
## First fully conected layer.
l1a=fullyconnected();

## First acitvation layer.
##l1b=sigmoide();
##l1b=ReLU();
l1b=leaky();

## First fully conected layer.
l2a=fullyconnected();

## Second acitvation layer.
##l2b=sigmoide();
##l2b=ReLU();
l2b=leaky();

## Third fully conected layer.
l3a=fullyconnected();

## Third acitvation layer.
##l3b=sigmoide();
##l3b=ReLU();
l3b=leaky();

## Fourth fully conected layer.
l4a=fullyconnected();

## Fourth acitvation layer.
l4b=sigmoide();
#l4b=softMax();

## Error function layer.
J = mse();
#J = xent();


## Store weights.
W1 = [];
W2 = [];
W3 = [];
W4 = [];

## Store v for optimization technique.
v1=0;
v2=0;
v3=0;
v4=0;

## Store s for optimization technique.
s1=0;
s2=0;
s3=0;
s4=0;

endproperties
methods
     
## This function generates the object model. 
function s=model (c)
s.init()
s.clases=c;
endfunction

## This function initialize the model's weights with random values.
function init (s)
s.W1 = w_gen((s.numInputs)+1,s.hiddenNeurons1)';
s.W2 = w_gen(s.hiddenNeurons1+1,s.hiddenNeurons2)';
s.W3 = w_gen(s.hiddenNeurons2+1,s.hiddenNeurons3)';
s.W4 = w_gen(s.hiddenNeurons3+1,s.clases)';
endfunction


## usage [yp]=train (s,x,yt)
## 
## Trains the neural network
##
## Inputs:
##   s: self
##   x: Design matrix
##   yt: Training output
##   valSetX: validation set for inputs
##   valSetY: validation set for outputs
##
## Outputs:
##   yp: best prediction of the neural network
function [yp]=train ( s,x,yt , valSetX =[] , valSetY =[] )
     
## usage yv4b=test(s,Xv)
## 
## Tests the neural network
##
## Inputs:
##   s: self
##   Xv: Validation inputs
##
## Outputs:
##   yv4b: Aproximations made by the neural network utilizing the validation inputs.     

    ## Number of samples.
    n=rows(x)
    ## Number of minibatches needed.
    nML=ceil(n/s.MLSize);
    
    ##Neural network's training.
  for ep=1:s.nEpochs
    RandIndx=randperm(rows(x));
    MLActual=1;
    yEpoca=[];
    while MLActual <= nML
    MLIndx=RandIndx((MLActual-1)*s.MLSize+1:min(rows(x),MLActual*s.MLSize));
    MLx=x(MLIndx,:);
    MLy=yt(MLIndx,:);
    
    ##Forwardprop.
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


## usage save (s,file)
## 
## Saves the neural network
##
## Inputs:
##   s: self
##   file: Destination file
function save (s,file)
## Trucos para s a l v a r l a s m a t ri c e s
#W1 = s.W1;
#W2 = s.W2;
#W3 = s.W3;
#save (file , ”W1” , ”W2” , ”W3” );
W1 = w_gen(s.miniBatch+1,hiddenNeurons1)';
W2 = w_gen(hiddenNeurons1+1,hiddenNeurons2)';
W3 = w_gen(hiddenNeurons2+1,hiddenNeurons3)';
W4 = w_gen(hiddenNeurons3+1,clases)';
endfunction

## o=load (s,file)
## 
## Loads the neural network
##
## Inputs:
##   s: self
##   file: Extraction file
##
## Outputs:
##   o: loads the weights and parameters of the loaded neural network 
function o=load (s,file)

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
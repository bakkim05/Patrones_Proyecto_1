## Copyright (C) 2020 Oscar Arias, Jung Bak, Hamlet Loria, Daniel Rojas
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingenierí­a Electrónica
## Tecnológico de Costa Rica
## 
## This class execute the creation, training and validation phases of a neural network.

1;
pkg load specfun;
pkg load statistics;
clear;

## Training and validation set's parameters.
n=1000;
c=5;
forma='curved';
datosval=400;

## This function creates the training set.
[X,Y] = create_data(n,c, forma);
x = [ones(rows(X),1) X];
yt = Y;

## This function generates object model.
Red=model(c);
## This function trains the neural network.
[yp]=Red.train(x,yt);

## This function normalizes the neural network's outputs.
yp=normMatrix(yp);

## This function creates the training set.
[Xv,Yv] = create_data(datosval,c,forma);

xv = [ones(rows(Xv),1) Xv];
yv=Yv;
##This function does the neural network's test.
[ypv]=Red.test(xv,yv);
errorval = Red.J.error(ypv,yv);

## This function normalizes the neural network's validation outputs.
ypvn=normMatrix(ypv);

## This function creates the confusion matrix.
matConf=confusionMatrix();
matConf.buildMatrix(yv,ypvn);

## Calculates the confusion matrix' recall, precision and f1 value.
matConf.recall();
matConf.precision();
matConf.fone();

## Plots the training set samples.
plot_data(Xv,Yv)
figSpace = linspace(-1,1,256);
[GX,GY] = meshgrid(figSpace,figSpace);
FX = [ones(size(GX(:)),1) GX(:) GY(:)];
FZ = Red.test(FX);
## Append the last probability
## A figure with the winners
[maxprob,maxk]=max(FZ,[],2);

## Plots the winner classes space.
figure(2,"name","Winner classes");

winner=flip(uint8(reshape(maxk,size(GX))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
wimg=ind2rgb(winner,cmap);
imshow(wimg);

## Plot the classes' probabilities space.
figure(3,"name","Winner Blurry");
ccmap = cmap(2:1+c,:);
cwimg = ccmap'*(FZ./sum(FZ,2))';
redChnl   = reshape(cwimg(1,:),size(GX));
greenChnl = reshape(cwimg(2,:),size(GX));
blueChnl  = reshape(cwimg(3,:),size(GX));

mixed = flip(cat(3,redChnl,greenChnl,blueChnl),1);
imshow(mixed);

## Plots the learning curve.
figure(4,"name","Error vs Época")
plot(Red.errXepoc(:,1),Red.errXepoc(:,2));






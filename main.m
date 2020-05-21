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

n=1000; #muestras
c=5; #clases
forma='curved';
datosval=400;

[X,Y] = create_data(n,c, forma);
x = [ones(rows(X),1) X];
yt = Y;
Red=model(c);
[yp]=Red.train(x,yt);
yp=normMatrix(yp);

[Xv,Yv] = create_data(datosval,c,forma);
xv = [ones(rows(Xv),1) Xv];
yv=Yv;
###########Test#####
[ypv]=Red.test(xv,yv);
errorval = Red.J.error(ypv,yv);
ypvn=normMatrix(ypv);
####################
matConf=confusionMatrix();
matConf.buildMatrix(yv,ypvn);
matConf.recall();
matConf.precision();
matConf.fone();


plot_data(Xv,Yv)
figSpace = linspace(-1,1,256);
[GX,GY] = meshgrid(figSpace,figSpace);
FX = [ones(size(GX(:)),1) GX(:) GY(:)];
FZ = Red.test(FX);
## Append the last probability
## A figure with the winners
[maxprob,maxk]=max(FZ,[],2);

figure(2,"name","Winner classes");

winner=flip(uint8(reshape(maxk,size(GX))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
wimg=ind2rgb(winner,cmap);
imshow(wimg);


figure(3,"name","Winner Blurry");
ccmap = cmap(2:1+c,:);
cwimg = ccmap'*(FZ./sum(FZ,2))';
redChnl   = reshape(cwimg(1,:),size(GX));
greenChnl = reshape(cwimg(2,:),size(GX));
blueChnl  = reshape(cwimg(3,:),size(GX));

mixed = flip(cat(3,redChnl,greenChnl,blueChnl),1);
imshow(mixed);

figure(4,"name","Error vs Época")
plot(Red.errXepoc(:,1),Red.errXepoc(:,2));






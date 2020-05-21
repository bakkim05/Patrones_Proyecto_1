1;
pkg load specfun;
pkg load statistics;
clear;
n=1000; #muestras
c=5; #clases
forma='pie';
[X,Y] = create_data(n,c, forma);
x = [ones(rows(X),1) X];
yt = Y;
Red=model();
[yp]=Red.train(x,yt);
#[C,E,fails]=comparar(yt,yp)
yp=normMatrix(yp);

datosval=400;
[Xv,Yv] = create_data(datosval,c,forma);
xv = [ones(rows(Xv),1) Xv];
yv=Yv;
###########Test#####
[ypv]=Red.test(xv,yv);
errorval = Red.J.error(ypv,yv);
ypv=normMatrix(ypv);
####################
matConf=confusionMatrix();
matConf.buildMatrix(yt,yp);
matConf.recall();
matConf.precision();
matConf.fone();


plot_data(X,Y)
figSpace = linspace(-1,1,256);
[GX,GY] = meshgrid(figSpace,figSpace);
FX = [ones(size(GX(:)),1) GX(:) GY(:)];
FZ = Red.test(FX);
FZ = [FZ; ones(1,columns(FZ))-sum(FZ)]; ## Append the last probability

## A figure with the winners
[maxprob,maxk]=max(FZ,[],2);

figure(2,"name","Winner classes");

winner=flip(uint8(reshape(maxk(1:end-1),size(GX))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
wimg=ind2rgb(winner,cmap);
imshow(wimg);

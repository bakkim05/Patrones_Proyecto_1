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

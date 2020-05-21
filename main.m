1;
pkg load specfun;
pkg load statistics;
clear;
n=4000; #muestras
c=5; #clases
[X,Y] = create_data(n,c, "pie");
x = [ones(rows(X),1) X];
yt = Y;
Red=model();
[yp]=Red.train(x,yt);
[C,E,fails]=comparar(yt,yp)
disp(7);

d = 3;

vx = 0:0.1:d;
vy = 0.75;
vyE = fE(vx,vy,d);
vyF = fF(vx,vy,d);

vyDiff = vyF-vyE;

fig1 = figure ;
set(fig1,'Position',[8 252 495 331]) ;
plot(vx,vyDiff) ;
xlabel('x') ;
ylabel('y') ;

fig2 = figure ;
set(fig2,'Position',[512 252 506 331]) ;
plot(vx,vyE,vx,vyF) ;
xlabel('x') ;
ylabel('y') ;
legend("f_E","f_F") ;

fig = [ fig1 fig2] ;
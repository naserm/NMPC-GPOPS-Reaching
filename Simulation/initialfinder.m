xf=fsolve(@(x)kin(x(1),x(2),-0.1,0.4),[x10;x30]);
x1f=xf(1)*180/pi
x3f=xf(2)*180/pi
% [XZfinal(1),temp,XZfinal(2),temp]=invkin(x1f,0,x3f,0);
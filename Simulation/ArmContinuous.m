function phaseout = ArmContinuous(input)

% input
% input.phase(phasenumber).state
% input.phase(phasenumber).control
% input.phase(phasenumber).time
% input.phase(phasenumber).parameter
%
% input.auxdata = auxiliary information
%
% output
% phaseout(phasenumber).dynamics
% phaseout(phasenumber).path
% phaseout(phasenumber).integrand

t = input.phase.time;
z = input.phase.state;
v = input.phase.control;

x=z(:,1:4);
u=z(:,5:10);
%% straight out of maplesim
dy=xpfunction_arm(t,x,u);

% err=(((x(:,1)-input.auxdata.Xdes(1))).^2+...
%      ((x(:,3)-input.auxdata.Xdes(2))).^2);
 
% x0=0;
% xf=0.2;
% xd0=0;xdf=0;
% xdd0=0;xddf=0;
% tf=1;
% 
% a0=x0;
% a1=xd0;
% a2=xdd0/2;
% a3=(20*xf-20*x0-(8*xdf+12*xd0)*tf-(3*xdd0-xddf)*tf^2)/(2*tf^3);
% a4=(30*x0-30*xf+(14*xdf+16*xd0)*tf+(3*xdd0-2*xddf)*tf^2)/(2*tf^4);
% a5=(12*xf-12*x0-(6*xdf+6*xd0)*tf-(xdd0-xddf)*tf^2)/(2*tf^5);
% 
% X=a0+a1*t+a2*t.^2+a3*t.^3+a4*t.^4+a5*t.^5;
% 
% theta=input.auxdata.theta;%-90*pi/180;
% R=[cos(theta) -sin(theta);sin(theta) cos(theta)];
% xzf=R*[xf;0];
% 
% xz=[X t*0]*R';
% 
% XZ=XYZ(x);
% XZinitial=input.auxdata.XZinitial;
% 
% errX=(XZ(:,1)-(XZinitial(1)+xz(:,1))).*(t<=1)+(XZ(:,1)-(XZinitial(1)+xzf(1))).*(t>1);
% errZ=(XZ(:,2)-(XZinitial(2)+xz(:,2))).*(t<=1)+(XZ(:,2)-(XZinitial(2)+xzf(2))).*(t>1);

XZ=XYZ(x);
XZinitial=input.auxdata.XZinitial;
errX=XZ(:,1)-(XZinitial(1)+0.2);
errZ=XZ(:,2)-(XZinitial(2)+0.01248);

errx=errX.^2+10*errZ.^2;

errVX=XZ(:,3);
errVZ=XZ(:,4);
errv=errVX.^2+errVZ.^2;

w=10e-2;

err=errx+w*errv;
dx=[dy MuscleActivation(u,v) err];
%%
phaseout.dynamics = dx;

integrand          =(v(:,1).^2+v(:,2).^2+v(:,3).^2+v(:,4).^2+v(:,5).^2+v(:,6).^2);

phaseout.integrand = integrand;

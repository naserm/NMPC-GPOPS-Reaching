function ArmPlot(state,control,time,auxdata)
%-------------------------------------------------------------------------%
%                             Extract Solution                            %
%-------------------------------------------------------------------------%
% solution = output.result.solution;
% time = solution.phase(1).time;
% state = solution.phase(1).state;
% control = solution.phase(1).control;
% for i=1:length(output.meshhistory);
%   mesh(i).meshPoints = [0 cumsum(output.meshhistory(i).result.setup.mesh.phase.fraction)];
%   mesh(i).time =  output.meshhistory(i).result.solution.phase.time;
%   mesh(i).iteration = i*ones(size(mesh(i).meshPoints));
%   mesh(i).iterationTime = i*ones(size(mesh(i).time));
% end;

%-------------------------------------------------------------------------%
%                              Plot Solution                              %
%-------------------------------------------------------------------------%
figure(1);hold on,%clf
pp = plot(time,state(:,1)*180/pi,'-');
hold on
pp = plot(time,state(:,3)*180/pi,'-');
xl = xlabel('time');
yl = ylabel('y1');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'Fontsize',16);
set(pp,'LineWidth',1.25);
grid on
% print -depsc2 robotArm-Y1.eps
% print -dpng robotArm-Y1.png

%%
figure(2);hold on,%clf
pp = plot(time,state(:,2),'-');
hold on
pp = plot(time,state(:,4),'-');

xl = xlabel('time');
yl = ylabel('theta dot');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'Fontsize',16);
set(pp,'LineWidth',1.25);
grid on
% print -depsc2 robotArm-Y2.eps
% print -dpng robotArm-Y2.png
%%

figure(3);hold on,%clf
pp = plot(time,state(:,5:10),'-o');
xl = xlabel('time');
yl = ylabel('u1');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'Fontsize',16);
set(pp,'LineWidth',1.25);
grid on
legend('u1','u2','u3','u4','u5','u6')
% print -depsc2 robotArm-U1.eps
% print -dpng robotArm-U1.png

%%
figure(4);hold on,
[XX,temp,ZZ,temp]=invkin(state(:,1),state(:,2),state(:,3),state(:,4));
pp = plot(-XX,ZZ,'-o');

L1=0.4;%31/100;%
L2=0.325;%17/50;%
X_2 = - L1 .* cos(state(:,1));
Z_2 = L1 .* sin(state(:,1));

X_1 = -L2 .* cos(state(:,1) + state(:,3)) - L1 .* cos(state(:,1));
Z_1 = L2 .* sin(state(:,1) + state(:,3)) + L1 .* sin(state(:,1));


plot(-[X_1(end),X_2(end)],[Z_1(end),Z_2(end)])
plot(-[0,X_2(end)],[0,Z_2(end)])


xl = xlabel('X');
yl = ylabel('Z');
set(xl,'Fontsize',18);
set(yl,'Fontsize',18);
set(gca,'Fontsize',16);
set(pp,'LineWidth',1.25);
grid on
xlim([-0.25 0.5])
ylim([-0.05 0.75])


figure(5);hold on
XZ=XYZ(state);
% plot(XZ(:,1),XZ(:,2),'-r');
plot(time,XZ(:,1),'-r');
% plot(tNMPC,XZ(:,2),'-r');
grid on
t=time;
x0=0;
xf=0.2;
xd0=0;xdf=0;
xdd0=0;xddf=0;
t0=0;
tf=1;

a0=x0;
a1=xd0;
a2=xdd0/2;
a3=(20*xf-20*x0-(8*xdf+12*xd0)*tf-(3*xdd0-xddf)*tf^2)/(2*tf^3);
a4=(30*x0-30*xf+(14*xdf+16*xd0)*tf+(3*xdd0-2*xddf)*tf^2)/(2*tf^4);
a5=(12*xf-12*x0-(6*xdf+6*xd0)*tf-(xdd0-xddf)*tf^2)/(2*tf^5);

% t=0:0.01:1;

X=a0+a1*t+a2*t.^2+a3*t.^3+a4*t.^4+a5*t.^5;

theta=auxdata.theta;
% theta=-90*pi/180;
R=[cos(theta) -sin(theta);sin(theta) cos(theta)];
xzf=R*[xf;0];

% xz=(R*[X t*0]')';
xz=[X' t'*0]*R';

XZinitial=auxdata.XZinitial;
plot(time,(XZinitial(1)+0.2)*ones(1,size(time,2)),'--b','LineWidth',4);
%%
figure(6);hold on
XZ=XYZ(state);
% plot(XZ(:,1),XZ(:,2),'-r');
plot(time,XZ(:,3),'-r');
% plot(time,XZ(:,2),'-r');
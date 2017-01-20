%------------------------- Robot Arm Problem -----------------------------%
% This example is shows the application of GOPOS in NMPC contrl           %
%   Example: Planar Arm model, goal-directed control                      %
%   Naser Mehrabi                                                         %
%-------------------------------------------------------------------------%
clearvars
%%
for var3 = [0.2]% 0.3 0.4 0.5 0.8 1]
for var2 = 2e2;% [4  5 6 7 8 9 10 11 12 13 14 15]%0 1 2 3 
for var1 = 0;%[0 1 2 3 4  5 6 7 8 9 10 11 12 13 14 15]
clc
clearvars -except var1 var2 var3
delete('ArmContinuousADiGatorHes.mat', 'ArmEndpointADiGatorHes.mat', 'ArmContinuousADiGatorGrd.mat','ArmEndpointADiGatorGrd.mat')
% for tph=0.2:0.3:1.4
% tph=0.8;     %Prediction horizon (sec)
tph=var3;
auxdata.tph=tph;
auxdata.theta=180*pi/180;
% close all
%-------------------------------------------------------------------------%
%------------------------- Specify NMPC Parameters -----------------------%
%-------------------------------------------------------------------------%
tfinal=2.0;     %final simulation time (esc)
tapplied=0.02;
tGuess=[];
statesNMPC=[];
controlsNMPC=[];
tNMPC=[];
auxdata.statesNMPC=zeros(1,6);

auxdata.w=[var1,var2,1000,0]; %w1:penalty w2:tracking, w3:effort w4: penalty for final speed
%-------------------------------------------------------------------------%
%------------ Specify and calculate initial and final states -------------%
%-------------------------------------------------------------------------%
x10 = 40*pi/180;%40
x20=0; 
x30 = 62*pi/180;%50
x40=0;
x50=0;x60=0;x70=0;x80=0;x90=0;x100=0;
[XZinitial(1),temp,XZinitial(2),temp]=invkin(x10,0,x30,0);
auxdata.XZinitial = XZinitial;
Xdis=[197.944991666667]/1000;
Zdis=0.012457;
xf=fsolve(@(x)kin(x(1),x(2),XZinitial(1)+Xdis,XZinitial(2)+Zdis),[x10;x30]);
x1f=xf(1);x3f=xf(2);
[XZfinal(1),temp,XZfinal(2),temp]=invkin(x1f,0,x3f,0);
% XZfinal-[Xdis,Zdis]-XZinitial %check
auxdata.Xdes =[xf];% [tt',xx];
%%
%-------------------------------------------------------------------------%
%----------------- Provide All Bounds for Problem ------------------------%
%-------------------------------------------------------------------------%
t0 = 0; tf=tph;


x1min = -pi; x1max = pi ;
x2min = -4; x2max =  4;
x3min = -pi; x3max = pi;
x4min = -4; x4max =  4;
x5min = 0;  x5max =  1;
x6min = 0;  x6max =  1;
x7min = 0;  x7max =  1;
x8min = 0;  x8max =  1;
x9min = 0;  x9max =  1;
x10min = 0; x10max = 1;
x110=0;
x11min = 0; x11max = 10000;


udotmax=1;%50;
u1min = -udotmax; u1max =  udotmax;
u2min = -udotmax; u2max =  udotmax;
u3min = -udotmax; u3max =  udotmax;
u4min = -udotmax; u4max =  udotmax;
u5min = -udotmax; u5max =  udotmax;
u6min = -udotmax; u6max =  udotmax;

%%
%-------------------------------------------------------------------------%
%----------Provide Mesh Refinement Method and Initial Mesh ---------------%
%-------------------------------------------------------------------------%
mesh.method          = 'hp-LiuRao';%'hp-LiuRao-Legendre';%'hp-DarbyRao';%'hp-PattersonRao';%
mesh.tolerance       = 1e-9; %1e-6
mesh.maxiterations   = 15;%15;
mesh.colpointsmin    = 3;
mesh.colpointsmax    = 15;
N                    = 2;
mesh.phase.colpoints = 3*ones(1,N);
mesh.phase.fraction  = ones(1,N)/N;

%-------------------------------------------------------------------------%
%------------- Assemble Information into Problem Structure ---------------%        
%-------------------------------------------------------------------------%
setup.mesh                            = mesh;
setup.name                            = 'Arm-Problem';
setup.functions.endpoint              = @ArmEndpoint;
setup.functions.continuous            = @ArmContinuous;
setup.displaylevel                    = 0;
setup.auxdata                         = auxdata;


setup.nlp.solver                      = 'ipopt';
setup.nlp.snoptoptions.tolerance      = 1e-10;
setup.nlp.snoptoptions.maxiterations  = 500000;

setup.nlp.ipoptoptions.tolerance      = 1e-20;
setup.nlp.ipoptoptions.linear_solver  = 'mumps';%'ma57';%
setup.nlp.ipoptoptions.maxiterations  = 2000;

setup.derivatives.supplier            = 'adigator';%'sparseCD';
setup.derivatives.derivativelevel     = 'second';%'first';%

setup.method                          = 'RPM-Differentiation';%'RPM-Integration';%
setup.mesh                            = mesh;
setup.scales.method                   = 'automatic-hybridUpdate';%'automatic-bounds';%'automatic-guessUpdate';%'none';%'automatic-hybrid';%'automatic-guess';%

for i_step=1:round(tfinal/tapplied)
time=[];
state=[];
control=[];
%-------------------------------------------------------------------------%
%----------------------- Setup for Problem Bounds ------------------------%
%-------------------------------------------------------------------------%
bounds.phase.initialtime.lower  = t0+(i_step-1)*tapplied;
bounds.phase.initialtime.upper  = t0+(i_step-1)*tapplied;
bounds.phase.finaltime.lower    = tf+(i_step-1)*tapplied;
bounds.phase.finaltime.upper    = tf+(i_step-1)*tapplied;
bounds.phase.initialstate.lower = [x10, x20, x30, x40, x50, x60, x70, x80, x90, x100, x110];
bounds.phase.initialstate.upper = [x10, x20, x30, x40, x50, x60, x70, x80, x90, x100, x110];
bounds.phase.state.lower = [x1min, x2min, x3min, x4min, x5min, x6min, x7min, x8min, x9min, x10min, x11min];
bounds.phase.state.upper = [x1max, x2max, x3max, x4max, x5max, x6max, x7max, x8max, x9max, x10max, x11max];
bounds.phase.finalstate.lower = [x1min, x2min, x3min, x4min, x5min, x6min, x7min, x8min, x9min, x10min, x11min];
bounds.phase.finalstate.upper = [x1max, x2max, x3max, x4max, x5max, x6max, x7max, x8max, x9max, x10max, x11max];
bounds.phase.control.lower = [u1min, u2min, u3min, u4min, u5min, u6min];
bounds.phase.control.upper = [u1max, u2max, u3max, u4max, u5max, u6max];

if (i_step==1)
%     bounds.phase.initialstate.lower = [x10, x20, x30, x40, x5min, x6min, x7min, x8min, x9min, x10min];
%     bounds.phase.initialstate.upper = [x10, x20, x30, x40, x5max, x6max, x7max, x8max, x9max, x10max];
    bounds.phase.initialstate.lower = [x10, x20, x30, x40, 0, 0, 0, 0, 0, 0, 0];
    bounds.phase.initialstate.upper = [x10, x20, x30, x40, 0, 0, 0, 0, 0, 0, 0];
end

bounds.phase.integral.lower     = 0;
bounds.phase.integral.upper     = 1;
guess.phase.integral = 0;

%-------------------------------------------------------------------------%
% -----------------------------------------%
%---------------------- Provide Guess of Solution ------------------------%
%-------------------------------------------------------------------------%
% if isempty(tGuess)
tGuess                = [t0;  tf];
x1Guess               = [x10;  x10];
x2Guess               = [x20;  x20];
x3Guess               = [x30;  x30];
x4Guess               = [x40;  x40];
x5Guess               = [0;  0];
x6Guess               = [0;  0];
x7Guess               = [0;  0];
x8Guess               = [0;  0];
x9Guess               = [0;  0];
x10Guess              = [0;  0];
x11Guess              =[0;0];

u1Guess               = [u1max; u1min; ];
u2Guess               = [u2max; u2min; ];
u3Guess               = [u3max; u3min; ];
u4Guess               = [u4max; u4min; ];
u5Guess               = [u5max; u5min; ];
u6Guess               = [u6max; u6min; ];

guess.phase.state    = [x1Guess, x2Guess, x3Guess, x4Guess, x5Guess, x6Guess, x7Guess, x8Guess, x9Guess, x10Guess, x11Guess];%, 
guess.phase.control  = [u1Guess, u2Guess, u3Guess, u4Guess, u5Guess, u6Guess];
guess.phase.time     = [tGuess];
% else
% guess.phase.state    = state;
% guess.phase.control  = control;
% guess.phase.time     = time;
% end

setup.bounds                          = bounds;
setup.guess                           = guess;
%-------------------------------------------------------------------------%
%----------------------- Solve Problem Using GPOPS2 ----------------------%
%-------------------------------------------------------------------------%
%%
output = gpops2(setup);

% ArmPlot
solution = output.result.solution;
time = solution.phase(1).time;
state = solution.phase(1).state;
control = solution.phase(1).control;

times=t0+(i_step-1)*tapplied+[0+eps tapplied];
states = interp1(time,state,times');
controls = interp1(time,control,times');

tNMPC=[tNMPC times];
statesNMPC=[statesNMPC; states];
controlsNMPC=[controlsNMPC; controls];
% auxdata.statesNMPC=statesNMPC(end,5:10);
% NMPCplotter
ArmPlot(statesNMPC,controlsNMPC,tNMPC,auxdata)

x10=states(end,1);
x20=states(end,2);
x30=states(end,3);
x40=states(end,4);
x50=states(end,5);
x60=states(end,6);
x70=states(end,7);
x80=states(end,8);
x90=states(end,9);
x100=states(end,10);
x110=states(end,11);

drawnow
i_step/round(tfinal/tapplied)*100
end
% save('DO','tNMPC','statesNMPC')
save(strcat('t',sprintf('%0.4g',1000*tph),'tracking_u_w_',sprintf('%0.4g',auxdata.w(1)),'_',sprintf('%0.4g',auxdata.w(2)),'_',sprintf('%0.4g',auxdata.w(3)),'_',sprintf('%0.4g',auxdata.w(4))),'tNMPC','statesNMPC','controlsNMPC','auxdata')
end
end
end
% This code was generated using ADiGator version 1.2
% ©2010-2014 Matthew J. Weinstein and Anil V. Rao
% ADiGator may be obtained at https://sourceforge.net/projects/adigator/ 
% Contact: mweinstein@ufl.edu
% Bugs/suggestions may be reported to the sourceforge forums
%                    DISCLAIMER
% ADiGator is a general-purpose software distributed under the GNU General
% Public License version 3.0. While the software is distributed with the
% hope that it will be useful, both the software and generated code are
% provided 'AS IS' with NO WARRANTIES OF ANY KIND and no merchantability
% or fitness for any purpose or application.

function output = ArmEndpointADiGatorHes(input)
global ADiGator_ArmEndpointADiGatorHes
if isempty(ADiGator_ArmEndpointADiGatorHes); ADiGator_LoadData(); end
Gator1Data = ADiGator_ArmEndpointADiGatorHes.ArmEndpointADiGatorHes.Gator1Data;
Gator2Data = ADiGator_ArmEndpointADiGatorHes.ArmEndpointADiGatorHes.Gator2Data;
% ADiGator Start Derivative Computations
%User Line: % Inputs
%User Line: % input.phase(phasenumber).initialstate -- row
%User Line: % input.phase(phasenumber).finalstate -- row
%User Line: % input.phase(phasenumber).initialtime -- scalar
%User Line: % input.phase(phasenumber).finaltime -- scalar
%User Line: % input.phase(phasenumber).integral -- row
%User Line: %
%User Line: % input.parameter -- row
%User Line: % input.auxdata = auxiliary information
%User Line: % Output
%User Line: % output.objective -- scalar
%User Line: % output.eventgroup(eventnumber).event -- row
xf1.dv = input.phase.finalstate.dv;
xf1.f = input.phase.finalstate.f;
%User Line: xf1=input.phase(1).finalstate;
cada1f1 = input.auxdata.w(3);
cada1f2dv = cada1f1*input.phase.integral.dv;
cada1f2 = cada1f1*input.phase.integral.f;
cada1f3dv = cada1f2dv/input.auxdata.tph;
cada1f3 = cada1f2/input.auxdata.tph;
cada1f4 = input.auxdata.w(2);
cada1f5dv = xf1.dv(11);
cada1f5 = xf1.f(11);
cada1f6dv = cada1f4*cada1f5dv;
cada1f6 = cada1f4*cada1f5;
cada1f7dv = cada1f6dv/input.auxdata.tph;
cada1f7 = cada1f6/input.auxdata.tph;
cada1td1 =  zeros(2,1);
cada1td1(2) = cada1f3dv;
cada2f1 = cada1td1(1);
cada2f2 = cada2f1 + cada1f7dv;
cada1td1(1) = cada2f2;
cada1f8dv = cada1td1;
cada1f8 = cada1f3 + cada1f7;
cada1f9 = input.auxdata.w(1);
cada1f10dv = xf1.dv(1);
cada1f10 = xf1.f(1);
cada1f11 = input.auxdata.Xdes(1);
cada1f12dv = cada1f10dv;
cada1f12 = cada1f10 - cada1f11;
cada1f13dv = xf1.dv(3);
cada1f13 = xf1.f(3);
cada1f14 = input.auxdata.Xdes(2);
cada1f15dv = cada1f13dv;
cada1f15 = cada1f13 - cada1f14;
cada1td1 =  zeros(2,1);
cada1td1(1) = cada1f12dv;
cada1td1(2) = cada1f15dv;
cada1f16dv = cada1td1;
cada1f16 = [cada1f12;cada1f15];
cada2f1dv = cada1f16dv;
cada2f1 = cada1f16(:);
cada2f2dv = 1.*cada2f1(:).^(1-1).*cada2f1dv;
cada2f2 = cada2f1.^1;
cada2f3dv = 2.*cada2f2dv;
cada2f3 = 2*cada2f2;
cada1f17dvdv = cada1f16dv(:).*cada2f3dv;
cada1f17dv = cada2f3.*cada1f16dv;
cada1f17 = cada1f16.^2;
cada1f18dvdv = cada1f17dvdv; cada1f18dv = cada1f17dv;
cada1f18 = sum(cada1f17);
cada1f19 = cada1f9*cada1f18;
cada1f20dv = cada1f8dv;
cada1f20 = cada1f8 + cada1f19;
cada1f21 = input.auxdata.w(4);
cada1f22dv = xf1.dv(2);
cada1f22 = xf1.f(2);
cada1f23dv = xf1.dv(4);
cada1f23 = xf1.f(4);
cada1td1 =  zeros(2,1);
cada1td1(1) = cada1f22dv;
cada1td1(2) = cada1f23dv;
cada1f24dv = cada1td1;
cada1f24 = [cada1f22;cada1f23];
cada2f1dv = cada1f24dv;
cada2f1 = cada1f24(:);
cada2f2dv = 1.*cada2f1(:).^(1-1).*cada2f1dv;
cada2f2 = cada2f1.^1;
cada2f3dv = 2.*cada2f2dv;
cada2f3 = 2*cada2f2;
cada1f25dvdv = cada1f24dv(:).*cada2f3dv;
cada1f25dv = cada2f3.*cada1f24dv;
cada1f25 = cada1f24.^2;
cada1f26dvdv = cada1f25dvdv; cada1f26dv = cada1f25dv;
cada1f26 = sum(cada1f25);
cada1f27 = cada1f21*cada1f26;
output.objective.dv = cada1f20dv;
output.objective.f = cada1f20 + cada1f27;
%User Line: output.objective = input.auxdata.w(3)*input.phase.integral/input.auxdata.tph                 + input.auxdata.w(2)*xf1(11)             /input.auxdata.tph                 + input.auxdata.w(1)*sum([(xf1(1)-input.auxdata.Xdes(1));                                           (xf1(3)-input.auxdata.Xdes(2))].^2)                 + input.auxdata.w(4)*sum([xf1(2);                                           xf1(4)].^2);
output.objective.dv_size = 25;
output.objective.dv_location = Gator1Data.Index1;
end


function ADiGator_LoadData()
global ADiGator_ArmEndpointADiGatorHes
ADiGator_ArmEndpointADiGatorHes = load('ArmEndpointADiGatorHes.mat');
return
end
function output = ArmEndpoint(input)

% Inputs
% input.phase(phasenumber).initialstate -- row
% input.phase(phasenumber).finalstate -- row
% input.phase(phasenumber).initialtime -- scalar
% input.phase(phasenumber).finaltime -- scalar
% input.phase(phasenumber).integral -- row
%
% input.parameter -- row

% input.auxdata = auxiliary information

% Output
% output.objective -- scalar
% output.eventgroup(eventnumber).event -- row

xf1=input.phase(1).finalstate;% -- row

output.objective = input.auxdata.w(3)*input.phase.integral/input.auxdata.tph...
                 + input.auxdata.w(2)*xf1(11)             /input.auxdata.tph...
                 + input.auxdata.w(1)*sum([(xf1(1)-input.auxdata.Xdes(1));
                                           (xf1(3)-input.auxdata.Xdes(2))].^2)...
                 + input.auxdata.w(4)*sum([xf1(2)
                                           xf1(4)].^2);
                        



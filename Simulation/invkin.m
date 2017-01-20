% alpha=.2274961183;
% beta=1.388092758;
function [X,Xd,Z,Zd]=invkin(alpha,alphad,beta,betad)
L1=0.4;%31/100;%
L2=0.325;%17/50;%
X=L2.*sin(alpha).*sin(beta)-L2.*cos(alpha).*cos(beta)-L1.*cos(alpha);
Z=L2.*cos(alpha).*sin(beta)+L2.*sin(alpha).*cos(beta)+L1.*sin(alpha);

Xd= L2.*sin(beta).*(alphad).*cos(alpha)+L2.*sin(beta).*(betad).*cos(alpha)+L2.*(alphad).*cos(beta).*sin(alpha)+L2.*(betad).*cos(beta).*sin(alpha)+L1.*(alphad).*sin(alpha);
Zd=-L2.*sin(beta).*(alphad).*sin(alpha)-L2.*sin(beta).*(betad).*sin(alpha)+L2.*(alphad).*cos(alpha).*cos(beta)+L2.*(betad).*cos(alpha).*cos(beta)+L1.*(alphad).*cos(alpha);
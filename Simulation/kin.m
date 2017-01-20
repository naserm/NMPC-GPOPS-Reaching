function [ERR]=kin(alpha,beta,X,Z)
ERR=zeros(2,1);
L1=0.4;%31/100;%
L2=0.325;%17/50;%
ERR(1)=L2.*sin(alpha).*sin(beta)-L2.*cos(alpha).*cos(beta)-L1.*cos(alpha)-X;
ERR(2)=L2.*cos(alpha).*sin(beta)+L2.*sin(alpha).*cos(beta)+L1.*sin(alpha)-Z;
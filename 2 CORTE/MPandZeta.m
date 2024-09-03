function [Sigma,Wd,Ts,Mp,Wn,Zeta]=MPandZeta(Sigma,Wd,Wn,Zeta,Ts,Mp,CTs)
%[Phi,P,Z,Kc,C]=CompensadorBisectriz(Gs,Wn,Zeta)
%ingresasr Mp en su forma normal no porcentual
%ingresar el criterio CTs en su forma normal no porcentual

%Zeta=-log(Mp)/(sqrt(pi^2+log(Mp)^2))
%Zeta=Sigma/Wn
%Wn=sqrt(Sigma^2+Wd^2)
%Wn=Sigma/Zeta
%Wn=4.6/(Zeta*Wn)
%Sigma=Zeta*Wn
%Sigma=4.6/Ts
%Sigma=-Wd*log(Mp)/pi
%Wd=Wn*sqrt(1-Zeta^2)
%Wd=-Sigma*pi/(log(Mp))
%Wd=sqrt(Wn^2-Sigma^2)
%Tp=pi/Wd
%Ts=4.6/Sigma
%Ts=4.6/(Zeta*Wn)
%Mp=exp(-pi*Zeta/sqrt(1-Zeta^2))
%Mp=exp(-pi*Sigma/Wd)
clc
Cts=-log(CTs)
% Zeta=0; Wn=0; 
% Mp=0; Ts=0;
% Sigma=0; Wd=0;
% Ts=1; Wd=2.6; 

if ((Zeta>0)&&(Wn>0)) %Zeta y WN
clc
Sigma=Wn*Zeta;
Wn=Sigma/Zeta;
Wd=Wn*sqrt(1-Zeta^2);
Ts=Cts/Sigma;
Mp=exp(-pi*Zeta/sqrt(1-Zeta^2));
elseif((Mp>0)&&(Ts>0)) %Mp y Ts
clc
Zeta=-log(Mp)/(sqrt(pi^2+log(Mp)^2));
Sigma=Cts/Ts;
Wn=Cts/(Zeta*Ts);
Wd=Wn*sqrt(1-Zeta^2);
elseif((Sigma>0)&&(Wd>0)) %Sigma y Wd
Wn=sqrt(Sigma^2+Wd^2);
Zeta=Sigma/Wn;
Mp=exp(-pi*Zeta/sqrt(1-Zeta^2));
Ts=Cts/(Zeta*Wn)
elseif((Ts>0)&&(Wd>0)) %Ts y Wd
Sigma=Cts/Ts;
Mp=exp(-pi*Sigma/Wd);
Wn=sqrt(Sigma^2+Wd^2);
Zeta=Sigma/Wn;
Mp=exp(-pi*Zeta/sqrt(1-Zeta^2));
end
Mp=Mp*100;

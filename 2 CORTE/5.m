%% Gs=(30+N)/(s*(0.1*s+1)*(s+20));
%Zeta>0.5 Wn>10
clc
clear
close all
N=4;
s=tf('s');
Gs=10/(s*(s+2)*(s+5))
Tc=feedback(Gs,1);
ProcentajeCriterioTs=0.02;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
ParametroSys(feedback(Gs,1),ProcentajeCriterioTs,CriterioRiso)
[Ep,Ev,Ea,Kp,Kv,Ka]=ErroEpEvEa(Gs);
Eva=Ev
Kva=1/(Ev)-1
Kvd=1/(Ev/5)-1
 step(feedback(Gs,1))
  figure(2)
 %rlocus(Gs)
subplot(221),rlocus(Gs)
subplot(223),nyquist(Gs)
subplot(122),margin(Gs)
%C=4;
%C=11.5*(s+0.5)/(s+5)
%C=1*(s+0.1)/(s+0.01);

%% 

Sigma=2; 
Wd=2*sqrt(3); 
Wn=0; 
Zeta=0; 
Ts=0; 
Mp=0; 
CTs=0.01;
[Sigma,Wd,Ts,Mp]=MPandZeta(Sigma,Wd,Wn,Zeta,Ts,Mp,CTs)
[Phi,Theta,Alpha,P,Z,Kc,C]=CompensadorBisectriz_SigmaWdZeta(Gs,Sigma,Wd,Zeta,1.5)
% C=18.568*(s+0.9)/(s+5)
C1= 74.324*(s+2.33)*(s+1.1)/((s+38.33)*(s+0.11))
%% 

clc
close all
s=tf('s')

GsC=C1*Gs;
Tc=feedback(GsC,1); %sistema controlado
Tk=feedback(Gs,1);
Su=feedback(C,Gs); %señal de control
ParametroSys(Tc,ProcentajeCriterioTs,CriterioRiso)
GsCE=s*GsC;

% [Ep,Ev,Ea,Kp,Kv,Ka]=ErroEpEvEa(GsC);
 Kva=dcgain(GscE)
figure(2)
subplot(121),step(Tc,Tk),legend
subplot(122),step(Su),legend
%subplot(133),margin(Tk)
figure(3)
rlocus(GsC)
%% 

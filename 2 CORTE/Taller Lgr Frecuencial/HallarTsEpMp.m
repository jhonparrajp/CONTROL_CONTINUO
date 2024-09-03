%% Gs=(20+N)/(s*(s+4)*(s+20))
%Ts<=0.5 ep<1% Mp<10%

clc
clear
N=1;
s=tf('s');
 Gs=(20+N)/(s*(s+4)*(s+20));
ProcentajeCriterioTs=0.02;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
figure(1)
step(Gs)
figure(2)
subplot(221),rlocus(Gs)
subplot(223),nyquist(Gs)
subplot(122),margin(Gs)
%sisotool(Gs)
%% Calcular polos deseados y posicion
clc
Mp=0.1; Ts=0.5
Zeta=-log(Mp)/(sqrt(pi^2+log(Mp)^2))
%tomo un zeta mayor por critierios del diseñador para tener menor sobrepico
Zeta=0.8
Sigma=4/Ts
rlocus(Gs)
sgrid(Zeta,0)
Wn=4/(Zeta*Ts)
Wd=Wn*sqrt(1-Zeta^2)
[Phi,Theta,Alpha,P,Z,Kc,C]=CompensadorBisectriz_SigmaWdZeta(Gs,Sigma,Wd,Zeta,0)

%% 
clc
close all
%C=51.699*(s+3.892)/(s+16.12)
GsC=C*Gs;
rlocus(GsC)
Tc=feedback(GsC,1); %sistema controlado
Tk=feedback(Gs,1);
Su=feedback(C,Gs); %señal de control
ParametroSys(Tc,ProcentajeCriterioTs,CriterioRiso)
ErroEpEvEa(GsC)
subplot(121),step(Tc,Tk),legend
subplot(122),step(Su),legend

%% Bisectriz
%Sea G(s)=10/(s*(s+1))
%diseñar para Zeta=0.5 y Wn=3
%-----Analisis LO------------------
clc
s=tf('s');
 Gs=10/(s*(s+1));
ProcentajeCriterioTs=0.01;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
%step(Gs)
%% Calcular polos deseados y posicion
clc
Zeta=0.5; Wn=3;
%[C,P,Z,Kc,Phi]=CompensadorBisectriz(Gs,Wn,Zeta)
Sigma=Wn*Zeta
Wd=Wn*sqrt(1-Zeta^2)
[Phi,P,Z,Kc,C]=CompensadorBisectriz_SigmaWdZeta(Gs,Sigma,Wd,Zeta)
%% 
clc
close all
GsC=C*Gs;
rlocus(GsC)
GsCLc=feedback(GsC,1); %sistema controlado
GsLc=feedback(Gs,1);
Gc=feedback(C,Gs); %señal de control
ParametroSys(GsCLc,ProcentajeCriterioTs,CriterioRiso)
step(GsCLc,Gc)














%% Bisectriz
%Sea G(s)=2/((s+1)*(s+2))
%diseñar para  Mp<=20% ts<=2
%-----Analisis LO------------------
clc
s=tf('s');
 Gs=2/((s+1)*(s+2));
ProcentajeCriterioTs=0.02;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
%% Calcular polos deseados y posicion
clc
Mp=0.05; Ts=2
Zeta=-log(Mp)/(sqrt(pi^2+log(Mp)^2))
%tomo un zeta mayor por critierios del diseñador para tener menor sobrepico
Zeta=0.71
Sigma=4/Ts
Wn=4/(Zeta*Ts)
Wd=Wn*sqrt(1-Zeta^2)
[Phi,Theta,Alpha,P,Z,Kc,C]=CompensadorBisectriz_SigmaWdZeta(Gs,Sigma,Wd,Zeta)
%rlocus(Gs)
%% 
clc
close all
GsC=C*Gs;
rlocus(GsC)
GsCLc=feedback(GsC,1); %sistema controlado
GsLc=feedback(Gs,1);
Gc=feedback(C,Gs); %señal de control
ParametroSys(GsCLc,ProcentajeCriterioTs,CriterioRiso)
step(GsCLc,Gs)















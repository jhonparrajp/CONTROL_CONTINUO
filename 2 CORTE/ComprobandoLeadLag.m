%% Gs=(1+N/10)/((s+1)*(s+5))
%ts<=1; Wd>=2; Kv>=20; Wd>=2;
clc
clear
close all
N=4;
s=tf('s');
%Gs=(1+N/10)/((s+1)*(s+5)) %aplicamos un integrador para disminuir el error de posicion
Gs=4/(s*(s+0.5));
ProcentajeCriterioTs=0.02;
CriterioRiso=[0.10 0.90];
ParametroSys(feedback(Gs,1),ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
[Ep,Ev,Ea,Kp,Kv,Ka]=ErroEpEvEa(Gs);
Kv=1/Ev
% figure(1)
% step(feedback(Gs,1))
%figure(2)
%rlocus(Gs)

 % subplot(221),rlocus(Gs)
% subplot(223),nyquist(Gs)
% subplot(122),margin(Gs)

%% Calcular polos deseados y posicion
clc
close all
Zeta=0.5; Wn=5; Kvd=80;
Sigma=Zeta*Wn
Ts=4/Sigma
Wd=Wn*sqrt(1-Zeta^2)
%rlocus(Gs),sgrid(Zeta,0)
[Phi,C]=LeadLagLGR(Gs,Sigma,Wd,0,Kvd,0)
%% 
clc
close all
s=tf('s');
GsC=C*Gs;
Tc=feedback(GsC,1); %sistema controlado
Tk=feedback(Gs,1);
Su=feedback(C,Gs); %señal de control
figure(2)
subplot(121),step(Tc,Tk),legend
subplot(122),step(Su),legend
KvR=dcgain(s*GsC)
%subplot(133),margin(Tk)
% figure(3)
% rlocus(GsC)
%• overshoot in the response to a step input: P O ? <=20%;
%settling time for the response to a step input: Ts ? <=16 seconds.
clc
clear
close all
N=4;
s=tf('s');
Gs=0.375*(s + 0.8)/(s*(s + 0.2)*(s + 1)*(s + 1.5))
ProcentajeCriterioTs=0.02;
CriterioRiso=[0.10 0.90];
ParametroSys(feedback(Gs,1),ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) 
[Ep,Ev,Ea,Kp,Kv,Ka]=ErroEpEvEa(Gs);
Epa=Ep
% figure(1)
% step(feedback(Gs,1))
% figure(2)
% subplot(221),rlocus(Gs)
% subplot(223),nyquist(Gs)
% subplot(122),margin(Gs)
%% Calcular polos deseados y posicion
clc
close all
Ep=1; Mp=0.10; Ts=20;
Sigma=4/Ts
Wd=-Sigma*pi/(log(Mp))
Wn=sqrt(Sigma^2+Wd^2)
Zeta=Sigma/Wn % para disminuit Ts bajamos Ts a 0.5
%Zeta=0.5;
rlocus(Gs),sgrid(Zeta,0)
RestaK=0;
[Phi,Theta,Alpha,P,Z,Kc,C]=CompensadorBisectriz_SigmaWdZeta(Gs,Sigma,Wd,Zeta,RestaK)
%rltool(Gs)
%C=32.609*(s+4.6)/( (s+15))
%C= 700*(s+0.8)*(s+1)*(s+0.5)/(s*(s+4)*(s+10)*(s+30));
C= 6765.8*(s+0.3)*(s+0.8)*(s+1)/(s*(s+30)*(s+20)*(s+10))
%% 
C=1.5192*(s + 0.2)/(s + 0.6583)
clc
close all
s=tf('s')
GsC=C*Gs;
Tc=feedback(GsC,1); %sistema controlado
Tk=feedback(Gs,1);
Su=feedback(C,Gs); %señal de control
ParametroSys(Tc,ProcentajeCriterioTs,CriterioRiso)
ErroEpEvEa(GsC)
figure(2)
subplot(121),step(Tc,Tk),legend
subplot(122),step(Su),legend
%subplot(133),margin(Tk)
%figure(3)


function [C]=LagFrec(Gs,Mfd,Kpd,Kvd,Kad,teta)

%--------------Como usar-----------------------------
%[C]=LeadLagLGR(Gs,Sigma,Wd,Kpd,Kvd,Kad,RestaK)
%Gs=Funcion de transferencia en lazo abiero
%Mfd=Margen de fase deseado
%Kpd=Constante de error de posicion deseada
%Kvd=Constante de error de velocidad deseada
%Kad=constante de error de aceleracion deseada
%C=Controlador resultante
%-----Ecuaciones------------------------------
%para sistema de segundo orden en LO
%Mp%=1.6(60-Mfd) Mfd maximo 60
%Mfd=100*Zeta   
%
%Ejemplo:
% s=tf('s');
% Gs=1/(s*(s+1)*(s +4));
% Kvd=10;
% Mfd=50;
% Mgd=10;
% teta=5;
% [C]=LeadLagFrec(Gs,Mfd,0,Kvd,0,teta)
% close all
% L=Gs*C;
% T=feedback(Gs,1); %sistema sin compensar
% Tc=feedback(L,1); %sistema Compensado
% Su=feedback(C,Gs); %señal de control
% 
% figure(2)
% bode(L,Gs),legend
% figure(3)
% subplot(1,2,1),step(Tc,T),legend
% subplot(1,2,2),step(Su),legend
% [MgR,MfR]=margin(L);
% MgR=20*log10(MgR) %margen de ganancia 
% MfR=MfR;          %margen de fase
% KvR=dcgain(s*L)   %constante de error de velocidad
% EvR=1/KvR         %Error de velocidad



s=tf('s');
if (Kpd>0) 
Kac=dcgain(Gs);
Kd=Kpd;
elseif(Kvd>0)
Kac=dcgain(s*Gs);
Kd=Kvd;
elseif(Kad>0) 
Kac=dcgain(s^2*Gs);
Kd=Kad;
end 
K=Kd/Kac %K necesario para llegar al Kv deseado
Gs1=K*Gs
MaxAFase=-180+Mfd+teta
t=sprintf('Buscar el valor de frecuencia(rad/s) en el punto %.2f° en la grafica defase',MaxAFase);
t2=sprintf('Ingrese el valor de frecuencia(rad/s) en el punto %.2f° de la grafica de fase:  ',MaxAFase);
close all
bode(Gs1),title(t);
Wm=input(t2);
Z=0.1*Wm
T=1/Z;
t3=sprintf('Buscar la magnitud(dB) en el punto %.3f(rad/f) en la grafica de Magnitud',Wm);
t4=sprintf('Ingresar la magnitud(dB) en el punto %.3f(rad/f) de la grafica de Magnitud: ',Wm);
close all
bode(Gs1),title(t4);
MGjw=input(t4);
Beta=10^(MGjw/20)
P=1/(Beta*T);
Kc=K/Beta;
C=zpk(-Z,-P,Kc)

%% Gs=1.667/((s+1.667)*(s+4)); 
%Ev<5% Mf>40 Mg>10dB
close all
clc
clear
Evd=0.05;
Mfd=40;
s=tf('s');
%se aplica un polo en cero para que tenga sentido el Ev
Gs=zpk([],[-1.667 -4 0],1.667) %zpk(P,Z,K)
Kvd=1/Evd %Kv deseado
Kva=dcgain(s*Gs) %calculo Kv actual del sistema
K=Kvd/Kva %K necesario para llegar al Kv deseado
Gs1=K*Gs
[C]=LeadLagFrec(Gs,Kvd,Mfd,5)
%% 
%Parametro de calibracion
teta=5; % entre 5 a 12 angulo d ajuste
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
%% Validacion del compensador
close all
clc
L=Gs*C;
T=feedback(Gs,1);
Tc=feedback(L,1);
Su=feedback(C,Gs);

figure(2)
bode(L,Gs),legend
figure(3)
subplot(1,2,1),step(Tc,T),legend
subplot(1,2,2),step(Su),legend

[MgR,MfR]=margin(L)
KvR=dcgain(s*L)
EvR=1/KvR











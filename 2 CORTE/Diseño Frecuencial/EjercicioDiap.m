%% Gs=10/(s*(s+1)); 
%Ev<5% Mf>50 Mg>10dB
close all
clc
clear
Evd=0.05;
Mfd=50;
s=tf('s');
Gs=zpk([],[0 -1],10) %zpk(P,Z,K)
Kvd=1/Evd %Kv deseado
Kva=dcgain(s*Gs) %calculo Kv actual del sistema
K=Kvd/Kva %K necesario para llegar al Kv deseado
Gs1=K*Gs
[Mgc,Mfc]=margin(Gs1)
%Parametro de calibracion
teta=18; % entre 5 a 12 angulo d ajuste
MfAdicional=Mfd-Mfc+teta; 
Alfa=(1-sin(deg2rad(MfAdicional)))/(1+sin(deg2rad(MfAdicional))); %valor de atenuacion
MgABuscar=-20*log(1/sqrt(Alfa)); %ganacia a buscar en el diagram de bode
t=sprintf('Buscar el valor de frecuencia(rad/s) en el punto %.2f dB en la grafica de Magnitud',MgABuscar);
t2=sprintf('Ingresar el valor de frecuencia encontrado en el punto %.2f dB de la grafica de Magnitud: ',MgABuscar);
close all
bode(Gs1),title(t);
Wm=input(t2);
T=1/(Wm*sqrt(Alfa));
Z=1/T;
P=1/(Alfa*T);
Kc=K/Alfa;
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
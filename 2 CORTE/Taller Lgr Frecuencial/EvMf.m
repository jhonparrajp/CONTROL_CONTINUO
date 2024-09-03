
clc
clear
close all
s=tf('s');
%Gs=150/(s*(s+5)*(0.5*s+10));
%Gs=(400)/(s*(0.1*s^2+5.2*s+10)) %Ev<=35seg-1 Mf>45
Gs=(2)/(s*(s+1)*(s+2))
Kvd=5;
Mfd=40;
[C]=LeadLagFrecu(Gs,Mfd,0,Kvd,0,7)
%% 
close all
L=Gs*C;
T=feedback(Gs,1);
Tc=feedback(L,1);
Su=feedback(C,Gs);

figure(2)
bode(L,Gs),legend
figure(3)
subplot(1,2,1),step(Tc,T),legend
subplot(1,2,2),step(Su),legend

%[MgR,MfR]=margin(L)
%MgR=20*log10(MgR)
%MfR=MfR
figure(4)
subplot(1,2,1),margin(L),legend
subplot(1,2,2),bode(L,Gs),legend


KvR=dcgain(s*L)
EvR=1/KvR


Kaa=dcgain(s*Gs)
Eaa=1/Kaa
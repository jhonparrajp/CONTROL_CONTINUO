clc
clear
close all
s=tf('s');
Gs=50/(s*(s+5)*(s+10));
Kvd=1/0.14;
Mfd=60;
Mgd=12; %dB
[C]=LeadLagFrec(Gs,Mfd,0,Kvd,0,5,1)
%% 
close all
%C=0.0073614*(s+0.0118)/(s+0.000152)
C=1.9089*(s+0.145)/(s+0.031)
L=Gs*C;
T=feedback(Gs,1);
Tc=feedback(L,1);
Su=feedback(C,Gs);


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
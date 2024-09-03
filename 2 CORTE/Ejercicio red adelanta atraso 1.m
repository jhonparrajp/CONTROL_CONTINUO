
clc
clear
close all
s=tf('s');
Gs=150/(s*(s+5)*(0.5*s+10));
Ev=0.10
Kvd=1/Ev;
Mfd=60;
[C]=LeadLagFrec(Gs,Mfd,0,Kvd,0,5,1)
%%
close all
%C=0.6107*(s+0.177)/(s+0.0331)
L=Gs*C;
T=feedback(Gs,1);
Tc=feedback(L,1);
Su=feedback(C,Gs);

figure(2)
bode(L,Gs),legend
figure(3)
subplot(1,2,1),step(Tc,T),legend
subplot(1,2,2),step(Su),legend

[MgR,MfR]=margin(L);
MgR=20*log10(MgR)
MfR=MfR

KaR=dcgain(s*L)
EaR=1/KaR


Kaa=dcgain(s*Gs)
Eaa=1/Kaa

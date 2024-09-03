%% %% Gs=(1+N/10)/((s+1)*(s+5))
%Mp<=10%; Ev=0; Ea<10%;
clc
clear
close all
s=tf('s');
Gs=2800/(s^4+184*s^3+760*s^2+162*s);
Ep=0
Kvp=1/Ep;
Mfd=55;
Mdg=15 %dB
[C]=LeadLagFrec(Gs,Mfd,0,1,0,5,1)
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
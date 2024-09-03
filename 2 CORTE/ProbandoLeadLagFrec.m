clc
clear
s=tf('s');
Gs=1/(s*(s+1)*(s +4));
Kvd=10;
Mfd=55;
Mgd=10;
teta=10;
[C]=LeadLagFrec(Gs,Mfd,0,Kvd,0,teta)

%%
close all
%C=zpk([-0.7 -0.15],[-7 -0.015],20)
%
%C=(s+0.4899)*(s+0.042)/((s+0.7033)*(s+0.001964))
%C= 2.8956*(s+0.5669)*(s+0.0526)/((s+0.689)*(s+0.003133));
%C=164.02*(s+2.238)*(s+0.0967)/((s+72.07)*(s+0.01231)) %adelanto atraso
%C=2.8913*(s+0.5665)*(s+0.0522)/((s+0.6874)*(s+0.003109))
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

KvR=dcgain(s*L)
EvR=1/KvR


Kva=dcgain(s*Gs)
Eva=1/Kva


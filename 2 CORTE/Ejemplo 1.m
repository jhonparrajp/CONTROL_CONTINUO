%% 
%Sea G(s)=1/((s+1)*(s+3))
%diseñar para Mp<=20, Ep<=20, Tr>1s
%-----Analisis LO------------------
s=tf('s');
 Gs=1/((s+1)*(s+3))
ProcentajeCriterioTs=0.01;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso)
%% -----Analisis LC------------------
close all
%Analisis de estabilidad
%Coef=[1 5 11 23 28 12]; % sym2poly(p)
%[salida,ValoresK,pantalla,cortes]=criterioRouth(Coef)
figure(2)
rlocus(Gs)
figure(3)
bode(Gs)
figure(4)
nyquist(Gs)
%% Calculo de Error
syms s
Gss=tf2sym(Gs);
Kp=Gss;
Kv=s*Gss;
Ka=s^2*Gss;
s=0;
Ep=eval(1/(1+Kp))
Ev=eval(1/(Kv))
Ea=eval(1/(Ka))
%% Parametros en LC
close all
GsLc=feedback(Gs,1)
ProcentajeCriterioTs=0.01;
CriterioRiso=[0.10 0.90];
ParametroSys(GsLc,ProcentajeCriterioTs,CriterioRiso)
%% Parametros deseados
close all
Mp=0.2; Tr=1; Ep=0.2;
Zeta=-log(Mp)/(sqrt(pi^2+log(Mp)^2))
figure(2)
rlocus(Gs)
%segun la grafica para que MP<=20% K<16
ks=16;
sgrid(Zeta,0)
syms s k
Gss=k*tf2sym(Gs);
Kp=Gss;
s=0;
ErrorP=eval(1/(1+Kp))==Ep
ki=double(solve(ErrorP,k))
sprintf(' Para MP<=0.2 y Ep<=0.2 %.3f>k>%.3f ',ks,ki)

%% Comprobando diseño
k=13
Gsp=k*Gs
GspLc=feedback(Gsp,1)
Su=minreal(feedback(k,Gs))
[Ts,Tr,Mp,Tp,Taho,ValorF]=ParametroSys(GspLc,0.01,[0.10 0.90]);
Ep=1-ValorF
step(GspLc,Su)



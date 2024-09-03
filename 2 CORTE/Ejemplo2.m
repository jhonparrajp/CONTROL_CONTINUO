%% 
%Sea G(s)=1/(s*(s+2))
%diseñar para Zeta=0.5, Wn=4,
%-----Analisis LO------------------
s=tf('s');
 Gs=4/(s*(s+2))
ProcentajeCriterioTs=0.01;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
step(Gs)
%% 
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
%% Convierto especificaciones a Region de diseño
%parametros deseados
Zeta=0.5; Wn=4;
Sigma=Zeta*Wn; 
Wd=Wn*sqrt(1-Zeta^2);
rlocus(Gs)
sgrid(Zeta,0)
%al tener los polos deseados fuera de la zona de diseño se aplica un
%compensador
syms s
Pisicion=5
Z=Sigma
P=Sigma+Pisicion;
C=(s+Z)/(s+P)
Gss=tf2sym(Gs);
s=-Sigma+i*Wd 
%calculo de Kc Remplazamos los polos deseamos y obtenemos la magnitud
Kc=abs(eval(1/(Gss*C)))
s=tf('s');
C=Kc*(s+Z)/(s+P)
%% Comprobando controlador
%los parametros esperados deben ser mayores o menores pero siempre deben
%ser mejores
GsC=C*Gs;
GsCLc=feedback(GsC,1);
GsLc=feedback(Gs,1);
ParametroSys(GsLc,ProcentajeCriterioTs,CriterioRiso)
ParametroSys(GsCLc,ProcentajeCriterioTs,CriterioRiso)
step(GsCLc,GsLc)










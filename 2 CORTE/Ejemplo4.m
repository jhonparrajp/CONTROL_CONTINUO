%% 
%Sea G(s)=1/(s*(s+1)*(s+4))
%diseñar para Mp=0.05, Ts<=3, Ep=0, Tr lo mas rapido posible
%-----Analisis LO------------------
s=tf('s');
 Gs=2/(s*(s+1)*(s+4))
ProcentajeCriterioTs=0.01;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
step(Gs)
%% Convierto especificaciones a Region de diseño
%parametros deseados
clc
close all
Mp=0.05; Ts=3;
Zeta=-log(Mp)/sqrt(pi^2+log(Mp)^2);
Sigma=4.6/Ts
Wn=Sigma/Zeta;
Wd=Wn*sqrt(1-Zeta^2)
rlocus(Gs)
sgrid(Zeta,0);
axis([-2*Wn .1 -1.5*Wd 1.5*Wd]);

%al tener los polos deseados fuera de la zona de diseño se aplica un
%compensador
syms s
Z=Sigma-0.53 % para este caso movemos un poco mas el Zero a la derecha para atraer el LGR
P=Sigma+7  %aumentar de 5 a 10 cuando no se lleguen a las especificaciones, pero tener en cuenta que no suba tanto la señal de control
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
clc
close all
GsC=C*Gs;
rlocus(GsC)
GsCLc=feedback(GsC,1); %sistema controlado
GsLc=feedback(Gs,1);
Gc=feedback(C,Gs); %señal de control
ParametroSys(GsCLc,ProcentajeCriterioTs,CriterioRiso)
step(GsCLc,Gc)


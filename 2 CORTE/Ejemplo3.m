%% 
%Sea G(s)=1/(s^2)
%diseñar para Zeta=0.5, Wn=4,
%-----Analisis LO------------------
s=tf('s');
 Gs=1/(s^2)
ProcentajeCriterioTs=0.01;
CriterioRiso=[0.10 0.90];
ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso) %el sistema es inestable en LO no se analiza mas nada
step(Gs)
%% Convierto especificaciones a Region de diseño
%parametros deseados
Mp=0.35; Ts=4;
Zeta=-log(Mp)/sqrt(pi^2+log(Mp)^2);
%al obtener un valor de zeta tan bajo lo podemos aumentar para tener un
%mejor diseño
Zeta=0.45;
Sigma=4.6/Ts;
Wn=Sigma/Zeta;
Wd=Wn*sqrt(1-Zeta^2);
rlocus(Gs)
sgrid(Zeta,0)
axis([-2*Wn .1 -1.5*Wd 1.5*Wd])
%al tener los polos deseados fuera de la zona de diseño se aplica un
%compensador
syms s
Pisicion=7 %aumentar max hasta 10 cuando no se lleguen a las especificaciones, pero tener en cuenta que no suba tanto la señal de control
Z=Sigma;
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
GsCLc=feedback(GsC,1); %sistema controlado
GsLc=feedback(Gs,1);
Gc=feedback(C,Gs); %señal de control
ParametroSys(GsLc,ProcentajeCriterioTs,CriterioRiso)
ParametroSys(GsCLc,ProcentajeCriterioTs,CriterioRiso)
step(GsCLc,Gc)



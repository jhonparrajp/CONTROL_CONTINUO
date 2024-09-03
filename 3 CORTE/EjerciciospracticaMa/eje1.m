s=tf('s');
G=(2*exp(-.2*s))/(s*(s+4))
G=pade(G);
%G=(-2*s+20)/(s^3+14*s^2+40*s)
3
%polo según especificaciones
Kc=place(Ge.A,Ge.B,[-8 -5 -10])
%t=0:0.01:3;
Ge_c= ss(Ge.A-Ge.B*Kc,Ge.B,Ge.C,0);
F=1/dcgain(Ge_c)
Tc=F*Ge_c;
figure();
step(Tk,Tc),legend
Polos=pole(Tc)
%Matrix Ampliada para PI vectorial
Aa=[Ge.A,[0;0;0];-Ge.C,0];
Ba=[Ge.B;0];
Ca= [Ge.C 0];
P=[-8 -5 -10]';
Pa=[P; -16]
Ka=place(Aa,Ba,Pa);
K=Ka(1:end-1)  
ki=-Ka(end)
Ge_ci= ss(Ge.A-Ge.B*K,Ge.B,Ge.C,0);
Tci=feedback(Ge_ci*ki/s,1);
figure();
step(Tk,Tci),legend
%Mo=obsv(Ge.A,Ge.C)
%Diseño de observador
mp=0.05;
ts=.4; %tres vaces mas rapido que la estabilidad del sistema controlado
zeta=-log(mp)/(sqrt(pi^2+log(mp)^2));
Wn=4/(zeta*ts);
sigma=zeta*Wn;
wd=Wn*sqrt(1-zeta^2);
sx=-sigma+wd*i;
alpha=4;
Po=[sx sx' alpha*Wn];
L=acker(Ge.A',Ge.C',Po)'
%Validaciones
load('med1.mat')
t1=out.Pobs.time(:);
u1=out.Pobs.signals(:).values(:,1);
y1=out.Pobs.signals(:).values(:,2);
q1=lsim(Tc,u1,t1);
%q2=lsim(G2,u1,t1);
figure();
plot(t1,[u1 y1],t1,q1,'-.'),legend('Entrada','R con observador','R con vector de ganancias'),title('Original')
%Validacion Pi
load('med1.mat')
t1=out.Piv.time(:);
u1=out.Piv.signals(:).values(:,1);
y1=out.Piv.signals(:).values(:,2);
q1=lsim(Tci,u1,t1);
%q2=lsim(G2,u1,t1);
figure();
plot(t1,[u1 y1],t1,q1,'-.'),legend('Entrada','R con observador','R con vector de ganancias'),title('Original')
%%
GA=1.61/(0.4208*s + 1);
GB=2.207/(0.5646 *s + 1);
GA=minreal(GA);
GB=minreal(GB);
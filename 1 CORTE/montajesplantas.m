    %clear all, clc
%% adquisicion de datos
% s=tf('s');
% t=P2.times %UY es el nombre de la estructura puesta en el scope
% y=P2.signals(1).values(:);
% y2=P2.signals(2).values(:);
%% parte A primer orden.
 s=tf('s');
 R1=10e06; RB=50e03;RA=50e03; C1=1e-06;% valores de los componentes.
 k1=(RB+RA)/RB; t1=R1*C1;
 G=(k1/(t1*s+1))
%% circuito 2 sobreamortiguado.
% s=tf('s');    
% Ra=606060; r_1=50e03;R2=50e03; CA=0.825e-06;
% Rb=130208;CB=0.768e-06; R3=1;R4=0; 
% k2=(r_1+R2)/r_1; t2=Ra*CA;
% k3=(R3+R4)/R3; t3=Rb*CB;
% G1=(k2/(t2*s+1))*(k3/(t3*s+1))
%% circuito 3 subamortiuado.
% s=tf('s');
% r=200e03; r1=10e03;r2=10e03;C=0.000001;
% k5=1+(r2/r1);
% cita=(2-(r2/r1))/(2);
% wn=1/(r*C);
% G2=k5*((wn^2)/(s^2+2*cita*wn*s+wn^2))
%% adqusicion 
s=tf('s');
t=p1.time;
y=p1.signals(1).values(:);
c=p1.signals(2).values(:);
u=p1.signals(3).values(:);
% e=p1.signals(4).values(:);
% c=p1.signals(5).values(:);
tm=t(11)-t(10);
plot(t,[u,y]),legend('Entrada','x1')

% ini=1;
% t=t(ini/tm:end);
% x1=x1(ini/tm:end);
% x2=x2(ini/tm:end);
% u=u(ini/tm:end);
% t=t-min(t);
% x1=x1-min(x1);
% x2=x2-min(x2);
% u=u-min(u);
% x1=x1;
% plot(t,[u,x1]),legend('Referencia','x1','x2'),xlim([0 max(t)])
%% prueba profe 
% t=p1.time;
% y=p1.signals(1).values(:);
% r=p1.signals(3).values(:);
% u=p1.signals(5).values(:);
% tm=t(11)-t(10);
% plot(t,[u,y]),legend('r','y')
% q=lsim(Tc,r,t);
% plot(t,[u,y],t,q,'-.'),legend('r','y','q')

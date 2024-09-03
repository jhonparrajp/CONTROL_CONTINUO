function [C,Kp,Ti,Td]=CohenCoon(Tao,t0,K,Na,Tipo)


% Modelo de la planta: primer orden más tiempo
% muerto
% ? Identificación del modelo: método que provea la
% mejor aproximación
% ? Funcionamiento del controlador: perturbación
% ? Criterio de desempeño: decaimiento de un cuarto,
% sobrepaso mínimo, mínima área bajo la curva de
% respuesta
% ? Controlador PID: ideal
%Tipo: 
%'P' controlador proporcional
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');

if(strcmp(Tipo,'P'))
  
Kp=Tao/(K*t0)*(1+t0/(3*Tao));
Ti=inf;
Td=0;

%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))
Kp=Tao/(K*t0)*(9/10+t0/(12*Tao));
Ti=t0*((30+3*t0/Tao)/(9+20*t0/Tao));
Td=0;

%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))  
Kp=Tao/(K*t0)*(4/3+t0/(4*Tao));
Ti=t0*((32+6*t0/Tao)/(13+8*t0/Tao));
Td=t0*(4/(11+2*t0/Tao));
end

C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

function [C,Kp,Ti,Td]=ZieglerNicholsRP(Tao,t0,K,Na,Tipo)

%ZieglerNichols Respuesta al paso
% ? Modelo de la planta: primer orden más tiempo
% muerto
% ? Identificación del modelo: método de la
% tangente (práctico)
% ? Funcionamiento del controlador: perturbaciones
% ? Criterio de desempeño: decaimiento de un cuarto

%Tipo: 
%'P' controlador proporcional
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%criterio:
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');
if(strcmp(Tipo,'P'))

Kp=Tao/(K*t0);
Ti=inf;
Td=0;

%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))    
Kp=0.9*Tao/(K*t0);
Ti=3.33*t0
Td=0;


%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))    
Kp=1.2*Tao/(K*t0);
Ti=2*t0
Td=0.5*t0;
end

C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

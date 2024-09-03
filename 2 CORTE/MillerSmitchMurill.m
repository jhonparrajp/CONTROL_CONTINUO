function [C,Kp,Ti,Td]=MillerSmitchMurill(Tao,t0,K,Na,Tipo)

% ? Modelo de la planta: primer orden más tiempo
% muerto
% ? Identificación del modelo: método que provea la
% mejor aproximación
% ? Funcionamiento del controlador: perturbación
% ? Criterio de desempeño: depende del controlador
% empleado
% ? Controlador PID: ideal


%Tipo: 
%'P' controlador proporcional
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');

if(strcmp(Tipo,'P'))
  
Kp=1.208/K*(t0/Tao)^(-0.956);
Ti=inf;
Td=0;

%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))
Kp=0.928/K*(t0/Tao)^(-0.946);
Ti=0.928*Tao*(t0/Tao)^(0.583);
Td=0;

%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))  
Kp=1.370/K*(t0/Tao)^(-0.95);
Ti=0.740*Tao*(t0/Tao)^(0.783);
Td=0.365*Tao*(t0/Tao)^(0.95);
end

C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

function [C,Kp,Ti,Td]=ZieglerNicholsFre(Pcr,Kcr,Na,Tipo)

% ZieglerNichols Metodo frecuencuencial
% ? Información del sistema: Kcr y Tcr
% ? Funcionamiento del controlador:
% perturbaciones
% ? Criterio de desempeño: decaimiento de un
% cuarto
% ? Controlador PID: ideal (ZN utilizaron
% controladores neumáticos con cierta
% interacción)

% [Kcr,~,Wcr,~]=margin(Gs);
% Pcr=2*pi/Wcr;
%Tipo: 
%'P' controlador proporcional
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%criterio:
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');
if(strcmp(Tipo,'P'))

Kp=0.5*Kcr;
Ti=inf;
Td=0;

%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))    
Kp=0.45*Kcr;
Ti=Pcr/1.2;
Td=0;


%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))    
Kp=0.6*Kcr;
Ti=Pcr*0.5;
Td=Pcr/8;
end

C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

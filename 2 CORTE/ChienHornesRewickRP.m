function [C,Kp,Ti,Td]=ChienHornesRewickRP(Tao,t0,K,Na,Tipo,Mp,Funcionamiento)


% ? Modelo de la planta: primer orden más tiempo
% muerto
% ? Identificación del modelo: método de la
% tangente
% ? Funcionamiento del controlador: perturbación o
% referencia
% ? Criterio de desempeño: la respuesta más rápida
% sin sobrepaso o la respuesta más rápida con un
% 20% de sobrepaso máximo
% ? Controlador PID: ideal

%Tipo: 
%'P' controlador proporcional
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%criterio:
%Funcionamiento 'P' perturbacion
%               'R' referencia
%Mp: 20% o 0%
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');
if(strcmp(Funcionamiento,'P'))
if(strcmp(Tipo,'P'))
if(Mp==20)    
Kp=0.7*Tao/(K*t0);
Ti=inf;
Td=0;
elseif(Mp==0)
Kp=0.3*Tao/(K*t0);
Ti=inf;
Td=0;
end
%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))
  
if(Mp==20)   
Kp=0.7*Tao/(K*t0);
Ti=2.3*t0;
Td=0;
elseif(Mp==0)
Kp=0.6*Tao/(K*t0);
Ti=4*t0;
Td=0;
end
%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))
if(Mp==20)    
Kp=1.2*Tao/(K*t0);
Ti=2*t0;
Td=0.42*t0;
elseif(Mp==0)
Kp=0.95*Tao/(K*t0);
Ti=2.4*t0;
Td=0.42*t0;
end
end

%-----------Referencia-----------------------------------


elseif(strcmp(Funcionamiento,'R'))
if(strcmp(Tipo,'P'))
if(Mp==20)    
Kp=0.7*Tao/(K*t0);
Ti=inf;
Td=0;
elseif(Mp==0)
Kp=0.3*Tao/(K*t0);
Ti=inf;
Td=0;
end
%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))
  
if(Mp==20)   
Kp=0.6*Tao/(K*t0);
Ti=t0;
Td=0;
elseif(Mp==0)
Kp=0.35*Tao/(K*t0);
Ti=1.2*t0;
Td=0;
end
%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))
if(Mp==20)    
Kp=0.95*Tao/(K*t0);
Ti=1.4*t0;
Td=0.47*t0;
elseif(Mp==0)
Kp=0.6*Tao/(K*t0);
Ti=t0;
Td=0.5*t0;
end
end    
end


C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

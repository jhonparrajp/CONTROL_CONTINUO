function [C,Kp,Ti,Td]=RoviraMurillSmith(Tao,t0,K,Na,Tipo,criterio)
%Para seguimiento de referencia
%Tipo: 
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%criterio:
%'IAE' Minimizacion del valor absoluto del error
%'ITAE' Minimizacion del valor absoluto del error multiplicado por el
%timepo
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');
%----------------PI---------------------------------
if(strcmp(Tipo,'PI'))
if(strcmp(criterio,'IAE'))
   ak=0.758; bk=-0.861;
   ai=1.02; bi=-0.323;  
elseif(strcmp(criterio,'ITAE'))
   ak=0.586; bk=-0.916; 
   ai=1.03; bi=-0.165;   
end 
    
Kp=(ak/K)*(t0/Tao)^bk;
Ti=Tao/(ai+bi*(t0/Tao));
Td=0;


%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))
if(strcmp(criterio,'IAE'))
   ak=1.086; bk=-0.869; 
   ai=0.740; bi=-0.130;
   ad=0.348; bd=0.914;
elseif(strcmp(criterio,'ITAE'))
   ak=0.965; bk=-0.85;
   ai=0.796; bi=-0.146;
   ad=0.308; bd=0.929;
end 
    
Kp=(ak/K)*(t0/Tao)^bk;
Ti=Tao/(ai+bi*(t0/Tao));
Td=ad*Tao*(t0/Tao)^bd;
end

C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

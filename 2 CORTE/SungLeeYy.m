function [C,Kp,Ti,Td]=SungLeeYy(Tao,t0,K,Zeta,Na,Tipo,Funcionamiento)
% ? Características:
% ? Modelo de la planta: segundo orden más tiempo
% muerto
% ? Identificación del modelo: método que provea la
% mejor aproximación
% ? Funcionamiento del controlador: referencia y
% perturbaciones
% ? Criterio de desempeño: criterios integrales IAE e
% ITAE
% ? Controlador PID: Ideal


%Tipo: 
%'P' controlador proporcional
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%criterio:
%Funcionamiento 'P' perturbacion
%               'R' referencia
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');
if(strcmp(Funcionamiento,'P'))
if(strcmp(Tipo,'P'))
    
if((t0/Tao)<0.9)    
Kp=1/K*(-0.67+0.297*(t0/Tao)^-2.001+(2.189*(t0/Tao)^(-0.766))*Zeta);
Ti=inf;
Td=0;
elseif((t0/Tao)>=0.9)
Kp=1/K*(-0.365+0.26*(t0/Tao-1.4)^2+(2.189*(t0/Tao)^(-0.766))*Zeta);
Ti=inf;
Td=0;
end

%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))
  
if((t0/Tao)<0.9)    
Kp=1/K*(-0.67+0.297*(t0/Tao)^-2.001+(2.189*(t0/Tao)^(-0.766))*Zeta);
Td=0;
elseif((t0/Tao)>=0.9)
Kp=1/K*(-0.365+0.26*(t0/Tao-1.4)^2+(2.189*(t0/Tao)^(-0.766))*Zeta);
Td=0;
end

if((t0/Tao)<0.4)    
Ti=Tao*(2.212*(t0/Tao)^(0.52) -0.3);
elseif((t0/Tao)>=0.4)
Ti=Tao(-0.975+0.91*(t0/Tao-1.845)^2+(1-exp(-Zeta/(0.15+0.33*t0/Tao)))*(5.25-0.88*(t0/Tao-2.8)^2));
end
%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))

if((t0/Tao)<0.9)    
Kp=1/K*(-0.67+0.297*(t0/Tao)^-2.001+(2.189*(t0/Tao)^(-0.766))*Zeta);

elseif((t0/Tao)>=0.9)
Kp=1/K*(-0.365+0.26*(t0/Tao-1.4)^2+(2.189*(t0/Tao)^(-0.766))*Zeta);

end

if((t0/Tao)<0.4)    
Ti=Tao*(2.212*(t0/Tao)^(0.52) -0.3);
elseif((t0/Tao)>=0.4)
Ti=Tao(-0.975+0.91*(t0/Tao-1.845)^2+(1-exp(-Zeta/(0.15+0.33*t0/Tao)))*(5.25-0.88*(t0/Tao-2.8)^2));
end 
    
Td=Tao/(-1.9+1.576*(t0/tao)^-0.53+(1-exp(-Zeta/(-0.15+0.939*(t0/Tao)^-1.121)))*(1.45+0.969*(t0/Tao)^-1.171))    
    
end

%-----------Referencia-----------------------------------


elseif(strcmp(Funcionamiento,'R'))
if(strcmp(Tipo,'P'))
if(Zeta<=0.9)    
Kp=1/K*(-0.04+(0.333+0.949*(t0/Tao)^(-0.983))*Zeta);
Ti=inf;
Td=0;
elseif(Zeta>0.9)
Kp=1/K*(-0.544+0.308*(t0/Tao)+(1.408*(t0/Tao)^(-0.832))*Zeta);
Ti=inf;
Td=0;
end

%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))
if(Zeta<=0.9)    
Kp=1/K*(-0.04+(0.333+0.949*(t0/Tao)^(-0.983))*Zeta);
Td=0;
elseif(Zeta>0.9)
Kp=1/K*(-0.544+0.308*(t0/Tao)+(1.408*(t0/Tao)^(-0.832))*Zeta);
Td=0;
end

if((t0/Tao)<=1)    
Ti=Tao*(2.055+0.072*(t0/Tao))*Zeta;
elseif((t0/Tao)>1)
Ti=Tao*(1.768+0.329*(t0/Tao))*Zeta;
end
%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))
if(Zeta<=0.9)    
Kp=1/K*(-0.04+(0.333+0.949*(t0/Tao)^(-0.983))*Zeta);
elseif(Zeta>0.9)
Kp=1/K*(-0.544+0.308*(t0/Tao)+(1.408*(t0/Tao)^(-0.832))*Zeta);
end

if((t0/Tao)<=1)    
Ti=Tao*(2.055+0.072*(t0/Tao))*Zeta;
elseif((t0/Tao)>1)
Ti=Tao*(1.768+0.329*(t0/Tao))*Zeta;
end
Td=Tao/((1-exp((-(t0/Tao)^1.060)*Zeta/0.870))*(0.55+1.683*(t0/Tao)^-1.09))
end    
end


C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

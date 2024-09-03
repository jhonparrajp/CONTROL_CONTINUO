function [C,Kp,Ti,Td]=LopezMurrilSmitch(Tao,t0,K,Na,Tipo,criterio)
%Tipo: 
%'P' controlador proporcional
%'PI' controlador proporcional e integral
%'PID' controlador proporcional e integral y derivativo
%criterio:
%'ISE' Minimizacion cuadrada del error
%'IAE' Minimizacion del valor absoluto del error
%'ITAE' Minimizacion del valor absoluto del error multiplicado por el
%timepo
%Na: de 5 a 20 alejar el polo de compensacion 
%C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

s=tf('s');
if(strcmp(Tipo,'P'))
if(strcmp(criterio,'ISE'))
   a=1.411; b=-0.917;   
elseif(strcmp(criterio,'IAE'))
   a=0.9023; b=-0.985; 
elseif(strcmp(criterio,'ITAE'))
   a=0.4897; b=-1.085; 
end 
    
Kp=(a/K)*(t0/Tao)^b;
Ti=inf;
Td=0;


%----------------PI---------------------------------
elseif(strcmp(Tipo,'PI'))
if(strcmp(criterio,'ISE'))
   ak=1.305; bk=-0.96;
   ai=0.492; bi=-0.739;  
elseif(strcmp(criterio,'IAE'))
   ak=0.984; bk=-0.986; 
   ai=0.608; bi=-0.707;  
elseif(strcmp(criterio,'ITAE'))
   ak=0.859; bk=-0.977;
   ai=0.674; bi=-0.68;  
end 
    
Kp=(ak/K)*(t0/Tao)^bk;
Ti=(Tao/ai)*(t0/Tao)^bi;
Td=0;


%----------------PID---------------------------------
elseif(strcmp(Tipo,'PID'))
if(strcmp(criterio,'ISE'))
   ak=1.495; bk=-0.945;
   ai=1.101; bi=-0.771;  
   ad=0.56; bd=1.006;  
elseif(strcmp(criterio,'IAE'))
   ak=1.435; bk=-0.921; 
   ai=0.878; bi=-0.749;
   ad=0.482; bd=1.137;
elseif(strcmp(criterio,'ITAE'))
   ak=1.357; bk=-0.947;
   ai=0.842; bi=-0.738;
   ad=0.381; bd=0.995;
end 
    
Kp=(ak/K)*(t0/Tao)^bk;
Ti=(Tao/ai)*(t0/Tao)^bi;
Td=ad*Tao*(t0/Tao)^bd;
end

C=Kp*(1+1/(Ti*s)+Td*s/(Td*s/Na+1));

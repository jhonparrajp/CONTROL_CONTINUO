function [K,F,A,B,C,D]=LocationPoleEE(Gs,Mp,Ts,Order,Pd)
%Gs= funcion de transferencia
%Mp= maximo pico en Mp%/100
%Ts= tiempo de establecimiento el criterio Cts esta al 1%
%Order= Orden del sistema, si el sistema tiene polo=0 y ceros se debe
%tratar como un sistema de 2do orden
%
%Pd=polos deaseados deben ser la misma cantidad de los polos del sistema,
%   en caso de ser un sistema con ceros o un polo=0 se trata como un orden
%   2 y Pd se le asigna el valro del 3er polo, que sea igual al cero del
%   sistema 
%TODOS LOS POLOS DEBEN SER DIFERENTES
%
%K=vector de ganancia del controlador

%Ejemplo orden 3 apartir de requisitos
% s=tf('s');
% Gs=1/(s^3+5*s^2+3*s+2)
% Mp=0.046; Ts=1;
% [K,A,B]=LocationPoleEE(Gs,Mp,Ts,3,0)

%Ejemplo orden 3 apartir de  polos deseados
% s=tf('s');
% Gs=1/(s^3+5*s^2+3*s+2)
% Mp=0.046; Ts=1; %los paramtros solo deben ser diferente a cero
%pero el sistema tomara el comportamiento de los polos deseados
% Pd2=[-5 - 3.0565i  -5 + 3.0565i  -5 + 0.0000i]
% [K,A,B]=LocationPoleEE(Gs,Mp,Ts,3,Pd2)

%Ejemplo sistema orden 3 con polo=0 y cero que modifica 
% clc
% clear
% s=tf('s');
% A=[0 0 0;1 0 -36;0 1 -15]
% B=[1000;100;0]
% C=[0 0 1]
% D=0;
% Gs=tf(ss(A,B,C,D)) %comvertimos EE a FT
% Mp=0.05; Ts=0.3;   %requisitos del sistema
% Polo3=-10;         %3er polo, se recomienda poner el mismo al cero  
% %anque el sistema el orden 3, al tener un polo en cero y un cero
% %se debe tratar como un sistema de 2do orden y tomar 3er polo en mismo
% %sitio del cero del sistema
% [K,A,B]=LocationPoleEE(Gs,Mp,Ts,2,Polo3)

%Ejemplo orden 2 con polos deseados como parametro
% s=tf('s');
% Gs=1/s^2
% [num den] = tfdata(Gs, 'v')
% Mp=0.046; Ts=1; % los valores Mp y Ts no importar pero deben ser
% diferente que cero
% [K,A,B]=LocationPoleEE(Gs,Mp,Ts,2,[-1-1i,-1+1i])

if((exist('Gs')==1)&&(Ts>=0)&&(Mp>=0))

s=tf('s');
[num den] = tfdata(Gs, 'v');
[A,B,C,D]=tf2ss(num,den);
%Order=length(pole(Gs));
%Ceros=zero(Gs);
%revisar si es controlable el sistema
Mc=ctrb(A,B);

if(length(pole(Gs))==rank(Mc))
   
   CTs=0.02; %Criterio ts
 

%polos deseados
[Sigma,Wd,Ts,Mp,Wn,Zeta]=MPandZeta(0,0,0,0,Ts,Mp,CTs);

if(Order==2)
      Controlabilidad=sprintf('controlable')   
      Gdeseada=1/((s^2+2*Zeta*Wn*s+Wn^2));
      
elseif(Order==3)
    Controlabilidad=sprintf('controlable')
    Gdeseada=1/((s^2+2*Zeta*Wn*s+Wn^2)*(s+Zeta*Wn));
end


if(rank(Pd)>0)
    if((length(Pd)==1)&&(Order==2))
       pld=pole(Gdeseada)';
       Polosdeseados=[pld(1),pld(2),Pd]
    else
       Polosdeseados=Pd 
    end
else

     Polosdeseados=pole(Gdeseada)'
     
end

%controlador
%cambiar a place que es mas confiable pero no admite polos iguales
%acker en menos confiable pero adminte polos iguales
K=acker(A,B,Polosdeseados);
Alc=A-B*K; 

%sistema controlado
Gc=ss(Alc,B,C,D);
PolosResultantes=pole(Gc)'
F=1/(dcgain(Gc))
close
step(F*Gc,Gs),legend('Sistema compensado','Sistema sin compensar')


disp('---------------------Parametros sistema compensado---------------------')
CriterioRiso=[0.10 0.90];
ParametroSys(F*Gc,CTs,CriterioRiso);

elseif(length(pole(Gs))>rank(Mc))
   Controlabilidad=sprintf('falta simplificar el sistema')
   K=0;
elseif(length(pole(Gs))<rank(Mc))
   Controlabilidad=sprintf('no controlable')
   K=0;
end



end





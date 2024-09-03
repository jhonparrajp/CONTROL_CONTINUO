function [C,Tc]=CompensadorMetodoAritmetico(Gs,PolosDeseados)
%PolosDeseados= polos deseados en LC
%Gs= funcion de transferencia en LO
%Tc=sistema compensado en LC
%C= Compensador resultante

%la funcion dara un resultado sin ceros en el sistema aplicando, una
%eliminacion del cero si es necesario

%Ejemplo polo deseado
% s=tf('s')
% PolosDeseados=[-1 -2 -3];
% Gs=10/(s^2-s);
% [C,Tc]=CompensadorMetodoAritmetico(Gs,PolosDeseados)

syms A3 A2 A1 A0 B2 B3 B1 B0
s=tf('s');
Np=length(pole(Gs));
[n d] = tfdata(Gs, 'v');
% if(Np==2){
Ms=[d(1) 0 n(1) 0;d(2) d(1) n(2) n(1);d(3) d(2) n(3) n(2);0 d(3) 0 n(3)]
PolinomioDeseado=poly(PolosDeseados)'
TcDeseada=1/(s^3*PolinomioDeseado(1)+s^2*PolinomioDeseado(2)+s*PolinomioDeseado(3)+PolinomioDeseado(4));
CoeficientesControlador=Ms\PolinomioDeseado;
A1=CoeficientesControlador(1);
A0=CoeficientesControlador(2);
B1=CoeficientesControlador(3);
B0=CoeficientesControlador(4);
C=zpk((B1*s+B0)/(A1*s+A0))
% }


% if(Np==3){
% Ms=[d(1) 0 n(1) 0;d(2) d(1) n(2) n(1);d(3) d(2) n(3) n(2);d(4) d(3) n(4) n(3);0 d(4) 0 n(4)]
% PolinomioDeseado=poly(PolosDeseados)'
% TcDeseada=1/(s^4*PolinomioDeseado(1)+s^3*PolinomioDeseado(2)+s^2*PolinomioDeseado(3)+s*PolinomioDeseado(4)+PolinomioDeseado(5))
% CoeficientesControlador=Ms\PolinomioDeseado
% A1=CoeficientesControlador(1);
% A0=CoeficientesControlador(2);
% B1=CoeficientesControlador(3);
% B0=CoeficientesControlador(4);
% C=zpk((B1*s+B0)/(A1*s+A0))
% }



Tc=minreal(feedback(C*Gs,1)) %%sistema modificado por el cero se le puede aplicar una eliminacion del cero
if(length(zero(Tc))==0)
    disp("--------------No se eliminimo un cero--------------")
    Cp=1 %creamos la eliminacion del cero
    Tc=minreal(Cp*Tc)
elseif(length(zero(Tc))==1)
    disp("--------------Se eliminimo un cero-----------------")
    Cp=-zero(Tc)/(s-zero(Tc)) %creamos la eliminacion del cero
    Tc=minreal(Cp*Tc)    
end

step(Tc,Gs),legend('Sistema compensado','Sistema sin compensar')
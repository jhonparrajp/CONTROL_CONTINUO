function [Phi,C]=LeadLagLGR(Gs,Sigma,Wd,RestaK)
%--------------Como usar-----------------------------
%Gs=Funcion de transferencia en lazo abiero
%Sigma=Sigma deseado en el sistema
%Wd=Frecuencia forzada deseada 
%RestaK=un parametro de ajuste de la ganancia del compensador,
%si desea disminuir la ganancia ingrese un numero negativo
%si desea aumentar la ganancia ingrese un numero positivo
%en caso que no quiera modificar la ganancia ingrese cero
%[Phi,C]=LeadLagLGR(Gs,Sigma,Wd,RestaK)
%---------------Ecuaciones---------------------------
%Estas escuaciones pueden ser utiles para obterner los polos deseados 
%Zeta=-log(Mp)/(sqrt(pi^2+log(Mp)^2))
%Zeta=Sigma/Wn
%Wn=sqrt(Sigma^2+Wd^2)
%Wn=Sigma/Zeta
%Wn=4.6/(Zeta*Wn)
%Sigma=Zeta*Wn
%Sigma=4.6/Ts
%Sigma=-Wd*log(Mp)/pi
%Wd=Wn*sqrt(1-Zeta^2)
%Wd=-Sigma*pi/(log(Mp))
%Wd=sqrt(Wn^2-Sigma^2)
%Tp=pi/Wd
%Ts=4.6/Sigma
%Ts=4.6/(Zeta*Wn)
%Mp=exp(-pi*Zeta/sqrt(1-Zeta^2))
%Mp=exp(-pi*Sigma/Wd)

%----------------Red Adelanto---------------------------
syms s
Zeta=Sigma/(sqrt(Sigma^2+Wd^2));
s=-Sigma+Wd*i;
Gss=tf2sym(Gs);
Phi=180-radtodeg(angle(eval(Gss))); %no puede ser mayor a 60
if(Phi>60)
disp('Se requiere un aporte mayor a 60°, es recomendable usar 2 compensadores en adelanto')    
else
end
Theta=radtodeg(asin(Zeta));
Alpha=(90+Theta)/2;
P=imag(s)/(tan(degtorad(Alpha)-degtorad(Phi)/2))-real(s);
Z=imag(s)/(tan(degtorad(Alpha)+degtorad(Phi)/2))-real(s);
C1=(s+Z)/(s+P);
Kc=abs(eval(1/(Gss*C1)))+RestaK;
s=tf('s');
C=zpk(-Z,-P,Kc);




function [C]=LeadLagLGR(Gs,Sigma,Wd,Kpd,Kvd,Kad,TipoR)
%Diseño de  1-adelanta-atraso, 2-adelanto y 3-atraso
%--------------Como usar-----------------------------
%[Phi,C]=LeadLagLGR(Gs,Sigma,Wd,Kpd,Kvd,Kad,RestaK)
%Gs=Funcion de transferencia en lazo abiero
%Sigma=Sigma deseado en el sistema
%Wd=Frecuencia forzada deseada 
%Kpd=Constante de error de posicion deseada
%Kvd=Constante de error de velocidad deseada
%Kad=constante de error de aceleracion deseada
%Phi=Angulo aportado por la red en adelanto
%C=Controlador resultante
%TipoR=1:Adelanto-atraso, 2:Adelanto , 3:atraso

%Para usar la funcion se necesita ingrear Sigma y Wd que seran los polos 
%deseados, luego se debe ingresar la constante de error requerida (Kpd,Kvd,Kad)
%y las demas constantes de error se asigna cero, tener en cuenta que el
%compensador calculado no siempre cumplira con los requisitos, este compensador
%puede ser un punto de partida para terminar de ajustar los parametros en
%herrmientas como rltool o siso tool


%Ejemplo: 
%Gs=4/(s*(s+0.5));
%Zeta=0.5; Wn=5; Kvd=80; %parametros deseados
%Sigma=Zeta*Wn
%Wd=Wn*sqrt(1-Zeta^2)
%rlocus(Gs),sgrid(Zeta,0)
%[Phi,C]=LeadLagLGR(Gs,Sigma,Wd,0,Kvd,0)
% s=tf('s');
% GsC=C*Gs; %aplicando el compensador en lazo abierto
% Tc=feedback(GsC,1); %Sistema compensado
% Tk=feedback(Gs,1); %Sistema sin compensar
% Su=feedback(C,Gs); %señal de control
% KvR=dcgain(s*GsC) %constante error de velocidad resultante
% figure(2)
% subplot(121),step(Tc,Tk),legend 
% subplot(122),step(Su),legend



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

Zeta=Sigma/(sqrt(Sigma^2+Wd^2));
if(TipoR==1)
 %----------------Red adelanta atraso------------------------------
 disp('Red adelanta-atraso') 
syms s %red adelanto metodo bisectriz
s=-Sigma+Wd*i;
Gss=tf2sym(Gs); %convierto la funcion de transferencia a una funcion simbolica
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
Kc=abs(eval(1/(Gss*C1)));
s=tf('s');
CLead=zpk(-Z,-P,Kc);


GsC=CLead*Gs;
sx=-Sigma+Wd*j;
%Se calcula la constante de error actual del sistema
if (Kpd>0) 
Kac=dcgain(GsC);
Kd=Kpd;
elseif(Kvd>0)
Kac=dcgain(s*GsC);
Kd=Kvd;
elseif(Kad>0) 
Kac=dcgain(s^2*GsC);
Kd=Kad;
end 

Z1=Sigma/10; %Zero una decada del polo deseado

Beta=Kd/Kac; %se calcula el factor Beta
P1=Z1/Beta;  %se calcula el polo de compensador

%se calcula el valor de la ganancia del compensador en atraso
s=sx; 
C1=(s+Z1)/(s+P1);
Gss=tf2sym(GsC); %convierto la funcion de transferencia a una funcion simbolica
Kc1=abs(eval(1/(Gss*C1)));
RelaAngulo=radtodeg(angle(Kc1*C1));

%se obtiene el controlador
s=tf('s');
C=zpk([-Z -Z1],[-P -P1],Kc*Kc1);

%--------------------Red adelanto------------------------------
elseif(TipoR==2)
disp('Red adelanto') 
syms s %red adelanto metodo bisectriz
Zeta=Sigma/(sqrt(Sigma^2+Wd^2));
s=-Sigma+Wd*i;
Gss=tf2sym(Gs); %convierto la funcion de transferencia a una funcion simbolica
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
Kc=abs(eval(1/(Gss*C1)));
s=tf('s');
C=zpk(-Z,-P,Kc);


%--------------Red atraso-----------------------------------   
elseif(TipoR==3)
s=tf('s')    
    sx=-Sigma+Wd*j;
%Se calcula la constante de error actual del sistema
if (Kpd>0) 
Kac=dcgain(Gs);
Kd=Kpd;
elseif(Kvd>0)
Kac=dcgain(s*Gs);
Kd=Kvd;
elseif(Kad>0) 
Kac=dcgain(s^2*Gs);
Kd=Kad;
end 

Z1=Sigma/10; %Zero una decada del polo deseado

Beta=Kd/Kac %se calcula el factor Beta
P1=Z1/Beta;  %se calcula el polo de compensador

%se calcula el valor de la ganancia del compensador en atraso
s=sx; 
C1=(s+Z1)/(s+P1);
Gss=tf2sym(Gs); %convierto la funcion de transferencia a una funcion simbolica
Kc1=abs(eval(1/(Gss*C1)));
RelaAngulo=radtodeg(angle(Kc1*C1));
C=zpk(-Z1,-P1,Kc1);

end    


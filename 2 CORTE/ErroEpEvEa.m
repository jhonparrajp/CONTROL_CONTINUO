function [Ep,Ev,Ea,Kp,Kv,Ka]=ErroEpEvEa(Gs)

syms s
Gss=tf2sym(Gs);
Kp=Gss;
Kv=s*Gss;
Ka=s^2*Gss;
s=0;
Ep=eval(1/(1+Kp));
Ev=eval(1/(Kv));
Ea=eval(1/(Ka));
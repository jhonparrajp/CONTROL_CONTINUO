
clc
t=0:tm:t_fi;                        %parametros de tiempo
for K=K_li:In_K:K_ls                %K  Ganancia
    for a=a_li:In_a:a_ls            %a: cero
       num=...;        %Numerador
       den=...;         %Denomindor 
       lt=length(t);
       y=step(num,den,t);
   while(y(lt)>0.98&&y(lt)<1.02)  %criterio 2%
   lt=lt-1;
   end
   ts=(lt-1)*tm;
   p=max(y);      %obtenet p
   if((p<1+Mp)&&(p>11)&&(ts<M_ts))   %Delimitar 1% <p <Mp% y M_ts
   k=k+1;
   C_PID(k,:)=[k a p ts];
   end    
   end
   
end
C_PID

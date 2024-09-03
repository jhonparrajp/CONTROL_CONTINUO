function [Ts,Tr,Mp,Tp,Taho,ValorF]=ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso)
%ProcentajeCriterioTs=[0.01] criterio del tiempo de establecimiento al 1%
%CriterioRiso=[0.1 0.9]    criterio del tiempo de riso del 10 al 90%
%[Resultados,Ts,Tr,Mp,Tp,Taho,ValorF]=ParametroSys(Gs,ProcentajeCriterioTs,CriterioRiso)
damp(Gs)
Parametros=stepinfo(Gs,'SettlingTimeThreshold',ProcentajeCriterioTs,'RiseTimeThreshold',CriterioRiso);
Ts=Parametros.SettlingTime;
Tr=Parametros.RiseTime;
Mp=Parametros.Overshoot;
Tp=Parametros.PeakTime;
Taho=Ts/4.6; %C/(Wn*.zeta)  %para, C=4.6-->1%, 4-->2%, 3-->5%, -ln(0.1)-->90% ,2-->86%
ValorF=dcgain(Gs);
Resultados=sprintf('\nTs(%.2f)=%.4f\nTr=%.4f\nMp=%.4f\nTp=%.4f\nTao=%.4f\nValorF=%.4f\n',ProcentajeCriterioTs*100,Ts,Tr,Mp,Tp,Taho,ValorF)
function [G]=Consultar(Sys)
    close all,clear Z
    Z=step(Sys);
    step(Sys)
    zpk(Sys)
    info=stepinfo(Sys);
    if any(isstable(Sys) == 0),disp(' Sistema NO es estable'),else,disp('El Sistema Estable'),end
    sobrepico=info.Overshoot
    tiempoRiso=info.RiseTime
    tiempoEstablecimiento=info.SettlingTime
    tiempoEstablecimientoMax=info.SettlingMax
    tiempoEstablecimientoMin=info.SettlingMin
    tiempoPico=info.PeakTime
    ErrorSistema=(1-round(Z(length(Z)),2))*100
    s=tf('s');
s=tf('s');
[Num Den]=linmod('untitled');
GT=tf(Num,Den)

% ESTAS SON LAS GRAFICAS A

impulse(GT)

step(GT)
clc

a = 5.52085

s = tf('s');
G = 16/(s*(s+a));
T = feedback(G,1);
[numT,denT] = tfdata(T, 'v');
omegaN = sqrt(denT(3));
zeta = denT(2)/(2*omegaN);
pOS = exp(-zeta*pi()/sqrt(1-zeta^2))*100
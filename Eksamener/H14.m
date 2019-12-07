%%
%Oppgave 1a Finne TF vha step input på annet enn 1.
p_OS = (5.8-4.5)/4.5*100
Tp = 0.4;

zeta=-log(p_OS/100)/sqrt(pi^2+log(p_OS/100)^2)
omegaN = pi()/(Tp*sqrt(1-zeta^2))

C = omegaN^2/(s^2+2*zeta*omegaN*s+omegaN^2)

[num, den] = tfdata(C)
num = cell2mat(num)*4.5/2.5

G = tf(num,den)
step(G)


%%
%Oppgave 1c

zeta = 0.35; omegaN = 12;

Tp = pi()/(omegaN*sqrt(1-zeta^2))
p_OS = exp(-zeta*pi()/sqrt(1-zeta^2))*100
Ts = 4/(zeta*omegaN)
Tr = (1.76*zeta^3-0.417*zeta^2+1.034*zeta+1)/omegaN

%%
%Oppgave 1d

syms R L C s

Vtot = simplify(zum(R,(L*s+1/(C*s))))

Vc = simplify(Vtot*1/(C*L*s^2+1))
pretty(Vc)

%%
%Oppgave 2a
clear all
clc

syms K
s = tf('s')

G1 = 1/s;
G2 = 2/(s^2+2*s+2);
G = G1*G2
T = feedback(G,1)

A = [1 2;2 2*K];
Routh(A)

%%
%Oppgave 2c
clear all
clc
s = tf('s');

G = 5425.7*(s+0.2)/((s+12)^2*(2*s+3))
bode(G)

%%
%Oppgave 2d
clear 
clc
s = tf('s');
Kp = 0.25; Tp = 2.5;

Kr = 4/Kp
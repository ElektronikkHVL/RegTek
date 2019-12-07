function y = sprangrespons2(polynom)

G = polynom;

%Naturlige frekvenser: omega_n
%Dempingsfaktor zeta
%Rise time: Tr
%Peak time: Tp
%Percent overshoot: p_OS
%settling Time: Ts

%num = [255]
%den = [1 15 225]
%G = tf(num,den)
step(G)
[numg, deng] = tfdata(G,'v');
omega_n = sqrt(deng(3));

zeta = deng(2)/(2*omega_n);
%Gitt p_OS: zeta=-log(p_OS/100)/sqrt(pi^2+log(p_OS/100)^2)

Tr =(1.76*zeta^3-0.417*zeta^2+1.039*zeta+1)/(omega_n);

Tp = pi/(omega_n*sqrt(1-zeta^2));

p_OS = (exp(-zeta*pi/sqrt(1-zeta^2)))*100;

Ts = -log(0.02*sqrt(1-zeta^2))/(zeta*omega_n);

disp(["Rise Time" "Peak time" "Settling Time" "Percent Overshoot" "zeta" "Omega_n";Tr Tp Ts p_OS zeta omega_n])
y = [Tr Tp Ts p_OS zeta omega_n];

%% LAG-compensation achieving desired phasemargin
% run sections one by one
clear
clc
Wc_min=-2
Wc_max = 3
clf(figure(1))
clf(figure(2))
phase_M=45   % decided from specifications
phase_LAG=6  % phase contribution from LAG-filter one decade after wz
phase=-180 + phase_M + phase_LAG
%% Transfer function before compensation
K=20
G=zpk([],[0 -1 -5],[K])
figure(1)
bode(G,logspace(Wc_min,Wc_max,10000))
%grid on
%margin(G)
'Stationary accuracy'
Kp=dcgain(G)
s=zpk([0],[],[1]);
Kv=dcgain(s*G)
Ka=dcgain(s^2*G)
%% Dimentioning LAG-filter
% observe the bode-plot
% find |G| at frequency: -180+ phase_M + phase_LAG
% this frequency is our new wc
% LAG must reduce |G| by this magnitude |G|
figure(1)
hold on figure(1)
% Data from bode-plot
wc_new=0.625         % new crossover frequency
K_LAG=1/(10^(14.7/20))        % Avlest: |G(wc_ny)|
% Parameters of LAG is based on these two values
wz=wc_new/10     % the zero is one decade lower than wc_new
wp=wz*K_LAG      % wp (the pole) must be places such that |G_LAG(0)|=1=0dB
G_LAG=zpk([-wz],[-wp],[K_LAG])
bode(G_LAG,logspace(Wc_min,Wc_max,10000))
%% Kompensert transferfunksjon
G_COMP=G_LAG*G
figure(1)
bode(G_COMP,logspace(Wc_min,Wc_max,10000))
'Stationary accuracy'
Kp=dcgain(G)
s=zpk([0],[],[1]);
Kv=dcgain(s*G)
Ka=dcgain(s^2*G)
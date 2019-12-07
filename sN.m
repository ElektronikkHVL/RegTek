function y = sN(polynom)

G = polynom;

%G = 500*[(s+2)*(s+5)]/[(s+8)(s+10)(s+12)] --Ingen integrasjon

%G = 500*[(s+2)*(s+5)]/[s*(s+8)(s+10)(s+12)]  -- En integrasjon

%G = 500*[(s+2)*(s+5)]/[s^(2)*(s+8)(s+10)(s+12)]  -- To integrasjoner

%G = zpk([-2 -5],[0 0 -8 -10 -12],[500]);

G0 = 20*log10(dcgain(G)) %Gain for lavere frekvenser i dB.

[numg, deng] = tfdata(G,'v')

%Sjekker stabilitet:
T = feedback(G,1,-1)

poles = pole(T)
step(T)


'STEP input'
kp = dcgain(G)
ess =1/(1+kp)

'rampe input'
numsg = conv(numg,[1 0]);
densg = deng;
sG = tf(numsg,densg);
sG = minreal(sG)
kv = dcgain(sG)
ess = 1/kv

'Parabolic step'

nums2g = conv(numg,[1 0 0]);
dens2g = deng;
s2G = tf(nums2g,dens2g);
s2G = minreal(s2G)
ka = dcgain(s2G)
ess = 1/ka
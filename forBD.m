clc

G1 = tf([1],[1 0 0]);
G2 = tf([50],[1 1]);
G3 = tf([1 0],[1]);
G4 = tf([2],[1]);
H1 = tf([2],[1 0]);
H2 = tf([2],[1]);
G5 = tf([1],[1]);
G6 = tf([1],[1]);
%               1   2  3  4 5  6   7  8
System = append(G1,G2,G3,G4,H1,G5,G6); % Her er systemet

input = 6;      %Systemets input
output = 7;     %Systemets output

Q = [1 6 -5
     2  1 -5
     3 2 0
     4 2 0
     5 2 0
     6 -7 0
     7 3 4
     ];        %Systemets koblingsmatrise
 
 T1 = connect(System,Q,input,output)
 T = tf(T1);
 T = minreal(T)
 
 [numT, denT] = tfdata(T,'v')
 roots(denT)
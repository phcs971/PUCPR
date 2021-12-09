clc
clear

K = 0.838;
T = 0.194;
tau = 0.877;

G = tf(K, [tau 1], "InputDelay", T);

Kp = 6.466;
Ti = 0.389;
Td = 0.097;

C = tf(Kp, 1) + tf(Kp, [Ti 0]) + tf([Kp*Td 0], 1)

P = feedback(C * G, 1);

step(P)